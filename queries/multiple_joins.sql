/*
Desired Output ->

Tables Needed ->

Columns Needed ->

Functions Needed ->

Filters Needed ->
*/

/*
SELECT flight.flight_id,/*
			 flight.flight_number,*/
			 route.flight_number,
       aircraft.ac_subtype

FROM ba_flights flight
		 FULL JOIN ba_flight_routes route ON flight.flight_number = route.flight_number
     LEFT JOIN ba_aircraft aircraft ON flight.flight_id = aircraft.flight_id
;
SELECT /*a.client,
       a.period,
       b.licenses_sold,*/
       AVG(b.active_users) as avg_user,
       AVG(a.revenue) as avg_revenue
FROM company_revenue a 
FULL JOIN company_products b USING(client, period)
WHERE client = 'British Airways'
;
*/

/*
Desired Output -> table unique flight_id, unique ac_subtype, avg fuel_efficiency

Tables -> ba,flights, ba_aircraft, ba_fuel_efficiency

Columns -> flight_id, 

Functions  -> COUNT(DISTINCT ), AVG, 2 Left joins

Filters -> n/a

--Q1
SELECT
			COUNT(DISTINCT a.flight_id) AS unique_flights,
      COUNT(DISTINCT b.ac_subtype) AS unique_ac,
      AVG(c.fuel_efficiency) AS avg_fuel
FROM ba_flights a
LEFT JOIN ba_aircraft b USING(flight_id)
LEFT JOIN ba_fuel_efficiency c USING(ac_subtype)
-- 1012,	9,	0.19921876986826347305

--Q2
SELECT
			COUNT(DISTINCT a.flight_id) AS unique_flights,
      COUNT(DISTINCT b.ac_subtype) AS unique_ac,
      AVG(c.fuel_efficiency) AS avg_fuel
FROM ba_flights a
INNER JOIN ba_aircraft b USING(flight_id)
INNER JOIN ba_fuel_efficiency c USING(ac_subtype)
-- unique flights down to 835 from 1012
*/

/*
Desired Output -> list of flight_ids, with no ac_subtype, manufacturer assigned

Tables -> ba,flights, ba_aircraft, ba_fuel_efficiency

Columns -> flight_id

Functions  -> 2 Left joins

Filters -> manufacturer IS NULL, ac_subtype IS NULL
*/

--Q3 

SELECT
			a.flight_id AS flights,
      b.ac_subtype,   -- included in solution
      b.manufacturer  -- despite q asking for a list not table
FROM ba_flights a
LEFT JOIN ba_aircraft b USING(flight_id)
/*LEFT JOIN ba_fuel_efficiency c USING(ac_subtype)

WHERE b.manufacturer IS NULL --AND c.manufacturer IS NULL
AND b.ac_subtype IS NULL --AND c.ac_subtype IS NULL */
WHERE b.flight_id IS NULL --given solution
-- result is same regardless 177 flights

-- Q4 
/*
Desired Output -> unique flight dates, with manufacturer & ac_subtype

Tables -> ba_flights, ba_aircraft, ba_fuel_efficiency

Columns -> actual_flight_date, manufacturer, ac_subtype

Function -> COUNT(DISTINCT), Group by manufacturer & ac_subtype

SELECT
      a.manufacturer,
      a.ac_subtype,
      COUNT(DISTINCT c.actual_flight_date) AS dates
FROM ba_fuel_efficiency a
			LEFT JOIN ba_aircraft b USING(ac_subtype)
			LEFT JOIN ba_flights c USING(flight_id)

GROUP BY a.manufacturer, a.ac_subtype
ORDER BY a.manufacturer ASC, a.ac_subtype ASC


*/
-- Q5 same but with one full join
SELECT
      a.manufacturer,
      a.ac_subtype,
      COUNT(DISTINCT c.actual_flight_date) AS dates
FROM ba_flights c 
			INNER JOIN ba_aircraft b USING(flight_id)
			FULL JOIN ba_fuel_efficiency a USING(ac_subtype)

GROUP BY a.manufacturer, a.ac_subtype
ORDER BY a.manufacturer ASC, a.ac_subtype ASC
