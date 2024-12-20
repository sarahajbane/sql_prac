-- Unicorn 
--EDA
/*
select customer_segment, count(*) as customers
from customers
group by customer_segment


select distinct product_category
from product

select product_category, product_subcategory, count(*)
from product
group by product_category, product_subcategory


select extract(year from order_date) as year, count(*)
from orders
group by year
order by year


select shipping_mode, count(*)
from orders
group by shipping_mode

select count(distinct shipping_city) as unique_cities,
count(distinct shipping_region) as unique_region,
count(distinct shipping_state) as unique_states
from orders

select distinct shipping_state as unique_states
from orders

select round(avg(quantity),2), min(quantity), max(quantity)
from order_details
*/









