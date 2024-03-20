select 
	a.result__ad_data__ad_entityid as id ,
	a.result__ad_data__ad_pageid as page_id, 
	a.result__page_data__url_full as url, 
	b.title as salary ,
	b.original_published as published_date_unix, 
	b.published_formatted as published_date,
	c.content__alt_title as breakdown,
	c.content__resource as png_url 
from money_diaries_test.blog_entry a 
inner join money_diaries_test.blog_entry__result__content__entries b
on a.result__ad_data__ad_entityid = b.id 
and a._dlt_id = b._dlt_parent_id
inner join money_diaries_test.blog_entry__result__content__entries__sections__body c 
on b._dlt_id = c._dlt_parent_id
and c.content__asset_id is not null
and lower(c.content__alt_title ) like '%breakdown%'
;
