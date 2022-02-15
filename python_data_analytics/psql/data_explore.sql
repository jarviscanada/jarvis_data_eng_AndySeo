-- Show table schema 
\d+ retail;

-- Show first 10 rows
SELECT * 
FROM retail 
LIMIT 10;

-- Check # of records
SELECT COUNT(*) as num_records
FROM retail;

-- number of clients (e.g. unique client ID)
SELECT COUNT(DISTINCT customer_id) as num_clients
FROM retail;

--invoice date range (e.g. max/min dates)
SELECT MAX(invoice_date) as max,
	   MIN(invoice_date) as min
FROM retail;

--number of SKU/merchants (e.g. unique stock code)
SELECT COUNT(DISTINCT stock_code) as count
FROM retail;

--Calculate average invoice amount excluding invoices with a negative amount 
--(e.g. canceled orders have negative amount)
WITH cte as(SELECT invoice_no, quantity * unit_price as price
            FROM retail),
cte2 as(SELECT invoice_no,SUM(price) as sums
        FROM cte
        GROUP BY invoice_no)
SELECT AVG(sums)
FROM cte2
WHERE sums > 0;

--Calculate total revenue (e.g. sum of unit_price * quantity)
SELECT SUM(unit_price * quantity) as tot_revenue
FROM retail;
--Calculate total revenue by YYYYMM 
SELECT to_char(invoice_date , 'yyyymm') as yyyymm,SUM(unit_price * quantity) as tot_revenue
FROM retail
GROUP BY yyyymm
ORDER BY yyyymm;