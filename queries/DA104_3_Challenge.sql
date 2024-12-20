-- DA104.3 SQL Challenge Nike I & II
/*
-- Q1
SELECT o.order_id, o.order_item_id, 
			p.product_name, o.sale_price -- mistake had p.retail_price
FROM order_items AS o
INNER JOIN products AS p
USING(product_id)
;

-- Q2
SELECT p.product_id,
			 p.product_name
FROM distribution_centers AS dc
INNER JOIN products AS p
USING(distribution_center_id)
WHERE dc.name LIKE '%Los%'
;
-- SOLUTION:
SELECT product_id,
			 product_name
FROM products 
LEFT JOIN distribution_centers dc 
ON products.distribution_center_id = dc.distribution_center_id    
WHERE dc.name = 'Los Angeles CA' 
--Note: INNER JOIN would also be correct here

--Q3
SELECT status, COUNT( DISTINCT order_item_id)
FROM order_items
JOIN orders
USING(order_id)
WHERE status IN ('Cancelled', 'Returned')
GROUP BY status
;

--Q4
SELECT product_name, COUNT( DISTINCT order_item_id)
FROM order_items
FULL JOIN products
USING(product_id)
GROUP BY product_name
;

-- Q5 
SELECT product_id, product_name
       FROM order_items AS oi
      INNER JOIN products
			 USING(product_id)
		UNION DISTINCT
       SELECT product_id, product_name
       FROM order_items_vintage AS oiv
      INNER JOIN products
			 USING(product_id)
       GROUP BY DISTINCT(product_id), product_name
       ORDER BY product_id
       ;
--SOLUTION:
SELECT product_id 
FROM order_items 
UNION DISTINCT  
SELECT product_id 
FROM order_items_vintage

-- Q6
SELECT order_item_id, product_name, 
retail_price, sale_price,
retail_price - sale_price AS discount_given
FROM order_items
LEFT JOIN products
USING(product_id)
WHERE retail_price - sale_price > 0
ORDER BY discount_given DESC
;
*/
-- Q7
SELECT DISTINCT product_name, 
		  (SELECT CASE WHEN retail_price - sale_price > 0 THEN 'Discounted'
      		WHEN retail_price - sale_price = 0 THEN 'Not discounted'
          ELSE 'Error'
          END AS discount_given),
      COUNT( DISTINCT order_item_id) AS count_oi
FROM order_items
INNER JOIN products -- Mistake - had FULL instead of <inner>
USING(product_id)
GROUP BY product_name, discount_given
ORDER BY count_oi DESC, discount_given DESC
;
/*
-- Q8
SELECT SUM(retail_price) AS retail,
			 SUM(round(sale_price,2)) AS sales, 
       ROUND(SUM(retail_price) - SUM(sale_price),2) AS discount
FROM order_items
INNER JOIN products
USING(product_id)
;
*/
-- NIKE II 
/*
-- Q1
SELECT * from order_items UNION ALL SELECT * from order_items_vintage;
*/
SELECT CASE WHEN order_item_id LIKE 'O%' THEN 'Nike Official'
						WHEN order_item_id LIKE 'V%' THEN 'Nike Vintage'
            ELSE 'ERROR'
            END AS business_unit, 
       COUNT(DISTINCT order_item_id) AS orders
FROM order_items
GROUP BY business_unit
UNION ALL 
SELECT CASE WHEN order_item_id LIKE 'O%' THEN 'Nike Official'
						WHEN order_item_id LIKE 'V%' THEN 'Nike Vintage'
            ELSE 'ERROR'
            END AS business_unit,
       COUNT(DISTINCT order_item_id) AS orders
FROM order_items_vintage
GROUP BY business_unit
/*
-- SOLUTION:				
SELECT 'Nike Official' AS business_unit,
			 COUNT(DISTINCT order_item_id) AS num_items       
FROM order_items
UNION ALL
SELECT 'Nike Vintage' AS business_unit,
			 COUNT(DISTINCT order_item_id) AS num_items       
FROM order_items_vintage
*/