-- Subqueries can be in SELECT clause - similar to a temp table CTE
/*
SELECT * FROM
(SELECT * FROM order_items
WHERE shipped_at IS NOT NULL
UNION ALL 
SELECT * FROM order_items_vintage
WHERE shipped_at IS NOT NULL) AS X -- Beekeeper requires alias, other environs don't

-- Also in WHERE CLOSE - used like opposite of a join
SELECT * FROM orders
WHERE order_id NOT IN(SELECT order_id FROM order_items_vintage) -- no alias needed here
*/
-- Q:
SELECT COUNT(DISTINCT order_id), created_at FROM 
(SELECT * FROM order_items
 UNION ALL
 SELECT * FROM order_items_vintage
) AS X
GROUP BY created_at
ORDER BY created_at DESC LIMIT 1

-- Actual solution:
SELECT COUNT(*) AS total_orders 
FROM orders 
WHERE created_at = (SELECT MAX(created_at) FROM orders)