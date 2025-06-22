-- Purpose: Investigate customer acquisition trends over time
-- Key Finding: 46% decline in acquisition rate 2018 to 2019

-- Each customer's first order date
SELECT 
    client_id,
    MIN(order_date) as first_order_date,
    DATE_FORMAT(MIN(order_date), '%Y-%m') as acquisition_month
FROM orders 
GROUP BY client_id;

-- Monthly customer acquisition trends
SELECT 
    acquisition_month,
    COUNT(*) as new_customers_acquired
FROM (
    SELECT 
        client_id,
        MIN(order_date) as first_order_date,
        DATE_FORMAT(MIN(order_date), '%Y-%m') as acquisition_month
    FROM orders 
    GROUP BY client_id
) as first_orders
GROUP BY acquisition_month
ORDER BY acquisition_month;

-- Cumulative customer acquisition
SELECT 
    acquisition_month,
    new_customers_acquired,
    SUM(new_customers_acquired) OVER (ORDER BY acquisition_month) as cumulative_customers
FROM (
    SELECT 
        acquisition_month,
        COUNT(*) as new_customers_acquired
    FROM (
        SELECT 
            client_id,
            MIN(order_date) as first_order_date,
            DATE_FORMAT(MIN(order_date), '%Y-%m') as acquisition_month
        FROM orders 
        GROUP BY client_id
    ) as first_orders
    GROUP BY acquisition_month
    ORDER BY acquisition_month
) as monthly_acquisitions
ORDER BY acquisition_month;

-- CRITICAL FINDING: Year-over-year acquisition comparison
WITH first_orders AS (
    SELECT 
        client_id,
        MIN(order_date) AS first_order_date,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS acquisition_month
    FROM orders
    GROUP BY client_id
),
monthly_acquisitions AS (
    SELECT 
        acquisition_month,
        COUNT(*) AS new_customers_acquired
    FROM first_orders
    GROUP BY acquisition_month
),
monthly_acquisitions_with_year AS (
    SELECT 
        acquisition_month,
        new_customers_acquired,
        SUBSTRING(acquisition_month, 1, 4) AS year
    FROM monthly_acquisitions
    WHERE SUBSTRING(acquisition_month, 1, 4) IN ('2018', '2019')
)
SELECT 
    year,
    AVG(new_customers_acquired) AS avg_customers_per_month,
    ROUND(AVG(new_customers_acquired), 1) AS rounded_avg
FROM monthly_acquisitions_with_year
GROUP BY year
ORDER BY year;
