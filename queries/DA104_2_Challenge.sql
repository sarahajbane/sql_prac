-- SQL CHALLENGE BA II
/*
SELECT *
FROM ba_flights_excerpt
LIMIT 5
;

-- Q1 What are the unique arrival cities that start with the capital letter "L"
SELECT DISTINCT arrival_city
FROM ba_flights_excerpt
WHERE arrival_city LIKE 'L%'
;
-- Q2 Select all flights that are scheduled and depart between April 1 and April 30 2023.
SELECT *
FROM ba_flights_excerpt
WHERE actual_flight_date BETWEEN '2023-04-01' AND '2023-04-30'
	AND status = 'Scheduled'
;

-- Q3 Select the flight numbers, departure city, and baggage weight for flights that are scheduled to fly to Manilla, Bangkok, Jakarta, or Muscat and revenue from baggage less than or equal to £7450
SELECT 	flight_number,
				departure_city,
        baggage_weight
FROM ba_flights_excerpt
WHERE arrival_city IN ('Manila', 'Bangkok', 'Jakarta', 'Muscat') 
      AND revenue_from_baggage <= 7450 
      AND status = 'Scheduled'
;


-- SQL CHALLENGE Meta II
SELECT * FROM meta_revenue LIMIT 5
;

-- Q1 Summarize the number of clicks that have been generated for each year where the user and the advertiser have the same geographical code

SELECT 	years,
				SUM(clicks) as total_clicks
FROM meta_revenue
WHERE geo_user = geo_advertiser
GROUP BY years
;
--  Q2 How much revenue has been generated through domestic activity versus international activity in 2022 for each platform (Instagram and Facebook)?
SELECT 	parent_company,
				CASE WHEN geo_user = geo_advertiser THEN 'Domestic'
        		WHEN geo_user != geo_advertiser THEN 'International'
            ELSE 'Error'
            END AS geo,
        SUM(revenue) AS total_rev,
FROM meta_revenue
WHERE years = 2022
GROUP BY parent_company, geo
;
*/


-- Q3 How much revenue did the LCS and SMB sales teams generate in 2022 split between domestic and international activity?
SELECT 	CASE WHEN sales_team LIKE '%LCS%' THEN 'LCS'
        		 WHEN sales_team LIKE '%SMB%' THEN 'SMB'
             ELSE 'Other'
             END AS team,
				CASE WHEN geo_user = geo_advertiser THEN 'Domestic'
        		WHEN geo_user != geo_advertiser THEN 'International'
            ELSE 'Error'
            END AS geo,
        SUM(revenue) AS total_rev
FROM meta_revenue
WHERE years = 2022
GROUP BY team, geo
ORDER BY team
;

/*
 -- WRONG
 SELECT parent_company, 	
				SUM(revenue) AS total_rev,
					(SELECT CASE WHEN geo_user = geo_advertiser THEN 'domestic'
        					WHEN geo_user <> geo_advertiser THEN 'international'
            			END AS activity
           FROM meta_revenue),
           (SELECT
           			CASE WHEN parent_company LIKE 'F%' THEN 'Facebook'
        				WHEN parent_company LIKE 'I%' THEN 'Instagram'
            		END AS parent
           FROM meta_revenue) 
FROM meta_revenue
WHERE years = 2022
GROUP BY parent_company  -- ERROR: more than one row returned by a subquery used as an expression


--TIM's EXAMPLE
SELECT *
FROM ba_flights_excerpt AS ba
WHERE ba.distance_flown IN(
  SELECT DISTINCT t.distance_flown
	FROM ba_flights_excerpt as t
	WHERE t.distance_flown > 0 AND t.distance_flown IS NOT NULL
	ORDER BY t.distance_flown
	LIMIT 10)
ORDER BY ba.distance_flown ASC

*/        