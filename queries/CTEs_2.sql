-- Live Sesh 111224 Part 2

/*
Exercise 1: Calculate Total and Average Sales per Product Category
Scenario:
The sales team wants to understand the overall sales performance 
across different product categories. They need to know the total 
sales and the average sale price per category to identify high-
performing and underperforming categories.
Question:
Write a query that calculates the total sales and the average sale 
price for each product category. Combine data from both regular and 
vintage order items. Order the results by total sales in descending
order.

-- Solution 
WITH combined_order_items AS (
SELECT product_id, sale_price
FROM order_items oi
UNION ALL
SELECT product_id, sale_price
FROM order_items_vintage oiv
),
category_sales AS (
  SELECT p.category, 
  count(*) as number_of_sales,
  SUM(coi.sale_price) AS total_sales,
  AVG(coi.sale_price) AS avg_sale_price
  FROM combined_order_items coi
  JOIN products p USING(product_id)
  GROUP BY p.category
)
SELECT category,
			 number_of_sales,
       round(total_sales::numeric, 2) AS total_sales,
       round(avg_sale_price::numeric, 2) AS avg_sale_price
FROM category_sales
ORDER BY total_sales DESC
*/
/*
-- Second CTE is not necessary: Ekatarina Solution

WITH all_orders AS (
  SELECT *
  FROM order_items
  UNION
  SELECT *
  FROM order_items_vintage
)
SELECT products.category, 
COUNT(products.product_id) AS number_sales,
ROUND(SUM(all_orders.sale_price)::numeric,2) AS total_sales, 
ROUND(SUM(all_orders.sale_price)::numeric / COUNT(products.product_id)::numeric,2) AS avg_sale_price
FROM all_orders
JOIN products
ON all_orders.product_id = products.product_id
GROUP BY products.category
ORDER BY total_sales DESC;
*/

-- 

WITH recent_orders AS (
  SELECT o.order_id, o.user_id, o.created_at
  FROM orders o
  WHERE o.created_at >= (CURRENT_DATE - INTERVAL '2 year')
),
combined_order_items AS (
select * from order_items oi
join recent_orders ro on oi.order_id = ro.order_id
UNION ALL
select *
from order_items_vintage oiv
join recent_orders ro on oiv.order_id = ro.order_id
),
combined_spending AS (
  SELECT coi.user_id,
sum(coi.sale_price) as total_spent,
  count(distinct order_id) as order_count
from combined
Lorder_items coi
group by coi.user_id
select * from
  
                         
  
  
  
  
  
  