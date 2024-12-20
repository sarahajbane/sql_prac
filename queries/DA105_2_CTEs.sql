-- WITH statements & subqueries (NIKE II database)
-- WITH creates CTEs (common table expressions)
-- breaks down difficult problems 
-- into multiple simple queries and can be 'debugged' in sections

-- SYNTAX:
/*
WITH my_temp_table AS (
	SELECT * 
  FROM table
)
SELECT * 
FROM my_temp_table
;


WITH orders_per_customer AS (
	SELECT  user_id,
	   			COUNT(order_id) AS total_orders
	FROM orders
	GROUP BY user_id
)
SELECT CASE WHEN total_orders = 1 THEN 'Single Customer'
       		  WHEN total_orders > 1 THEN 'Recurring Customer'
            ELSE 'Other'
      			END AS customer_group,
      COUNT(user_id) AS total_customers
FROM orders_per_customer
GROUP BY customer_group
;


/* Notes:
You can reference the table in your FROM statement.
You can JOIN the common table expression on any other permanent table.
You can leverage the table in a UNION.
*/

-- EXAMPLE: UNION
WITH total_order_items AS (
  	SELECT * FROM order_items
  	UNION ALL
  	SELECT * FROM order_items_vintage
)
SELECT SUM(sale_price)::int AS total_revenue 
FROM total_order_items
;


-- EXAMPLE: Double aggregations
WITH orders_per_customer AS (
	SELECT user_id,
	     	 COUNT(order_id) AS total_orders
	FROM orders
	GROUP BY user_id
)
SELECT CASE WHEN total_orders = 1 THEN 'Single Customer'
       		  WHEN total_orders > 1 THEN 'Recurring Customer'
            ELSE 'Other'
      			END AS customer_group,
      COUNT(user_id) AS total_customers
FROM orders_per_customer
GROUP BY customer_group
;



-- EXAMPLE: Filtering on seperate criteria

WITH completed_orders AS (
		SELECT * 
  	FROM orders 
  	WHERE status = 'Complete'	
)
SELECT COUNT(orders.order_id) AS total_orders,
			 COUNT(completed_orders.order_id) AS total_completed_orders
FROM orders
LEFT JOIN completed_orders 
USING(order_id)
;


-- MULTIPLE CTEs 2:
WITH items_combined AS ( -- first temp table 
	SELECT * FROM order_items
	UNION ALL
	SELECT * FROM order_items_vintage 
),
orders_per_customer AS ( --second temp table
	SELECT user_id,
			 	 COUNT(order_item_id) AS total_orders_items
	FROM items_combined
  JOIN orders using(order_id) -- needs to be added as no user_id in items
	GROUP BY user_id
)
SELECT CASE WHEN total_orders_items = 1 THEN 'Single Customer'
       		  WHEN total_orders_items > 1 THEN 'Recurring Customer'
            ELSE 'Other'
       			END AS customer_group,
       COUNT(user_id) AS total_customers
FROM orders_per_customer
GROUP BY customer_group
;
*/

-- MULTIPLE CTEs 3 SYNTAX:

WITH <temp_table> AS ( -- WITH does not repeat, commas like SELECT
	SELECT * FROM table_a),
<temp_table_2> AS (
	SELECT * FROM table_b),
<temp_table_3> AS (
	SELECT * FROM table_c)
SELECT * FROM <temp_table_2> b
LEFT JOIN <temp_table> a ON b.join_key = a.join_key
LEFT JOIN <temp_table_3> c ON b.join_key = c.join_key -- corrected to add _3



