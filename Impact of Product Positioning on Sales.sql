CREATE TABLE product_positioning
(
    product_id int,
    product_position varchar(20),
    price numeric,
    competitors_price numeric, 
    promotion varchar(5),
    foot_traffic varchar(15),
    consumer_demographic varchar(25),
    product_category varchar(20),
    seasonal varchar(5),
    sales_volume int
);
	
select * from product_positioning;


-- What is the average price of the products?
select round(avg(price),2) as price, round(avg(competitors_price),2) as competitors_price from product_positioning;

-- What is the highest and lowest sales volume?
select max(sales_volume) as max_sales_vol, min(sales_volume) as min_sales_vol from product_positioning;

-- What is the count of each product position?
select product_position, count(product_position) from product_positioning group by product_position order by count(product_position) desc; 

-- How does seasonal affect sales volume and price?
select seasonal, round(avg(sales_volume)) as avg_sales_vol,
round(avg(price),2) as avg_price, 
round(avg(competitors_price),2) as avg_comp_price
from product_positioning 
group by seasonal 
order by avg(sales_volume) desc;


-- What is the product category with the highest average sales volume?
select product_category, round(avg(sales_volume)) as avg_sales_vol
from product_positioning
group by product_category
order by avg_sales_vol desc;

-- Finding the minimum and maximum price in each product position and the range of price in each position.
select product_position, 
min(price) as min_price, 
max(price) as max_price, 
max(price) - min(price) as price_range, 
round(avg(price),2) as avg_price
from product_positioning
group by product_position;


-- Finding the count of each foot traffic category in each product position.
select product_position, foot_traffic, count(*) as traffic_count
from product_positioning
group by product_position, foot_traffic;

-- Transposing the above

select product_position,
	sum(case when foot_traffic = 'High' then 1 else 0 end) as high_foot_traffic,
	sum(case when foot_traffic = 'Medium' then 1 else 0 end) as medium_foot_traffic,
	sum(case when foot_traffic = 'Low' then 1 else 0 end) as low_foot_traffic
from product_positioning
group by product_position
order by high_foot_traffic desc;


-- Finding the count of each foot traffic category in each consumer demographic.

select consumer_demographic,
	sum(case when foot_traffic = 'High' then 1 else 0 end) as high_foot_traffic,
	sum(case when foot_traffic = 'Medium' then 1 else 0 end) as medium_foot_traffic,
	sum(case when foot_traffic = 'Low' then 1 else 0 end) as low_foot_traffic
from product_positioning
group by consumer_demographic
order by high_foot_traffic desc;

-- Finding the most frequent product position a promotion will be applied.
select  product_position, count(*) as promotion_count
from product_positioning
where promotion = 'Yes'
group by product_position
order by promotion_count desc;

-- Finding how the product position affects where the promotions are applied.
select product_position, count(*) as promotion_count
from product_positioning
where promotion = 'Yes'
group by product_position
order by promotion_count desc;


-- What consumer demographic contributes most to the sales volume?
select consumer_demographic, sum(sales_volume) as total_num_sales
from product_positioning
group by consumer_demographic
order by total_num_sales desc;

-- Finding the 10 highest earning products, and the conditions in which these are met.
select 
	product_position, 
	price, 
	promotion, 
	foot_traffic, 
	consumer_demographic, 
	product_category, 
	seasonal, 
	sales_volume, 
	round(max(price * sales_volume),2) as total_revenue
from product_positioning
group by 
	product_position,
	price, 
	promotion, 
	foot_traffic, 
	consumer_demographic, 
	product_category, 
	seasonal, 
	sales_volume
order by  total_revenue desc
limit 10


