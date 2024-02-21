drop table if exists `linen-source-411501.taxi_data_all.fhv_data`;
create table `linen-source-411501.taxi_data_all.fhv_data` 
partition by date(cast(pickup_datetime as datetime)) as
select 
  dispatching_base_num , 
  cast(pickup_datetime as datetime) pickup_datetime , 
  cast(dropOff_datetime as datetime) dropOff_datetime , 
  PUlocationID, 
  DOlocationID, 
  SR_Flag, 
  Affiliated_base_number
FROM `linen-source-411501.taxi_data_all.fhv_data_nonpartitioned`
;

select * from `linen-source-411501.taxi_data_all.fhv_data` limit 10;