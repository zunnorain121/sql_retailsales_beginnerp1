--sql retail analysis(p1)

create 
	database
	sql_project_2;
drop table 
	if exists
	retail_sale;

--create table

create Table retail_Sale (
      transactions_id int primary key,	
      sale_date DATE,
      sale_time TIME,
      customer_id	INT,
      gender varchar(15),
      age int,
      category varchar(15),	
      quantity int,
      price_per_unit int,	
      cogs float,
      total_sale int
);


select * from retail_sale
        where 
		transactions_id is null
		or 
		sale_date is null
		or
		sale_time is null
		or
		gender is null
		or 
		category is null
		or 
		quantity is null
		or
		cogs is null
		or 
		total_sale is null;

delete from retail_sale 
        where 
		transactions_id is null
		or 
		sale_date is null
		or
		sale_time is null
		or
		gender is null
		or 
		category is null
		or 
		quantity is null
		or
		cogs is null
		or 
		total_sale is null;

--data exploration


--complete data

select 
* from retail_sale;

--how many unique total customers we have?

select 
count(distinct(customer_id)) 
from retail_sale;

---how many sales do we have?

select 
count(*) as total_sale 
from retail_sale;

---how many categories do we have?

select 
count(distinct(category)) 
from retail_sale;

--what categories do we have?

select 
distinct(category) 
from retail_sale;

---DATA ANALYSIS AND BUSINESS PROBLEMS

--Q1) Write a sql query to retrieve all columns for sales made at date "2022-11-05"

select * from 
retail_sale
where sale_date='2022-11-05'; 

--q2)write a sql query to retrieve all transactions where the category is 'clothing' 
------and the quantity sold is more than equal to 4 in the meonth of nov 22?

select * 
from retail_sale 
where 
category='Clothing'
and
to_char(sale_date,'YYYY-MM')='2022-11'
and 
quantity>=4;

--q3)write a sql query to calculate the total sales for each category 

select
category,
count(total_sale),
sum(total_sale) 
as t_sales from retail_sale 
group by category;

--q4)write a sql query to calculate the average age of the customers who purcahsed from the beauty categor 

select 
count(customer_id),
round(AVG(age),2) 
from retail_sale 
where
category='Beauty';

--q5)write a query to find all the transactions where the total sale is greator than 1000?

select 
transactions_id 
from retail_sale
where total_sale>1000;

--q6)write a sql query to find a total number of transaction (transactions_id) made by each gender
--in each category ?

select
category,
gender, count(*) 
from retail_sale
group by category,gender
order by 1;

---q7)write a sql query calculate the average sale for each month,
--find out the best selling month in the year?

select year,
       month,
	avg
from
(
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg ,
rank() over(partition by extract(year from sale_date) order by avg(total_sale)) as rank
from retail_sale
group by 1,2
) 
as t1
where rank=1;

--q8)write a sql query to find the number of unique customer who purchased item from each category?

select 
count(distinct customer_id)
as unique_customers,
category
from retail_sale
group by
category

--q9)write a sql query to find the top 5 customers based on the highest total sales?

select 
customer_id,
sum(total_sale) as total
from retail_sale
group by customer_id
order by total desc
limit 5

--q10)write a sql query to create each shift and number of orders(example morning<=12,
--after between 12 & 17,evening>17)


select
CASE 
  when extract(hour from sale_time)<12 then 'morning'
  when extract(hour from sale_time) between 12 and 17 then 'afternoon'
  when extract(hour from sale_time)>17 then 'evening'
  end as shift,
  count(*) as orders
from retail_sale
group by shift


--end of beginners project 
