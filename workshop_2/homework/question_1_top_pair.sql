WITH top_pair AS (SELECT max(average_trip_time) max FROM trip_time_statistics)
SELECT
    pickup_zone,
    dropoff_zone,
    average_trip_time
FROM
    trip_time_statistics, top_pair
WHERE
    average_trip_time = max;

