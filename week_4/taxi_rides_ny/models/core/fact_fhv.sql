/*
* Create a core model similar to fact trips, 
* but selecting from stg_fhv_tripdata and joining with dim_zones. 
* keep only records with known pickup and dropoff locations 
* Run the dbt model without limits (is_test_run: false).
*/

{{
    config(
        materialized='table'
    )
}}

with fhv_data as (
    select *, 
        'Fhv' as service_type
    from {{ ref('stg_fhv_data') }}
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    fhv_data.dispatchid, 
    fhv_data.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    fhv_data.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    fhv_data.pickup_datetime, 
    fhv_data.dropoff_datetime, 
    fhv_data.dispatching_base_num,
    fhv_data.affiliated_base_number,
    fhv_data.sr_flag
from fhv_data
inner join dim_zones as pickup_zone
on fhv_data.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv_data.dropoff_locationid = dropoff_zone.locationid