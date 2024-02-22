with cte_fhv as (
SELECT 
  date(DATE_TRUNC(pickup_datetime, MONTH)) AS month, 
  "FHV" as service_type , 
  count(distinct dispatchid) as trips
FROM `linen-source-411501.dbt_msonbol.fact_fhv`
group by 1, 2
), cte_trips as (
SELECT 
  date(DATE_TRUNC(pickup_datetime, MONTH)) AS month, 
  service_type , 
  count(distinct tripid) as trips
from `linen-source-411501.dbt_msonbol.fact_trips`
group by 1, 2
), unioned as (
select * from cte_fhv a
union all
select * from cte_trips b 
)
select *
from unioned
where month >= '2019-06-01'
and month < '2019-09-01'
order by 1, 2
;
