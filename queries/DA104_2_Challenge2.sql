-- Sprint 104.2 META revenue SQL CHALLENGE 
--  Filtering and Aggregating Data

/*
-- QUESTION 1:
SELECT  years, 
				SUM(revenue) AS total_revenue

FROM meta_revenue
WHERE parent_company = 'Instagram'
GROUP BY years
ORDER BY years ASC
;


 -- QUESTION 2:
-- convoluted way:
SELECT 	years,
				CASE WHEN ad_types IN ('Instagram Video', 'Facebook Video') THEN 'Video Ad'
						 ELSE 'Other'
       	END AS video_ad,
       	SUM(revenue) AS total_revenue
      
FROM meta_revenue 
GROUP BY years, video_ad
HAVING years >= 2021
ORDER BY video_ad DESC
LIMIT 2;

-- LESS CONVOLUTED
SELECT 	years,				
       	SUM(revenue) AS total_revenue
FROM meta_revenue 
WHERE ad_types LIKE '%Video' 
GROUP BY years
HAVING years >= 2021 -- only works because >2022 isn't included
ORDER BY total_revenue ASC;

-- EXPECTED SOLUTION:
SELECT years, 
			 SUM(revenue) AS total_revenue
FROM meta_revenue 
WHERE years BETWEEN 2021 AND 2022 -- we could have used an OR here too but would have to use brackets
			AND ad_types LIKE '%Video%' -- could have used OR statements here as well, but this is more concise
GROUP BY years;

-- QUESTION 3
SELECT 	CASE WHEN ad_types LIKE '%Video%' THEN 'Video Ad'
        		 WHEN ad_types LIKE '%Display%' THEN 'Display Ad'
						 ELSE 'Other'
       	END AS ad_products,
       	SUM(revenue) AS total_revenue
      
FROM meta_revenue 
GROUP BY ad_products
;


-- QUESTION 4
SELECT 	ad_id,
				SUM(revenue) AS total_revenue

FROM meta_revenue
WHERE years = 2022 
			AND ad_types LIKE '%Video%'

GROUP BY ad_id
HAVING SUM(revenue) > 2
ORDER BY total_revenue DESC
;

Select SUM(clicks) AS t_clicks
from meta_revenue
where age_bucket_user = '18-24' AND parent_company = 'Instagram'


SELECT client_id, SUM(clicks) 
FROM meta_revenue
GROUP BY client_id
HAVING SUM(clicks) > 100000
ORDER BY SUM(clicks) DESC



SELECT ROUND(SUM(revenue),1) AS total_rev
FROM meta_revenue
WHERE ad_types LIKE '%Display'
			AND years = 2018
*/
