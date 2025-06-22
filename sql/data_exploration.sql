-- Purpose: Initial data understanding and quality assessment
-- Key Metrics: Order volumes, date ranges, sales totals

-- Overall orders summary
SELECT 
   count(o.order_id) AS total_order,
   count(distinct(o.order_id)) AS distinct_order,
   round(avg(order_linenumber),1) AS avg_order_item,
   DATE(min(o.order_date)) AS earliest_date,
   DATE(max(o.order_date)) AS latest_date,
   count(distinct o.order_status) AS status_count,
   round(sum(o.order_quantity*o.price_sold),2) AS total_sales,
   round(avg(o.order_quantity*o.price_sold),2) AS avg_sales
FROM orders AS o;

-- Order status distribution
SELECT 
	distinct(o.order_status),
	count(o.order_status) AS count,
	round((count(o.order_status)/ a.total_order)*100,2) AS percentage
FROM 
	orders AS o,
	(SELECT count(*) AS total_order FROM orders) AS a
GROUP BY o.order_status, a.total_order
ORDER BY 2 DESC;

-- Customer and geographic overview
SELECT
	count(distinct(c.client_id)) AS num_clients,
	count(distinct(c.country)) AS num_countries
FROM customers AS c;

-- Product catalog overview
SELECT
	count(distinct(p.product_line)) AS num_categories,
	count(distinct(p.product_code)) AS num_products
FROM products AS p;
