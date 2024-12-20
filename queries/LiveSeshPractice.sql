/*
SELECT * FROM Customers

-- Q1 - How many customers have not made any order
-- Show their customer ID

SELECT * FROM Orders
WHERE order_num IS NULL
-- ignores 2 customers that are in Customers but not Orders


SELECT
COUNT (a.cust_id)
FROM Customers AS a
LEFT JOIN Orders AS b
ON a.cust_id = b.cust_id
WHERE b.order_num IS NULL
;
*/

select
c.cust_id
from Customers c
full join Orders o using(cust_id)
where o.cust_id is null


/*
Select prod_id, 
			CASE WHEN order_num IS NULL THEN 'no orders' 
      ELSE 'sold' 
      END AS status
FROM OrderItems
UNION ALL
Select prod_id, 
			CASE WHEN order_num IS NULL THEN 'no orders' 
      ELSE 'sold' 
      END AS status
FROM Products
GROUP BY status */

--different approaches to Q2:
-- combine the Products and the OrderItems tables,
-- and return a comprehensive list of all product names and a flag that indicates 
-- "no orders" if the product has never been sold ("Not Sold") and if has been "Sold".
-- Lastly, bring the number of orders each product has. 

/*
SELECT
			p.prod_name,
      CASE WHEN o.order_num IS NULL THEN 'no orders' 
      ELSE 'sold' 
      END AS status,
      COUNT(CASE
            WHEN o.order_num IS NULL THEN NULL ELSE 1 END) AS number_of_orders
      
FROM Products p
FULL JOIN OrderItems o
ON o.prod_id = p.prod_id
GROUP BY p.prod_name

SELECT
    p.prod_name,
    CASE
        WHEN oi.prod_id IS NULL THEN 'Not Sold'
        ELSE 'Sold'
    END AS Salesstatus
    FROM Products p
    FULL OUTER JOIN OrderItems oi
    ON p.prod_id = oi.prod_id
    GROUP BY 1

SELECT p.prod_name,
			 CASE
       		 WHEN oi.prod_id 	IS NULL THEN 'Not Sold'
           ELSE 'Sold'
       END AS sales_flag
FROM Products AS p
FULL JOIN OrderItems AS oi
ON p.prod_id = oi.prod_id
GROUP BY 1,2 -- same as : prod_name, sales_flag

SELECT 	p.prod_name,
  			SUM(i.quantity) AS total_orders,
  			CASE 	WHEN i.quantity IS NULL THEN 'not sold'
    					WHEN i.quantity > 0 THEN 'sold'
    					END AS flag
FROM Products AS p 
FULL JOIN OrderItems AS i ON p.prod_id = i.prod_id
GROUP BY p.prod_name
;

SELECT 
    p.prod_id, 
    p.prod_name, 
    CASE WHEN oi.order_num IS NULL THEN 'Not Sold'
         ELSE 'Sold'
         END AS sale_status,
    COUNT(oi.order_num) AS num_orders
FROM 
    Products p
LEFT JOIN 
    OrderItems oi ON p.prod_id = oi.prod_id
    
GROUP BY 
    p.prod_id, p.prod_name
ORDER BY 
    num_orders DESC;
    

-- FINAL SOLUTION 
SELECT
			p.prod_name,
      CASE
      WHEN o.order_num IS NULL 
      THEN 'Not Sold' ELSE 'Sold' 
      END AS status,
      COUNT(DISTINCT o.order_num) AS number_of_orders -- count function does not account for NULLS
      
FROM Products p
LEFT JOIN OrderItems o --check all the orders customer have made;
ON o.prod_id = p.prod_id
GROUP BY 1,2
ORDER BY number_of_orders DESC;
*/

-- Q3 Find all the products that have been sold 
-- at least twice (more than 1 orders with that product)
-- Show total quantity sold for each product


/*
SELECT --issue with this code (counts 12 inch teddy 1 as > 2)
			p.prod_name,
      CASE
      WHEN o.quantity >= 2
      THEN 'At least twice' ELSE 'Less' 
      END AS status,
      SUM(o.quantity) as total_quantity      
FROM Products p
LEFT JOIN OrderItems o 
ON o.prod_id = p.prod_id

GROUP BY 1,2
ORDER BY total_quantity DESC; */


--Essam solution
SELECT
		p.prod_id,
    p.prod_name,
    SUM(o.quantity) as total_quantity
FROM Products p 
LEFT JOIN OrderItems o
ON p.prod_id = o.prod_id
GROUP BY 1, 2
HAVING COUNT(o.order_num) >= 2

FINAL SOLUTION: 
SELECT
		p.prod_id,
    p.prod_name,
    SUM(o.quantity)
FROM Products p 
LEFT JOIN OrderItems o
ON p.prod_id = o.prod_id
GROUP BY 1, 2
HAVING COUNT(o.order_num) >= 2;