-- Show table schema 
\d+ retail;

-- Show first 10 rows
SELECT * 
FROM retail 
limit 10;

-- Check # of records
select COUNT(*) as num_records
from retail;

-- number of clients (e.g. unique client ID)
select count(distinct customer_id) as num_clients
from retail;

--invoice date range (e.g. max/min dates)
select max(invoice_date) as max, 
	   min(invoice_date) as min
from retail;

--number of SKU/merchants (e.g. unique stock code)
select count(distinct stock_code) as count
from retail;

--Calculate average invoice amount excluding invoices with a negative amount 
--(e.g. canceled orders have negative amount)
with cte as(SELECT invoice_no, quantity * unit_price as price
FROM retail),
cte2 as(select invoice_no,sum(price) as sums
from cte
group by 1)
select avg(sums)
from cte2
where sums > 0;

--Calculate total revenue (e.g. sum of unit_price * quantity)
select sum(unit_price * quantity) as tot_revenue
from retail;
--Calculate total revenue by YYYYMM 
SELECT to_char(invoice_date , 'yyyymm') as yyyymm,sum(unit_price * quantity) as tot_revenue
from retail
group by 1
order by yyyymm;

