DROP TABLE IF EXISTS `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`;
CREATE TABLE  `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned` as
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`;

insert into  `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned` 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`; 

  -- Fixes yellow table schema
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

-- Partition yellow table
DROP TABLE IF EXISTS `linen-source-411501.taxi_data_all.yellow_tripdata`;
CREATE TABLE `linen-source-411501.taxi_data_all.yellow_tripdata`
PARTITION BY DATE(tpep_pickup_datetime) AS
SELECT *
FROM `linen-source-411501.taxi_data_all.yellow_tripdata_nonpartitioned`;


select * from `linen-source-411501.taxi_data_all.yellow_tripdata` limit 10;