create database sql_project_P1;
USE sql_project_P1;
CREATE TABLE retail_sales ( 
transactions_id int primary key ,	
sale_date date,
sale_time time,
customer_id int,
gender varchar (15),
age int,
category varchar (15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float);
Use sql_project_P1;
select count(*) 
from retail_sales;
Select * from retail_sales where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;
select count(distinct customer_id) from retail_sales;
select count(distinct category) from retail_sales;
select count(*)from retail_sales
where sale_date ='2022-11-05';
select * from retail_sales;
SELECT category,
       SUM(quantiy)
FROM retail_sales
WHERE category = 'clothing'
GROUP BY 1;
select *
from retail_sales
where category ='clothing' 
and quantiy >= 4;
SELECT * FROM retail_sales
WHERE Category = 'Clothing'
  AND STR_TO_DATE(sale_date, '%d-%m-%Y') BETWEEN '05-11-2022' AND '30-11-2022'
  and
 quantiy >= 4;
 select 
 category,
 sum(total_sale) as net_sale,
 count(*) as total_orders
 from retail_sales
 group by 1;
 SELECT 
  category,
  SUM(COALESCE(total_sale, 0)) AS net_sale,
  COUNT(*) AS total_orders
FROM retail_sales
WHERE category IS NOT NULL
GROUP BY category;
select count(*) from retail_sales
where total_sale>1000;
select
year(sale_date),
month(sale_date),
avg (total_sale) as avg_sales
RANK()over(partition by year(sale_date)order by avg (total_sale) desc)
 from retail_sales
 group by 1,2;
 SELECT * FROM 
 (SELECT
  YEAR(sale_date),
  MONTH(sale_date),
  AVG(total_sale) AS avg_sales,
  RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG (total_sale,) DESC))as rank
FROM retail_sales
GROUP BY 1, 2 as t1
where rank =1;
SELECT *
FROM (
  SELECT
    YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y')) AS year,
    MONTH(STR_TO_DATE(sale_date, '%d-%m-%Y')) AS month,
    AVG(COALESCE(total_sale, 0)) AS avg_sales,
    RANK() OVER (
      PARTITION BY YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y'))
      ORDER BY AVG(COALESCE(total_sale, 0)) DESC) AS rank
  FROM retail_sales
  GROUP BY
    YEAR(STR_TO_DATE(sale_date, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(sale_date, '%d-%m-%Y'))
) AS ranked_sales
WHERE rank = 1;
Use sql_project_p1;
SELECT *
FROM (
  SELECT
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    AVG(COALESCE(total_sale, 0)) AS avg_sales,
    RANK() OVER (
      PARTITION BY YEAR(sale_date)
      ORDER BY AVG(COALESCE(total_sale, 0)) DESC
    ) AS rank_in_year
  FROM retail_sales
  GROUP BY
    YEAR(sale_date),
    MONTH(sale_date)
) AS monthly_ranked_sales
WHERE rank_in_year = 1;

select
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

select 
category,
count(distinct customer_id)
from retail_sales
group by 1;

select*,
case 
when extract(hour from sale_time) < 12 then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift
from retail_sales;


