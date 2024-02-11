
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `linen-source-411501.nytaxi.green_tripdata_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://linen_source_411501_bucket/green-taxi-2022']
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_tripdata_nonpartitioned AS
SELECT * FROM linen-source-411501.nytaxi.green_tripdata_external;

-- Question 1: What is count of records for the 2022 Green Taxi Data??
SELECT count(*) FROM linen-source-411501.nytaxi.green_tripdata_external;

-- Question 2. What is the estimated amount of data in the tables?
SELECT count(distinct PULocationID) FROM linen-source-411501.nytaxi.green_tripdata_external;

SELECT count(distinct PULocationID) FROM linen-source-411501.nytaxi.green_tripdata_nonpartitioned;

-- Question 3. How many records have a fare_amount of 0?
SELECT count(*) FROM linen-source-411501.nytaxi.green_tripdata_nonpartitioned where fare_amount = 0;

-- Question 4. What is the best strategy to make an optimized table in Big Query?


-- Creating a partition and cluster table
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM linen-source-411501.nytaxi.green_tripdata_external;

-- Query scans 1.1 GB
SELECT count(*) as trips
FROM linen-source-411501.nytaxi.green_tripdata_partitoned_clustered
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
  AND PUlocationID=1;
