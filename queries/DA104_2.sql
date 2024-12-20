-- Filtering and Aggregating Data
/*
SELECT 	dates,
	client_id,
       	conversions      
FROM meta_revenue
WHERE years = '2022'
;

SELECT SUM(conversions) AS total_conversions      
FROM meta_revenue
WHERE years = '2022'
;

SELECT SUM(revenue)/SUM(conversions) AS revenue_per_conversion
FROM meta_revenue
;

SELECT 	sales_team,
	parent_company,
	SUM(conversions) AS total_conversions      
FROM meta_revenue
GROUP BY sales_team,
	 parent_company
ORDER BY total_conversions DESC
;

SELECT 	sales_team,				
	AVG(clicks) AS average_clicks      
FROM meta_revenue
WHERE years = '2022'
GROUP BY sales_team					
ORDER BY average_clicks DESC
;

SELECT 	ad_types,
	SUM(clicks) AS total_clicks        
FROM meta_revenue
WHERE parent_company = 'Instagram'
GROUP BY ad_types
;

SELECT SUM(revenue) as total_revenue
FROM meta_revenue
WHERE years = 2019 
AND parent_company = 'Facebook'
;
*/

-- CASE WHEN to create custom columns
-- general syntax:
/*
SELECT <field>
	CASE 	WHEN <condition> THEN <output>
	WHEN <condition> THEN <output>
	ELSE <output>
	END AS <column_name>
FROM <table>


SELECT 	years,
	CASE 	WHEN years BETWEEN 2010 AND 2019 THEN '2010-2019'
		WHEN years BETWEEN 2020 AND 2029 THEN '2020-2029'
		ELSE 'ERROR' -- ELSE catches all the cases not covered above
	END AS decade,-- always remember to close a CASE WHEN with the END AS syntax
FROM meta_revenue
;

--ALT syntax fields after CASE, will determine the order of output columns
-- we don't need to use brackets/parentheses below but it improves readability
SELECT CASE WHEN (geo_user = 'DK' OR geo_advertiser = 'DK') THEN 'Denmark'
            ELSE 'Other'
       END AS denmark_column,
       geo_user,
       geo_advertiser
       
FROM meta_revenue
;

SELECT	CASE	WHEN clicks BETWEEN 0 AND 500 THEN '01. <= 500'
        	WHEN clicks BETWEEN 501 AND 1000 THEN '02. 510 - 1000'
            	ELSE '03. Other'
      	END AS segment,
	AVG(clicks) AS avg_clicks,
	COUNT(clicks) AS cnt_clicks
FROM meta_revenue
GROUP BY segment
;

SELECT 	SUM(revenue) AS total_revenue,
	age_bucket_user
FROM meta_revenue
WHERE years = 2020
GROUP BY age_bucket_user
;

SELECT	CASE	WHEN age_bucket_user IN ('18-24', '25-34') THEN '01. 18-34'
        	WHEN age_bucket_user IN ('35-44', '45-54', '55-64', '65+') THEN '02. 34+'
            	ELSE '03. Other'
      	END AS age_segment,
        SUM(revenue) AS total_revenue
      
FROM meta_revenue
WHERE years = 2020
GROUP BY age_segment
;


 -- HAVING - can only be used on fields in SELECT and after GROUP BY, best for aggregated data,

SELECT  parent_company, 
	years,
	SUM(revenue) AS total_revenue

FROM meta_revenue
GROUP BY years, parent_company
HAVING SUM(revenue) > 500
;

        
SELECT 	geo_user, 
	SUM(clicks) AS total_clicks

FROM meta_revenue
WHERE years = 2018 AND parent_company = 'Instagram'
GROUP BY geo_user
ORDER BY total_clicks DESC
LIMIT 5
;
*/
