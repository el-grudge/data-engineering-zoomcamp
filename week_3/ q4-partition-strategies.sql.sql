-- Cluster on lpep_pickup_datetime Partition by pulocation_id
-- Creating a partition and cluster table
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_1
PARTITION BY RANGE_BUCKET(pulocation_id, GENERATE_ARRAY(1, 265, 1))
CLUSTER BY lpep_pickup_datetime
AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;

-- Partition by lpep_pickup_datetime Cluster on PUlocationID
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_2
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY pulocation_id
AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;

-- Partition by lpep_pickup_datetime and Partition by PUlocationID
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_3
PARTITION BY (DATE(lpep_pickup_datetime), RANGE_BUCKET(pulocation_id, GENERATE_ARRAY(1, 265, 1)))
AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;

-- Cluster on by lpep_pickup_datetime and Cluster on PUlocationID
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_4
CLUSTER BY lpep_pickup_datetime, pulocation_id
AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;


-- Query scans = 114.11 MB
SELECT *
FROM linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_1
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
order by pulocation_id
;

-- Query scans = 64.84 MB
SELECT *
FROM linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_2
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
order by pulocation_id
;

-- Query scans = n/a
SELECT *
FROM linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_3
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
order by pulocation_id
;

-- Query scans = 114.11 MB
SELECT *
FROM linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered_4
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
order by pulocation_id
;