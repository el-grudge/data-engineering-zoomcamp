WITH ranked_zones AS (
    SELECT
        pickup_zone,
        dropoff_zone,
        average_trip_time,
        ROW_NUMBER() OVER (ORDER BY average_trip_time DESC) AS rank
    FROM
        trip_time_statistics
)
SELECT
    pickup_zone,
    dropoff_zone,
    average_trip_time
FROM
    ranked_zones
WHERE
    rank = 1;
