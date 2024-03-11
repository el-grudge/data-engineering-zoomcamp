WITH latest_dropoff AS (SELECT max(tpep_pickup_datetime) - INTERVAL '17 hours' max FROM trip_data) 
SELECT b.zone, count(*)
FROM latest_dropoff , trip_data a
inner join taxi_zone b
on a.pulocationid = b.location_id
inner join taxi_zone c
on a.dolocationid = c.location_id
WHERE a.tpep_dropoff_datetime >= max
group by 1
order by 2 desc
limit 3
;

