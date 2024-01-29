
## Question 1. Knowing docker tags

### Answer 

Run the following commands

```
docker build --help | grep "Automatically remove the container when it exits"
docker run --help | grep "Automatically remove the container when it exits"
```

**solution**: - `--rm`

## Question 2. Understanding docker first run 

### Answer 

Run the following commands

```
docker run -it python:3.9 /bin/bash
pip list | grep wheel
```

**solution**: - 0.42.0

## Question 3. Count records 

### Answer 

Run the following query

```
select count(*)
from green_taxi_trips
where lpep_pickup_datetime::date = '2019-09-18'
and lpep_dropoff_datetime::date = '2019-09-18'
limit 5
;
```

**solution**: - 15612

## Question 4. Largest trip for each day

### Answer 

Run the following query

```
select lpep_pickup_datetime::date, sum(trip_distance) total_trip_distance
from green_taxi_trips
group by 1
order by 2 desc
limit 5
;
```

**solution**: - 2019-09-26

## Question 5. Three biggest pick up Boroughs

### Answer 

Run the following query

```
with cte as (
select a.* , b."Borough"
from green_taxi_trips a 
left join zones b 
on a."PULocationID" = b."LocationID"
where lpep_pickup_datetime::date = '2019-09-18'
and "Borough" <> 'Unknown'
)
select "Borough", sum(total_amount)
from cte
group by 1
having sum(total_amount) > 50000
;
```

**solution**: - "Brooklyn" "Manhattan" "Queens"

## Question 6. Largest tip

### Answer 

Run the following query

```
with cte as (
select a.lpep_pickup_datetime , tip_amount , b."Zone" as PUZone, c."Zone" as DOZone
from green_taxi_trips a 
left join zones b 
on a."PULocationID" = b."LocationID"
left join zones c
on a."DOLocationID" = c."LocationID"
where lpep_pickup_datetime::date >= '2019-09-01'
and lpep_pickup_datetime::date < '2019-10-01'
and b."Zone" = 'Astoria'
)
select dozone, tip_amount
from cte
order by 2 desc
limit 5
;
```

**solution**: - JFK Airport

## Question 7. Creating Resources

### Answer 

> Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ create
> 
> Terraform will perform the following actions:
> 
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\# google_bigquery_dataset.demo_dataset will be created  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ resource "google_bigquery_dataset" "demo_dataset" {  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ creation_time              = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ dataset_id                 = "linen_source_411501_dataset"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ default_collation          = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ delete_contents_on_destroy = false  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ effective_labels           = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ etag                       = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ id                         = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ is_case_insensitive        = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ last_modified_time         = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ location                   = "US"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ max_time_travel_hours      = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ project                    = "linen-source-411501"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ self_link                  = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ storage_billing_model      = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ terraform_labels           = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
> 
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\# google_storage_bucket.demo-bucket will be created  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ resource "google_storage_bucket" "demo-bucket" {  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ effective_labels            = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ force_destroy               = true  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ id                          = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ location                    = "US"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ name                        = "linen_source_411501_bucket"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ project                     = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ public_access_prevention    = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ self_link                   = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ storage_class               = "STANDARD"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ terraform_labels            = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ uniform_bucket_level_access = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ url                         = (known after apply)  
> 
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ lifecycle_rule {  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ action {  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ type = "AbortIncompleteMultipartUpload"  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ condition {  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ age                   = 1  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ matches_prefix        = []  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ matches_storage_class = []  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ matches_suffix        = []  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\+ with_state            = (known after apply)  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\}  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\}  
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\}  
> 
> Plan: 2 to add, 0 to change, 0 to destroy.
> 
> Do you want to perform these actions?
>   Terraform will perform the actions described above.
>   Only 'yes' will be accepted to approve.
> 
>   Enter a value: yes
> 
> google_bigquery_dataset.demo_dataset: Creating...  
> google_storage_bucket.demo-bucket: Creating...  
> google_storage_bucket.demo-bucket: Creation complete after 1s [id=linen_source_411501_bucket]  
> google_bigquery_dataset.demo_dataset: Creation complete after 1s [id=projects/linen-source-411501/datasets/linen_source_411501_dataset]  
> 
> Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
