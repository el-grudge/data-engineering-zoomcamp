{{
    config(
        materialized='table'
    )
}}

with green_tripdata as (
    select 
        pickup_locationid, 
        dropoff_locationid,
        pickup_datetime, 
        dropoff_datetime,  
        'Green' as service_type
    from {{ ref('stg_green_tripdata') }}
), 
yellow_tripdata as (
    select 
        pickup_locationid,
        dropoff_locationid,
        pickup_datetime,
        dropoff_datetime, 
        'Yellow' as service_type
    from {{ ref('stg_yellow_tripdata') }}
), 
fhv_data as (
    select 
        pickup_locationid,
        dropoff_locationid,
        pickup_datetime,
        dropoff_datetime,      
        'Fhv' as service_type
    from {{ ref('stg_fhv_data') }}
),
trips_unioned as (
    select * from green_tripdata
    union all 
    select * from yellow_tripdata
    union all 
    select * from fhv_data
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select 
    trips_unioned.service_type,
    trips_unioned.pickup_locationid,
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    trips_unioned.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    trips_unioned.pickup_datetime,
    trips_unioned.dropoff_datetime
from trips_unioned
inner join dim_zones as pickup_zone
on trips_unioned.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips_unioned.dropoff_locationid = dropoff_zone.locationid