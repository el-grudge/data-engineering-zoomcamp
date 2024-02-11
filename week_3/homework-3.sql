
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `linen-source-411501.nytaxi.green_trips_2022_external`(
  vendor_id                         int64,
  lpep_pickup_datetime          TIMESTAMP,
  lpep_dropoff_datetime         TIMESTAMP,
  store_and_fwd_flag               string,
  ratecode_id                     float64,
  pulocation_id                     int64,
  dolocation_id                     int64,
  passenger_count                 float64,
  trip_distance                   float64,
  fare_amount                     float64,
  extra                           float64,
  mta_tax                         float64,
  tip_amount                      float64,
  tolls_amount                    float64,
  ehail_fee                        string,
  improvement_surcharge           float64,
  total_amount                    float64,
  payment_type                    float64,
  trip_type                       float64,
  congestion_surcharge            float64
)
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://linen_source_411501_bucket/green_taxi_2022/*parquet']
);

select * from linen-source-411501.nytaxi.green_trips_2022_external limit 5;

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_nonpartitioned AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;

select * from linen-source-411501.nytaxi.green_trips_2022_nonpartitioned limit 5;

-- Question 1: What is count of records for the 2022 Green Taxi Data??
SELECT count(*) FROM linen-source-411501.nytaxi.green_trips_2022_nonpartitioned;

-- Question 2. What is the estimated amount of data in the tables?
SELECT count(distinct pulocation_id) FROM linen-source-411501.nytaxi.green_trips_2022_external;

SELECT count(distinct pulocation_id) FROM linen-source-411501.nytaxi.green_trips_2022_nonpartitioned;

-- Question 3. How many records have a fare_amount of 0?
SELECT count(*) FROM linen-source-411501.nytaxi.green_trips_2022_nonpartitioned where fare_amount = 0;

-- Question 4. What is the best strategy to make an optimized table in Big Query?
-- Partition by lpep_pickup_datetime Cluster on PUlocationID (other parition strategies were tested, you can see the results in q4-partition-strategies.sql.sql)
CREATE OR REPLACE TABLE linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY pulocation_id
AS
SELECT * FROM linen-source-411501.nytaxi.green_trips_2022_external;

-- Query scans = 64.84 MB
SELECT *
FROM linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-12-31'
order by pulocation_id
;

-- Question 5. What's the size of the tables?
-- scans = 12.82 MB
select distinct pulocation_id
from linen-source-411501.nytaxi.green_trips_2022_nonpartitioned
where lpep_pickup_datetime >= '2022-06-01' and lpep_pickup_datetime < '2022-07-01';

-- scans = 1.12 MB
select distinct pulocation_id
from linen-source-411501.nytaxi.green_trips_2022_partitioned_clustered
where lpep_pickup_datetime >= '2022-06-01' and lpep_pickup_datetime < '2022-07-01';


-- Question 6. Where is the data stored in the External Table you created?
-- GCP Bucket

-- Question 7. It is best practice in Big Query to always cluster your data
-- FALSE

-- Question 8. How many bytes does it estimate will be read? Why?
-- Bytes processed = 0; BigQuery is able to retrieve the record count from the table's metadata, this is possible because our query doesn't require any processing to apply a filter condition or to retrieve data  