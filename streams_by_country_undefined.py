#!/usr/bin/env python

dataset="example"
table="streams_by_country_undefined"
use_legacy_sql = False

description="Number of streams per country"
schema=dict(
  country="Spotify market",
  num_streams="Number of daily streams",
 )

query='''
SELECT country, count(*) num_streams 
FROM `content-value-prod.endsong.endsong_mapped_20170404` 
GROUP BY country
'''