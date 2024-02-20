{{
    config(
        materialized='view'
    )
}}

/*
* Create a staging model for the fhv data, 
* similar to the ones made for yellow and green data. 
* Add an additional filter for keeping only records with pickup time in year 2019. 
* Do not add a deduplication step. 
* Run this models without limits (is_test_run: false).
*/

with fhv_data as 
(
  select *
  from {{ source('staging','fhv_data') }}
  WHERE pickup_datetime >= DATETIME("2019-01-01") 
  AND pickup_datetime < DATETIME("2020-01-01") 
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['pulocationid', 'pickup_datetime']) }} as dispatchid,
    {{ dbt.safe_cast("pulocationid", api.Column.translate_type("integer")) }} as pickup_locationid,
    {{ dbt.safe_cast("dolocationid", api.Column.translate_type("integer")) }} as dropoff_locationid,

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,

    -- trip info
    dispatching_base_num,
    affiliated_base_number,
    sr_flag
from fhv_data

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}