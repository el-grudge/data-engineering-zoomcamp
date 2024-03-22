{{
    config(
        materialized='view'
    )
}}

with blogs as 
(
  select 
    result__ad_data__ad_entityid as id ,
	  result__ad_data__ad_pageid as page_id, 
	  result__page_data__url_full as url ,
    _dlt_id
  from {{ source('staging','blog_entry') }}
), entries as (
  select 
    id ,
    title as salary ,
    original_published as published_date_unix, 
    published_formatted as published_date ,
    _dlt_id,
    _dlt_parent_id
  from {{ source('staging','blog_entry__result__content__entries') }}
), content as (
  select 
    content__alt_title as breakdown,
	  content__resource as png_url ,
    _dlt_parent_id
  from {{ source('staging','blog_entry__result__content__entries__sections__body') }}
  where content__asset_id is not null
  and lower(content__alt_title ) like '%breakdown%'
)
select 
  blogs.id ,
  page_id ,
  url ,
  salary ,
  published_date_unix ,
  published_date ,
  breakdown ,
  png_url
from blogs 
inner join entries 
on blogs.id = entries.id
and blogs._dlt_id = entries._dlt_parent_id
inner join content 
on entries._dlt_id = content._dlt_parent_id