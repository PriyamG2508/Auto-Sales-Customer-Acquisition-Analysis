-- Purpose: Uncover the revenue story behind declining acquisition
-- Key Finding: $789,951 additional revenue despite fewer customers

-- Monthly revenue trends
SELECT 
   DATE_FORMAT(o.order_date, '%Y-%m') AS month,
   SUM(o.order_quantity) AS total_quantity,
   count(o.order_id) AS total_orders,
   ROUND(SUM(o.price_sold * o.order_quantity), 2) AS total_sales
FROM orders o
GROUP BY month
ORDER BY month;

-- Yearly revenue comparison
SELECT 
   DATE_FORMAT(o.order_date, '%Y') AS year,
   SUM(o.order_quantity) AS total_quantity,
   count(o.order_id) AS total_orders,
   ROUND(SUM(o.price_sold * o.order_quantity), 2) AS total_sales
FROM orders o
GROUP BY year
ORDER BY year;

-- CRITICAL ANALYSIS: Country-wise revenue impact (2018 vs 2019)
WITH orders_with_country AS (
    SELECT 
        o.order_id,
        o.client_id,
        o.order_date,
        o.price_sold,
        o.order_quantity,
        (o.price_sold * o.order_quantity) AS sales_amount,
        c.country
    FROM orders o
    JOIN customers c ON o.client_id = c.client_id
    WHERE c.country IN ('USA', 'Australia', 'Spain', 'France')
),
orders_with_year AS (
    SELECT 
        *,
        YEAR(order_date) AS order_year
    FROM orders_with_country
    WHERE YEAR(order_date) IN (2018, 2019)
)
SELECT 
    country,
    ROUND(SUM(CASE WHEN order_year = 2018 THEN sales_amount ELSE 0 END), 2) AS sales_2018,
    ROUND(SUM(CASE WHEN order_year = 2019 THEN sales_amount ELSE 0 END), 2) AS sales_2019,
    ROUND(SUM(CASE WHEN order_year = 2019 THEN sales_amount ELSE 0 END) - 
          SUM(CASE WHEN order_year = 2018 THEN sales_amount ELSE 0 END), 2) AS revenue_change
FROM orders_with_year
GROUP BY country
ORDER BY revenue_change DESC;
-- KEY INSIGHT: USA +$490K, France +$242K despite fewer customers

-- Top customers by sales
SELECT
	c.client_name,
	ROUND(sum(o.order_quantity*o.price_sold), 2) AS total_sales,
	COUNT(o.order_id) AS num_orders,
	c.country
FROM orders AS o
LEFT JOIN customers AS c ON o.client_id = c.client_id 
GROUP BY c.client_name, c.country
ORDER BY total_sales DESC
LIMIT 10;
