-- Cleaning Messy Text Data 

-- SYNTAX: COALESCE(<column>, value if <column> is NULL)
/*
SELECT country,
				sales_team,
        COALESCE(country, 'CEHCK THIS PLEASE') AS new_country
FROM meta_clients 


SELECT COALESCE(country, 
         				 CASE WHEN sales_team LIKE '%_FR_%' THEN 'France'
                			WHEN sales_team LIKE '%_ES_%' THEN 'Spain'
                      WHEN sales_team LIKE '%_IT_%' THEN 'Italy'
                			WHEN sales_team LIKE '%_UK_%' THEN 'United Kingdom'
                			WHEN sales_team LIKE '%_DACH_%' THEN 'Germany'
                      ELSE country 
                      END) AS upd_country,
                sales_team

FROM meta_clients
;



-- You can use more that one possible fill value. 
-- For example, if the first two columns have a NULL value, 
-- the third one will populate the column, otherwise the second will fill first. 
-- This can be set up in the following way:

SELECT COALESCE(country, sales_team, 'Other') AS country,
			 sales_team
FROM meta_clients
;

-- UPPER & LOWER

SELECT DISTINCT industry,
CASE WHEN LOWER(industry) IN ('retail & consumer goods',
  'consumer goods', 'retail  ', 'retail', 'consumer goods   ', 'rcg') 
  THEN 'retail & consumer goods'
  ELSE LOWER(industry)
  END AS l_industry
FROM meta_clients
ORDER BY industry ASC


-- Removing whitespace in text TRIM() 
-- leading and trailing can ot be combined !!

SELECT DISTINCT LOWER(TRIM(industry)) AS tr_industry
FROM meta_clients
WHERE industry LIKE '%etail%'
ORDER BY tr_industry

-- To specify:
SELECT DISTINCT LOWER(TRIM(TRAILING ' ' from industry)) AS tr_industry
FROM meta_clients -- TRIM ALREADY REMOVES SPACE at the start and end of a string
-- therefore superfluous to specify this

SELECT DISTINCT TRIM(LEADING 'R' from industry) AS tr_industry -- only trims what is 
FROM meta_clients -- specified i.e. trailing space remains
WHERE industry LIKE '%etail%'
ORDER BY tr_industry
*/

-- REPLACE()
/*
SELECT DISTINCT region
FROM meta_clients
ORDER BY region DESC

SELECT REPLACE(region, '.','') AS cl_region, -- '' replaces with nothing, i.e. no space
region
FROM meta_clients

SELECT REPLACE(industry, '&','+') AS cl_ind, 
industry
FROM meta_clients


-- SUBSTRING(field, starting str number, how many str from starting number)
SELECT  client_id,
				SUBSTR(client_id,8, 20) AS cl_client_id
FROM meta_clients
;

SELECT  DISTINCT sales_team,
				CASE 	WHEN sales_team LIKE '%DACH%' THEN SUBSTR(sales_team,5, 4)
        			WHEN sales_team LIKE '%MENA%' THEN SUBSTR(sales_team,1, 4)
        			ELSE SUBSTR(sales_team,5, 2)
              END AS region_team
FROM meta_clients


-- REGULAR EXPRESSIONS REGEXP_LIKE() & REGEXP_REPLACE

SELECT *
FROM meta_clients
WHERE REGEXP_LIKE(industry, 'retail|Retail|consumer goods|Consumer Goods')
;


SELECT *
FROM meta_clients
WHERE REGEXP_LIKE(industry, 'Retail|consumer goods','i') --insensitive to case
;

SELECT *
FROM meta_clients
WHERE REGEXP_LIKE(industry, '^Retail|^consumer goods','i') -- ^starting with

SELECT 
REGEXP_REPLACE(client_id,'[0-9]','') -- will only remove one instance/last number
FROM meta_clients


SELECT 
 REGEXP_REPLACE(client_id,'[0-9]','','g') -- g = global removes all numbers
FROM meta_clients
 
 
SELECT 
 REGEXP_REPLACE(client_id,'[0-9_]','','g') -- added _ to the pattern to replace
FROM meta_clients
*/

/* LESSON RECAP:
Here is a quick recap of key points to take away from this lesson: 
 
- NULL values can be easily filled by using existing information in the table 
or with catch-alls. 
- Data quality issues in text, such as redundant spaces, typos, 
and capitalization issues, can be resolved using various text functions.
- Functions can be combined to resolve multiple problems in a single run


