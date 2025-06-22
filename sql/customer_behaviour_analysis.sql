-- Purpose: Understand how existing customers changed their behavior
-- Key Finding: Existing customers increased spending 40-160%

-- Customer spending behavior comparison (2018 vs 2019)
WITH orders_with_year AS (
    SELECT
        client_id,
        YEAR(order_date) AS order_year,
        (price_sold * order_quantity) AS order_value
    FROM orders
    WHERE YEAR(order_date) IN (2018, 2019)
),
customer_year_stats AS (
    SELECT
        client_id,
        order_year,
        COUNT(*) AS order_count,
        ROUND(AVG(order_value), 2) AS avg_order_value,
        ROUND(SUM(order_value), 2) AS total_spending
    FROM orders_with_year
    GROUP BY client_id, order_year
),
customers_2018 AS (
    SELECT DISTINCT client_id
    FROM customer_year_stats
    WHERE order_year = 2018
),
customers_2019 AS (
    SELECT DISTINCT client_id
    FROM customer_year_stats
    WHERE order_year = 2019
),
customers_both_years AS (
    SELECT client_id
    FROM customers_2018
    WHERE client_id IN (SELECT client_id FROM customers_2019)
)
SELECT
    c.client_id,
    COALESCE(y2018.avg_order_value, 0) AS avg_order_value_2018,
    COALESCE(y2019.avg_order_value, 0) AS avg_order_value_2019,
    COALESCE(y2018.order_count, 0) AS order_frequency_2018,
    COALESCE(y2019.order_count, 0) AS order_frequency_2019,
    COALESCE(y2018.total_spending, 0) AS total_spending_2018,
    COALESCE(y2019.total_spending, 0) AS total_spending_2019,
    -- Calculate percentage changes
    CASE 
        WHEN y2018.total_spending > 0 THEN 
            ROUND(((y2019.total_spending - y2018.total_spending) / y2018.total_spending) * 100, 1)
        ELSE NULL 
    END AS spending_change_percent
FROM customers_both_years c
LEFT JOIN customer_year_stats y2018 ON c.client_id = y2018.client_id AND y2018.order_year = 2018
LEFT JOIN customer_year_stats y2019 ON c.client_id = y2019.client_id AND y2019.order_year = 2019
ORDER BY spending_change_percent DESC;
