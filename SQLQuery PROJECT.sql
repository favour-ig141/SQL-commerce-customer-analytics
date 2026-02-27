/*=========================================================================================================
RETAIL CUSTOMER & REVENUE INTELLIGENCE ANALYSIS 
AUTHOR: Favour Arigbo
Description: End -to-end SQL businesses analysis project
===========================================================================================================*/

/*==========================================================================================================
1. DATA QUALITY CHECKS
============================================================================================================*/

--Checks for duplicates customers
select customer_id, count(*)
FROM CUSTOMERS
GROUP BY customer_id
having count(*) >1;

--CHECK FOR NULL VALUES
SELECT * FROM CUSTOMERS
WHERE customer_id is null
or customer_name is null
or region is null;


--validate revenue calculation
select
O. order_id,
O.total_amount,
sum(od.quantity * od.unit_price) as calculated_revenue
from dbo.ORDERS O
join dbo.ORDER_DETAILS OD
ON O.order_id=OD.order_id
GROUP BY O.order_id, O.total_amount
having  o.total_amount <> sum(od.quantity * od.unit_price) ;
/*===================================================================================================================
2. TOTAL COMPANY REVENUE
====================================================================================================================*/
SELECT 
sum(OD.quantity * OD.unit_price) as TOTAL_COMPANY_REVENUE from ORDER_DETAILS OD

/*=====================================================================================================================
3. TOP 10 CUSTOMERS BY REVENUE
====================================================================================================================*/
select top 10
c.customer_id,
c.customer_name,
sum(od.quantity * od.unit_price) as total_revenue
from CUSTOMERS c 
join ORDERS o on c.customer_id=o.customer_id
join ORDER_DETAILS od  on  o.order_id=od.order_id
group by c.customer_id,c.customer_name
order by total_revenue desc 


/*=========================================================================================================================
4. REVENUE CONTRIBUTION OF TOP 10 CUSTOMERS
=====================================================================================================================*/
with customer_revenue as( 
select 
c.customer_name,
c.customer_id,
sum(od.quantity * od.unit_price) as total_revenue
from CUSTOMERS c 
join ORDERS o on c.customer_id=o.customer_id
join ORDER_DETAILS od on o.order_id=od.order_id
group by c.customer_id,c.customer_name
)
select top 10
customer_name,
customer_id,
total_revenue,
(total_revenue *100.0/ sum(total_revenue) over ())
as revenue_percentage
from customer_revenue
order by revenue_percentage desc

/*==============================================================================================================================
5. REGIONAL PERFORMANCE ANALYSIS 
===============================================================================================================================*/
select c.region,
sum(od.quantity * od.unit_price)as region_revenue,
count(distinct c.customer_id) as total_customer,
avg(o.total_amount) avg_order_value
from CUSTOMERS c
join orders o on c.customer_id=o.customer_id
join ORDER_DETAILS od on o.order_id=od.order_id
group by c.region
order by region_revenue desc;

/*======================================================================================================================
6. PRODUCT CATEGORY PERFORMANCE 
======================================================================================================================*/
select 
p.category,
sum(od.quantity * od.unit_price) as category_revenue,
count(od.quantity) as total_unit_sold
from PRODUCTS p
join ORDER_DETAILS od on p.product_id=od.product_id
group by p.category
order by category_revenue, total_unit_sold desc ;

/*=======================================================================================================================
7. MONTHLY SALES TREND 
=====================================================================================================================*/

SELECT 
YEAR(O.ORDER_DATE) AS ORDER_YEAR,
MONTH(O.ORDER_DATE) AS ORDER_MONTH,
SUM(OD.QUANTITY * OD.UNIT_PRICE) AS MONTHLY_REVENUE
FROM ORDERS O
JOIN ORDER_DETAILS OD ON O.order_id=OD.order_id
GROUP BY YEAR(O.order_date), MONTH(O.order_date);


/*====================================================================================================================
8. CUSTOMER REVENUE RANKING 
======================================================================================================================*/

WITH CUSTOMER_REVENUE AS (
SELECT 
o.customer_id,
sum(od.quantity * od.unit_price) as total_revenue
from ORDERS o 
join ORDER_DETAILS od on o.order_id=od.order_id
group by o.customer_id
)
select cr.customer_id,
cr.total_revenue,
dense_rank() over (order by total_revenue desc) as revenue_rank
from CUSTOMER_REVENUE cr ;


/*========================================================================================================================
9. CUSTOMER SEGMENTATION (VIP-1 / CORE-2/ LOW-3) 
=========================================================================================================================*/

WITH customer_revenue as (
select 
o.customer_id,
sum(od.quantity * od.unit_price ) as total_revenue 
from ORDERS o
join ORDER_DETAILS od
on o.order_id=od.order_id
group by o.customer_id
)
select 
cr.customer_id,
cr.total_revenue,
ntile(3) over (order by total_revenue desc) as segment_group
from customer_revenue cr

/*=====================================================================================================================================
10. CHURN RISK DETECTION (90+ DAYS INACTIVE)
======================================================================================================================================*/

WITH last_order as (
select 
o.customer_id,
max(o.order_date) as last_order_date
from ORDERS o
group by o.customer_id
)
select 
lo.customer_id,
lo.last_order_date,
datediff(day,last_order_date,getdate()) as days_inactive,
case 
when datediff(day,last_order_date,getdate()) >= 90
then 'churn risk'
else 'active'
end as churn_status
from last_order lo
where datediff(day,last_order_date,getdate())>=90
order by days_inactive desc



select od.product_id,
count(od.quantity) as unit_sold,
sum(od.unit_price) as REVENUE
from ORDER_DETAILS od
group by od.product_id
order by unit_sold desc





select  * from customer_by_revenue
order by total_revenue

SELECT customer_id, count(*) 
FROM ORDERS
group by customer_id
having count(*) >1



SELECT * FROM ORDER_DETAILS
SELECT * FROM CUSTOMERS
SELECT * FROM PRODUCTS
select * from ORDERS