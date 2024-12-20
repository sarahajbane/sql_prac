-- QUIZ 
/* 
-- Q5 no flights in ba_aircraft
SELECT COUNT(DISTINCT f.flight_id)
FROM ba_flights f
FULL JOIN ba_aircraft a USING(flight_id)
WHERE a.flight_id IS NULL

--Q6 number of pass .1 dec rounded 
-- boeing flight with capacity >200

SELECT ROUND(AVG(f.total_passengers),1) as pass
FROM ba_flights f
LEFT JOIN ba_aircraft a USING(flight_id)
LEFT JOIN ba_fuel_efficiency e USING(ac_subtype)

WHERE e.manufacturer = 'Boeing'
AND e.capacity > 200

--Q7
SELECT COUNT(DISTINCT e.ac_subtype) as count_subtype
FROM ba_fuel_efficiency e
FULL JOIN ba_aircraft a USING(ac_subtype)
FULL JOIN ba_flights f USING(flight_id)
WHERE f.status = 'Completed'

-- Q8 total flights >3000km with capacity <100 pass

SELECT 	COUNT(a.flight_number) AS total_flights
FROM ba_flights a 
			FULL JOIN ba_aircraft b USING(flight_id)
			FULL JOIN ba_fuel_efficiency c USING(ac_subtype)
  		FULL JOIN ba_flight_routes d USING(flight_number)
WHERE distance_flown > 3000
  AND capacity < 100


-- Q9 how many flights Airbus with ATR42 ac_subtype

SELECT COUNT(flight_id) as count_flights
FROM ba_flights f 
FULL JOIN ba_aircraft a USING(flight_id)
FULL JOIN ba_fuel_efficiency e USING(ac_subtype)
WHERE e.manufacturer = 'Airbus'
AND e.ac_subtype = 'ATR42'
AND status = 'Completed'
-- 0

SELECT *
FROM ba_flights
LEFT JOIN ba_aircraft a USING(flight_id)
WHERE ac_subtype = 'ATR42'
AND manufacturer = 'Airbus'
GROUP BY flight_id
*/

-- Q10 sum of baggage for boeing flights with efficiency > 0.04
SELECT SUM(baggage_weight) as total_weight
FROM ba_flights f 
FULL JOIN ba_aircraft a USING(flight_id)
FULL JOIN ba_fuel_efficiency e USING(ac_subtype)
WHERE e.manufacturer = 'Boeing'
AND e.fuel_efficiency > 0.04

-- all correct