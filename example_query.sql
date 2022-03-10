select count(*) total_releases_in_2015,
    countif(is_available=True) currently_available_2015_releases,
    countif(has_US_sale_period=True) have_US_availability,
    countif(currently_available_in_US) currently_available_in_US
from
    (
    SELECT 
        (select coalesce(max(true),false) from unnest(album.sale_periods) as sp 
        where sp.service in ('ad', 'subscription')
        AND ARRAY_LENGTH(album.sale_periods) > 0
        and (sp.end is NULL or 
        FORMAT_TIMESTAMP("%F",TIMESTAMP_MILLIS(if(sp.end between -2208988800000 and 4102444800000,sp.end,null)))
            >='2018-06-01')) is_available,
            
        (select coalesce(max(true),false) from unnest(album.sale_periods) as sp 
        where sp.countries is null or sp.countries like '%US%') has_US_sale_period,
        
        (
        select coalesce(max(true),false) from unnest(album.sale_periods) as sp 
        where sp.service in ('ad', 'subscription')
        AND ARRAY_LENGTH(album.sale_periods) > 0
        and (sp.end is NULL or 
        FORMAT_TIMESTAMP("%F",TIMESTAMP_MILLIS(if(sp.end between -2208988800000 and 4102444800000,sp.end,null)))
            >='2018-06-01')
        ) AND (select coalesce(max(true),false) from unnest(album.sale_periods) as sp 
        where sp.countries is null or sp.countries like '%US%') currently_available_in_US
        
    FROM `knowledge-graph-112233.album_entity.album_entity_20180601`
    where 
        album.metadata_album.date between '2015' and '2015-12-31'
    )