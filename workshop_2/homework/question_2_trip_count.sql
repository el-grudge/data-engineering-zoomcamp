WITH max_avg AS (SELECT max(average_trip_time) max FROM trip_time_statistics_with_count) 
SELECT trip_count FROM trip_time_statistics_with_count, max_avg 
WHERE average_trip_time = max;
