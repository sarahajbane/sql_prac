--QUIZ

/*
SELECT order_item_id, status 
FROM order_items 
INNER JOIN orders ON order_items.order_id=orders.order_id
WHERE orders.status = 'Complete'


SELECT order_items.order_item_id,
products.product_id, 
order_items.sale_price - products.cost AS profit
FROM order_items
LEFT JOIN products 
ON order_items.product_id = products.product_id
*/

SELECT COUNT(DISTINCT distribution_center_id)
FROM distribution_centers
/*
SELECT DISTINCT distribution_centers.name, 
products.product_name
FROM distribution_centers 
LEFT JOIN products 
ON distribution_centers.distribution_center_id = products.distribution_center_id

SELECT DISTINCT distribution_centers.name, 
products.product_name
FROM distribution_centers
INNER JOIN products 
ON products.distribution_center_id = distribution_centers.distribution_center_id

SELECT DISTINCT distribution_centers.name, 
products.product_name
FROM products
LEFT JOIN distribution_centers 
ON products.distribution_center_id = distribution_centers.distribution_center_id


-- all 16) */

