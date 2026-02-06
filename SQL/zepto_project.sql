drop table if exists zepto;

create table zepto (
	sku_id serial primary key,
	Category varchar(120),
	name varchar(150) not null,
	mrp numeric(10,2),
	discountPercent numeric(5,2),
	availableQuantity int,
	discountedSellingPrice numeric(10,2),
	weightInGms numeric(8,2),
	outOfStock boolean,
	quantity int
	);

	select * from zepto;
select count(*) from zepto;

select * from zepto;
limit 10;

truncate table zepto restart identity;

-- check for null values
select * from zepto
	where name is null
	or
	Category is null
	or
	mrp is null
	or
	discountPercent is null
	or
	availableQuantity is null
	or
	discountedSellingPrice is null
	or
	weightInGms is null
	or
	outOfStock is null
	or
	quantity is null;

-- different product categories
select distinct category
from zepto
order by category;


--products in stock vs out of stock

select * from zepto
where outofstock=false;

-- no of products in stock vs outofstock

select count(*) from zepto


select outofstock,Count(sku_id)
from zepto
group by outofstock;


-- product names present multiple times

select name, count(sku_id) as "no of SKU's"
from zepto
group by name
having count(sku_id)>1
order by count(sku_id) desc;


--DATA CLEANING
--PRODUCTS With price=0

select * from zepto
where discountedsellingprice=0 or mrp=0;

delete from zepto
where mrp=0;


--convert paise to rupee
update zepto 
set mrp= mrp/100,discountedsellingprice= discountedsellingprice/100;

select * from zepto;

--Found top 10 best-value products based on discount percentage

select * from zepto;
select distinct name, mrp, discountpercent
from zepto
order by discountpercent desc
limit 10;


--Identified high-MRP products that are currently out of stock

select distinct name, mrp
from zepto
where outofstock=true
order by mrp desc;

--Estimated potential revenue for each product category

select category,  sum(discountedsellingprice * availablequantity) as potential_revenue
from zepto 
group by category 
order by potential_revenue desc;

--Filtered expensive products (MRP > ₹500) with minimal discount (less than 10%)

select distinct name, mrp, discountpercent
from zepto
where mrp>500 and discountpercent<10
order by mrp desc;


--Ranked top 5 categories offering highest average discounts
select category,round(avg(discountpercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

--Calculated price per gram for products above 100 gm and sort by best value

select distinct name, discountedsellingprice, weightingms, round(discountedsellingprice/weightingms,2) as Price_per_GM
from zepto
where weightingms >= 100
order by price_per_GM;

--Grouped products based on weight into Low, Medium, and Bulk categories


--Measured total inventory weight per product category
