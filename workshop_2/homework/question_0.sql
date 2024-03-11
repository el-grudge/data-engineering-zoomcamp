WITH latest_dropoff AS (SELECT max(tpep_dropoff_datetime) - INTERVAL '1 minutes' max FROM trip_data) 
SELECT a.zone 
FROM taxi_zone a
inner join trip_data b
on a.location_id = b.dolocationid, latest_dropoff 
WHERE b.tpep_dropoff_datetime > max;

