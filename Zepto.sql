create database zepto;
use zepto

--- data exploration
select count(*) from zepto_v2

--- sample data
select * from zepto_v2
limit 10;

--- null values
select * from zepto_v2
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
quantity is null

--- Different product category
select distinct(Category) from zepto_v2
order by Category

--- Product in stock vs product out of stock
select outOfstock, count(outOfStock) as Quantity 
from zepto_v2 
group by outOfstock

--- Product name present multiple times
select name, count(name) as quantity  
from zepto_v2
group by name
having quantity >1
order by quantity desc

---data cleaning
--- product having price 0
select * from zepto_v2 where mrp=0 or discountedSellingPrice=0

delete from zepto_v2 where mrp=0

--- convert paise into rupees
update zepto_v2
set mrp=mrp/100,
discountedSellingPrice=discountedSellingPrice/100

---Q1. Find the top 10 best valued product based on discount percentage?
      
      select  distinct name, mrp, DiscountPercent from zepto_v2
       order by DiscountPercent desc
       limit 10
---Q2. What are the product with high MRP but out of stock?
       
       select distinct name, mrp, OutOfStock from zepto_v2
       where OutOfStock = 'TRUE' and mrp > 300
       order by mrp desc
       
---Q3. Calculate Estimated Revenue for each category?

	   select Category, sum(availableQuantity * discountedSellingPrice) as Total_revenue
       from zepto_v2
       group by Category
       order by Total_revenue desc
       
---Q4 Find all product where price is greater than 500 and discount is less than 10%.
      
      select name, mrp, discountPercent from zepto_v2 
      where discountPercent > 10 and mrp > 500 
      order by mrp desc, discountPercent desc
      
---Q5 Identify the top 5 category offering the highest average discount percentage.
	
       select Category, round(avg(discountPercent),2) as average_discount from zepto_v2
	   group by Category
	   order by average_discount desc 
	   limit 5
     
---Q6 Find the price per gram for products above 100 g and sort by best value.
      select name, discountedSellingPrice, weightInGms, round((discountedSellingPrice/weightInGms),2) as price_per_gms 
      from zepto_v2
      where weightInGms > 100 
      order by price_per_gms 
      
---Q7 Group the product into categories like low, Medium, Bulk.
	  select distinct name, weightInGms,
      case when weightInGms < 1000 then 'LOW'
		   when weightInGms between 1000 and 5000 then 'MEDIUM'
           else  'High'
           end as weight_category
	  from zepto_v2
---Q8 what is the Total Inventory Weight per category?.
      select Category, sum(weightInGms) as total_weight from zepto_v2 
      group by Category 
      order by total_weight desc.
