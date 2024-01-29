
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

