
-- Question A: Can you count the flight routes that are shorter than 10% 
-- of the distance of the longest route that we offer?
-- Answer: 43

SELECT 	COUNT(DISTINCT a.flight_number) AS total_flights/*,
				b.total_passengers*/
FROM ba_flight_routes a
LEFT JOIN ba_flights b USING(flight_number)
WHERE a.distance_flown < (SELECT MAX(distance_flown) * 0.1 
                          FROM ba_flight_routes)

-- Question B: Please count all the flight routes (flight_number) 
-- in which we had 10 or more flights (flight_id) with less than 100 passengers each.”
-- Answer: 18

SELECT COUNT(route)
FROM (
  SELECT a.flight_number AS route, count(a.flight_number) AS total_flights
	FROM ba_flights a
	WHERE a.total_passengers < 100
	GROUP BY 1
	HAVING COUNT(a.flight_id) >= 10 -- TABLE
  ) AS few_pass_route -- Mandatory!

--Same result: 
select
count(distinct flight_number)
from ba_flights f
where f.flight_number in
(
  select
  f.flight_number
  from ba_flights f inner join ba_flight_routes fr
  on f.flight_number = fr.flight_number
  where f.total_passengers < 100
  group by f.flight_number
  having count(f.flight_id) >= 10
)

-- meets both criteria:
SELECT 	COUNT(DISTINCT a.flight_number) AS short_empty_flights/*,
				b.total_passengers*/
FROM ba_flight_routes a
LEFT JOIN ba_flights b USING(flight_number)
WHERE a.distance_flown < (SELECT MAX(distance_flown) * 0.1 
                          FROM ba_flight_routes)
			AND a.flight_number IN (SELECT a.flight_number/*, COUNT(a.flight_number) AS total_flights*/
															FROM ba_flights a
															WHERE a.total_passengers < 100
															GROUP BY 1
															HAVING COUNT(a.flight_id) >= 10)
                              
-- Question C: The absolute numbers are great, but could you be so kind 
-- and give me the percentages of all offered routes for both questions?

SELECT 
ROUND(COUNT(DISTINCT few_pass_route)*100.0
/COUNT(DISTINCT flight_number),2) AS "<100_pass"

FROM ba_flight_routes a
LEFT JOIN --output table
(
  SELECT a.flight_number AS route
	FROM ba_flights a
	WHERE a.total_passengers < 100
	GROUP BY 1
	HAVING COUNT(a.flight_id) >= 10 -- TABLE
  ) AS few_pass_route -- Mandatory!
ON a.flight_number=few_pass_route.route


--EKATERINA:
SELECT COUNT(*)::float / (SELECT COUNT(*) FROM ba_flight_routes)
FROM ba_flight_routes
WHERE distance_flown < (SELECT 0.1 * MAX(distance_flown) FROM ba_flight_routes)


--TIM 
SELECT 
ROUND((SELECT COUNT(route)
			FROM (
  					SELECT a.flight_number AS route, count(a.flight_number) AS total_flights
						FROM ba_flights a
						WHERE a.total_passengers < 100
						GROUP BY 1
						HAVING COUNT(a.flight_id) >= 10 -- TABLE
  					) AS few_pass_route
      )*100.0
/COUNT(DISTINCT flight_number),2)
FROM ba_flight_routes a
 
 
 
-- FINAL SOLUTION
 SELECT 

COUNT(DISTINCT few_passengers_routes.route) AS routes_few_passengers,
COUNT(DISTINCT a.flight_number) AS total_routes,

ROUND(  
  COUNT(DISTINCT few_passengers_routes.route) * 100.0 /
  COUNT(DISTINCT a.flight_number) 
      ,2 )
  AS percentage_few_passengers_routes


FROM ba_flight_routes a
LEFT JOIN --output table

(
    SELECT  a.flight_number AS route 
    FROM ba_flights a
    WHERE a.total_passengers<100
    GROUP BY 1
    HAVING count(a.flight_id)>=10 --18 rows
) AS few_passengers_routes

	ON a.flight_number=few_passengers_routes.route

;