-- NUMBERS AND DATES
/*
-- CAST() i.e. AS NUMERIC, TEXT, DATE - SYNTAX: 

SELECT ROUND(SUM(CAST(revenue AS NUMERIC)),2) AS n_revenue
FROM meta_revenue
;
--OR alt syntax:
SELECT round(sum(revenue),2)::int AS t_revenue
FROM meta_revenue
;
-- poss types: ::int, ::float, ::numeric, ::text, ::date, ::boolean etc

SELECT client_id,
			 impressions,
       clicks,
       conversions,
       ROUND(revenue,4) AS rev_rou
FROM meta_revenue;

Q - total marketing spend per customer
SELECT client_id,
ROUND(annual_revenue*marketing_spend_perc,0) AS marketing_spend
FROM meta_clients


--EXTRACT() - DATE TRUNK, DATE DIFF possible as well but v syntax differing between languages 

SELECT	client_id,
				sales_team,
        industry,
        sector,
        EXTRACT(YEAR FROM last_updated_date) AS year,
        EXTRACT(MONTH FROM last_updated_date) AS month,
        EXTRACT(DAY FROM last_updated_date) AS day
        
FROM meta_clients

WHERE EXTRACT(MONTH FROM last_updated_date) = 3
AND EXTRACT(YEAR FROM last_updated_date) = 2023

-- Q: Which client information in the meta_clients table was 
-- last updated in the first five months of 2023?
-- A:
SELECT *

FROM meta_clients

WHERE EXTRACT(YEAR FROM last_updated_date) = 2023
			AND EXTRACT(MONTH FROM last_updated_date) <= 5
;

-- misunderstood q: Q: Which CLIENT'S information in the meta_clients table was 
-- LAST updated in the first five months of 2023?
-- A: CLIENT_41213
SELECT client_id, 
EXTRACT(YEAR FROM last_updated_date) AS year,
EXTRACT(MONTH FROM last_updated_date) AS month,
EXTRACT(DAY FROM last_updated_date) AS day
FROM meta_clients
WHERE EXTRACT(MONTH FROM last_updated_date) <=5
AND EXTRACT(YEAR FROM last_updated_date) = 2023
GROUP BY client_id
ORDER BY month DESC, EXTRACT(DAY FROM last_updated_date) DESC
LIMIT 5
*/


-- TO_DATE(), CURRENT_DATE() to create custom dates

SELECT TO_DATE('2023-01-01', 'YYYY-MM-DD')::date AS custom_date, -- can be ::text
			 last_updated_date

FROM meta_clients
;

SELECT CURRENT_DATE AS today, -- creates a new column with todays date in 
last_updated_date
FROM meta_clients
;
