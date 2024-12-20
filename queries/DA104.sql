
/*
SELECT * FROM ba_flights_excerpt LIMIT 1 -- view headers
;

SELECT DISTINCT departure_city, arrival_city
FROM ba_flights_excerpt

SELECT flight_number,
			baggage_weight as weight,		-- shorten reference
      total_passengers,
      distance_flown as distance  -- here too
FROM ba_flights_excerpt
;

SELECT flight_number,
			 actual_flight_date,
       departure_city
FROM ba_flights_excerpt
WHERE arrival_city IN ('Madrid','Lisbon','Port of Spain','Tel Aviv')
;

SELECT flight_number,
			baggage_weight as weight,		-- shorten reference
      total_passengers
--      revenue_from_baggage as bagrev,
--      distance_flown as distance  -- here too
FROM ba_flights_excerpt
WHERE arrival_city IN ('Dubai','Chicago')
;

SELECT flight_number,
			 status,		
       total_passengers
FROM ba_flights_excerpt
WHERE actual_flight_date < '2023-05-01'
;

SELECT flight_number,
			baggage_weight as weight,		-- shorten reference
      total_passengers,
      revenue_from_baggage as bagrev,
      distance_flown as distance  -- here too
FROM ba_flights_excerpt
WHERE revenue_from_baggage BETWEEN 10000 AND 40000
;

SELECT flight_id
FROM ba_flights_excerpt
WHERE total_passengers = 0
OR   distance_flown = 0
;

SELECT flight_number,
       departure_city
FROM ba_flights_excerpt
WHERE status = 'Scheduled'
AND (revenue_from_baggage = 0
     OR total_passengers = 0)
*/