drop table if exists `linen-source-411501.trips_data_all.fhv_data_nonpartitioned`;
create table `linen-source-411501.trips_data_all.fhv_data_nonpartitioned` as
select 
  dispatching_base_num , 
  cast(pickup_datetime as datetime) pickup_datetime , 
  cast(dropOff_datetime as datetime) dropOff_datetime , 
  PUlocationID, 
  DOlocationID, 
  SR_Flag, 
  Affiliated_base_number
FROM `linen-source-411501.trips_data_all.fhv_data`
;

drop table if exists `linen-source-411501.trips_data_all.fhv_data`;
create table `linen-source-411501.trips_data_all.fhv_data`
partition by date(pickup_datetime) as
 SELECT *
 FROM `linen-source-411501.trips_data_all.fhv_data_nonpartitioned`
; 
