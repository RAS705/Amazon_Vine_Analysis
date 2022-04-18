-- Build two tables based on Vine membership

SELECT * 
into vine_table_no
FROM public.vine_table
--where (total_votes > 20 and helpful_votes <> 0) and ((cast(total_votes as float)/cast(helpful_votes as float)) >= .5)
where vine = 'N'
ORDER BY review_id ASC 

SELECT * 
into vine_table_yes
FROM public.vine_table
--where (total_votes > 20 and helpful_votes <> 0) and ((cast(total_votes as float)/cast(helpful_votes as float)) >= .5)
where vine = 'Y'
ORDER BY review_id ASC 


-- Sort out more than 20 total_votes and helpful >= .5 -- Vines = yes

SELECT * 
into vine_table_yes_helpful
FROM public.vine_table_yes
where (total_votes >= 20 and helpful_votes <> 0) and ((cast(total_votes as float)/cast(helpful_votes as float)) >= .5)
ORDER BY review_id ASC 

-- Sort out more than 20 total_votes and helpful >= .5 -- Vines = no

SELECT * FROM public.vine_table_no
where (total_votes >= 20 and helpful_votes <> 0) and ((cast(total_votes as float)/cast(helpful_votes as float)) >= .5)
ORDER BY review_id ASC 

SELECT * 
into vine_table_no_helpful
FROM public.vine_table_no
where (total_votes >= 20 and helpful_votes <> 0) and ((cast(total_votes as float)/cast(helpful_votes as float)) >= .5)
ORDER BY review_id ASC 


-- Sort total review counts

SELECT count(*)
FROM public.vine_table


-- find counts by star ratings
SELECT count(*), star_rating
into vine_counts
FROM public.vine_table

-- Find the percentage of total for each star rating
select star_rating, count, (count *100/(select count(*) from vine_table)) as "Percent total"
from vine_counts