CREATE MATERIALIZED VIEW trip_time_statistics_with_count AS
SELECT
    tz1.zone AS pickup_zone,
    tz2.zone AS dropoff_zone,
    COUNT(*) AS trip_count,
    AVG(EXTRACT(EPOCH FROM (td.tpep_dropoff_datetime - td.tpep_pickup_datetime))) AS average_trip_time,
    MIN(EXTRACT(EPOCH FROM (td.tpep_dropoff_datetime - td.tpep_pickup_datetime))) AS min_trip_time,
    MAX(EXTRACT(EPOCH FROM (td.tpep_dropoff_datetime - td.tpep_pickup_datetime))) AS max_trip_time
FROM
    trip_data td
JOIN
    taxi_zone tz1 ON td.pulocationid = tz1.location_id
JOIN
    taxi_zone tz2 ON td.dolocationid = tz2.location_id
GROUP BY
    tz1.zone, tz2.zone;
