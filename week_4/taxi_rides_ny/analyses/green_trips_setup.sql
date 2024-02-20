-- MAKE SURE YOU REPLACE linen-source-411501 WITH THE NAME OF YOUR DATASET! 
-- When you run the query, only run 5 of the ALTER TABLE statements at one time (by highlighting only 5). 
-- Otherwise BigQuery will say too many alterations to the table are being made.

DROP TABLE IF EXISTS `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`;
CREATE TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`; 

insert into  `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020` ;

  -- Fixes green table schema
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

-- Partition green table
DROP TABLE IF EXISTS `linen-source-411501.trips_data_all.green_tripdata`;
CREATE TABLE `linen-source-411501.trips_data_all.green_tripdata`
PARTITION BY DATE(lpep_pickup_datetime) AS
SELECT *
FROM `linen-source-411501.trips_data_all.green_tripdata_nonpartitioned`;

SELECT * FROM `linen-source-411501.trips_data_all.green_tripdata` LIMIT 10;

