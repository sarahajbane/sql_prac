-- Unicorn Questions
/*
--What are the top 5 most sold productsacross all orders?
select 	p.product_name,
				sum(od.quantity) as total_quantity
from order_details od
join product p
using(product_id)
group by product_name
order by total_quantity desc
limit 5
-- (rank is an alternative to limit 5)

--Which customer placed the most orders?

select 	customer_name,
				count(order_id) as orders
from customers c
join orders o
using(customer_id)
group by customer_name
order by orders desc
limit 1

-- Which state generated the highest total sale?

select	shipping_state,
				sum(order_sales) as sales
from orders o
join order_details od
using(order_id)

group by shipping_state
order by sales desc
limit 1
*/

-- What is the average sales per order in each year?

select 	extract(year from order_date) as year,
				round(avg(order_sales),2) as avg_sales
              
from orders
join order_details
using(order_id)
group by year
order by avg_sales desc




