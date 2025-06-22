-- Customer distribution by country
SELECT
	c.country,
	count(distinct(c.client_id)) AS num_clients
FROM customers AS c
GROUP BY country
ORDER BY 2 DESC;

-- Customer acquisition by country (2018 vs 2019)
WITH first_orders AS (
    SELECT 
        client_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY client_id
),
first_orders_with_year AS (
    SELECT 
        fo.client_id,
        fo.first_order_date,
        DATE_FORMAT(fo.first_order_date, '%Y') AS order_year,
        c.country
    FROM first_orders fo
    LEFT JOIN customers c ON fo.client_id = c.client_id
    WHERE DATE_FORMAT(fo.first_order_date, '%Y') IN ('2018', '2019')
),
countrywise_acquisition AS (
    SELECT 
        order_year,
        country,
        COUNT(*) AS customers_acquired
    FROM first_orders_with_year
    GROUP BY order_year, country
)
SELECT 
    country,
    SUM(CASE WHEN order_year = '2018' THEN customers_acquired ELSE 0 END) AS customers_2018,
    SUM(CASE WHEN order_year = '2019' THEN customers_acquired ELSE 0 END) AS customers_2019,
    SUM(CASE WHEN order_year = '2018' THEN customers_acquired ELSE 0 END) - 
    SUM(CASE WHEN order_year = '2019' THEN customers_acquired ELSE 0 END) AS acquisition_change
FROM countrywise_acquisition
GROUP BY country
ORDER BY acquisition_change DESC;

-- Monthly acquisition trends for key markets
WITH first_orders AS (
    SELECT 
        client_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY client_id
),
first_orders_with_info AS (
    SELECT 
        fo.client_id,
        DATE_FORMAT(fo.first_order_date, '%Y-%m') AS acquisition_month,
        c.country
    FROM first_orders fo
    JOIN customers c ON fo.client_id = c.client_id
    WHERE c.country IN ('USA', 'Australia', 'Spain', 'France')
),
monthly_countrywise_acquisition AS (
    SELECT 
        acquisition_month,
        country,
        COUNT(*) AS customers_acquired
    FROM first_orders_with_info
    GROUP BY acquisition_month, country
)
SELECT 
    acquisition_month,
    country,
    customers_acquired
FROM monthly_countrywise_acquisition
ORDER BY acquisition_month, country;
