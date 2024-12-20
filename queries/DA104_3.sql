-- JOIN and UNION
/*
general structure of syntax: 

SELECT 
	<table_1.column_1> ,
	<table_1.column_2> 
FROM	
	<table_1>
___ JOIN 		-- ___ can be replaced with INNER, 
				   	-- or any of the other JOIN types (LEFT, RIGHT, FULL)
	<table_2> 
ON <table_1.join_key> = <table_2.join_key>
;

SELECT 
	order_items.order_id, 	-- specifying table names to remove ambiguity 
	order_items.created_at, -- about which table a column belongs to
	order_items.shipped_at,
	order_items.product_id,
	products.product_name
FROM 
	order_items
INNER JOIN 	-- we want an INNER JOIN returning records where product_id 
	products 	-- is in both order_items and products
ON order_items.product_id = products.product_id -- we use the ON keyword 
;																								-- to specify join keys

SELECT
	products.product_name,
	products.product_id,
	distribution_centers.name
FROM products
INNER JOIN 
	distribution_centers 
ON products.distribution_center_id = distribution_centers.distribution_center_id
;

SELECT
	distribution_centers.name AS center,
  COUNT(products.product_id) AS products_count
FROM distribution_centers
LEFT JOIN 
	products
ON products.distribution_center_id = distribution_centers.distribution_center_id
GROUP BY distribution_centers.name
 
-- OR:

SELECT
	dcs.name AS center,
  COUNT(prs.product_id) AS n_product
FROM distribution_centers AS dcs
LEFT JOIN 
	products AS prs
USING(distribution_center_id)
GROUP BY dcs.name
;
  
SELECT  
	prs.product_id, -- opt.
  COUNT(dcs.distribution_center_id) AS n_center, -- opt.
	COUNT(prs.product_id) AS n_product
FROM distribution_centers AS dcs
FULL OUTER JOIN products AS prs
USING(distribution_center_id)
WHERE dcs.distribution_center_id IS NULL
GROUP BY prs.product_id  
;

-- UNION

SELECT order_item_id,
			 order_id,
			 product_id,
			 created_at,
			 shipped_at,
			 delivered_at,
			 returned_at,
			 sale_price

FROM order_items

UNION ALL -- stack the rows from the query above and the query below!

SELECT order_item_id,
			 order_id,
			 product_id,
			 created_at,
			 shipped_at,
			 delivered_at,
			 returned_at,
			 sale_price

FROM order_items_vintage
;

SELECT order_item_id,
			 product_id,
			 created_at,
			 sale_price
FROM order_items
WHERE created_at > '2023-02-01'

UNION ALL 

SELECT order_item_id,
			 product_id,
			 created_at,
			 sale_price
FROM order_items_vintage
WHERE created_at > '2023-02-01'
;

-- SELECT DISTINCT order_id from orders
-- WHERE IN order_items_vintage & order_items
-- returned_at IS NOT NULL
*/

SELECT user_id
       FROM order_items AS oi
       INNER JOIN orders
			 USING(order_id)
			WHERE oi.returned_at IS NOT NULL
			UNION DISTINCT
       SELECT user_id
       FROM order_items_vintage AS oiv
       INNER JOIN orders
			 USING(order_id)
       WHERE oiv.returned_at IS NOT NULL
       GROUP BY DISTINCT(user_id)
-- Output: 971 rows

/*SELECT DISTINCT user_id,
(SELECT order_item_id 
        FROM order_items 
        WHERE returned_at IS NOT NULL
        UNION DISTINCT
        SELECT order_item_id
        FROM order_items_vintage
        WHERE returned_at IS NOT NULL)
        
FROM orders
INNER JOIN oii
USING(order_id)
;
*/
/*
SELECT get_ fit_now_member.id, person.name,
get_fit_now_member.membership_status,
person. license_id
FROM get_fit_now_member
JOIN person
WHERE get_fit_now_member.person_id=person.id
     AND person.name IN ('Annabel Miller', 'Morty Schapiro')
-- Jeremy Bowers
-- Miranda Priestly
*/