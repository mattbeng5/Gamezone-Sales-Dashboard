-- Total sales across all years
SELECT ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders;

--Total Revenue = $6,151,266.49

-- Top 5 Selling Months
SELECT purchase_year, purchase_month, ROUND(SUM(usd_price)::NUMERIC, 2) AS monthly_revenue
FROM orders
WHERE purchase_year IS NOT NULL
GROUP BY purchase_year, purchase_month
ORDER BY monthly_revenue DESC
LIMIT 5;

--12/2020(549,435.13), 09/2020(456,871.49), 08/2020(395,864.45), 11/2020(384,162.77), 04/2020(351,555.08)

-- Lowest 5 Selling Months
SELECT purchase_year, purchase_month, ROUND(SUM(usd_price)::NUMERIC, 2) AS monthly_revenue
FROM orders
WHERE purchase_year IS NOT NULL
GROUP BY purchase_year, purchase_month
ORDER BY monthly_revenue
LIMIT 5;

-- 02/2019(80,389.10), 01/2019(100,491.28), 06/2019(108,450.52), 01/2020(109,935.63), 03/2019(115,193.98) 

-- Average Monthly Sales
SELECT purchase_month, ROUND(AVG(monthly_revenue)::NUMERIC, 2) AS avg_monthly_revenue
FROM(SELECT purchase_year, purchase_month, SUM(usd_price) AS monthly_revenue
		FROM orders
		WHERE purchase_year IS NOT NULL
		GROUP BY purchase_year, purchase_month)
GROUP BY purchase_month
ORDER BY purchase_month DESC ; 

-- Product Revenue Ranked 
SELECT product_name, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY product_name
ORDER BY total_revenue DESC;

-- Average product revenue by month
SELECT purchase_month, product_name, ROUND(AVG(usd_price)::NUMERIC, 2) as avg_monthly_revenue
FROM orders
WHERE purchase_month IS NOT NULL
GROUP BY product_name, purchase_month
ORDER BY purchase_month;


-- Marketing Channels Ranked
SELECT marketing_channel, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY marketing_channel
ORDER BY total_revenue DESC;

-- Account Creation Method Ranked
SELECT account_creation_method, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY account_creation_method
ORDER BY total_revenue DESC;

-- Revenue by Region
SELECT region, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY region
ORDER BY total_revenue DESC;

-- Top 5 countries 
SELECT country_code, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY country_code
ORDER BY total_revenue DESC
LIMIT 5;

-- Worst 5 countries
SELECT country_code, ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue
FROM orders
GROUP BY country_code
ORDER BY total_revenue
LIMIT 5;

-- Top Month Each Year
SELECT purchase_year, purchase_month, monthly_revenue
FROM(
	SELECT purchase_year, purchase_month, 
	ROUND(SUM(usd_price)::NUMERIC, 2) AS monthly_revenue,
	RANK() OVER(PARTITION BY purchase_year ORDER BY SUM(usd_price) DESC) AS rank
	FROM orders
	WHERE purchase_year IS NOT NULL
	GROUP BY purchase_year, purchase_month) ranked_months
WHERE RANK = 1;
	
-- KPI CTE
WITH kpis AS (
    SELECT 
        COUNT(*) AS total_orders,
        ROUND(SUM(usd_price)::NUMERIC, 2) AS total_revenue,
        ROUND(AVG(usd_price)::NUMERIC, 2) AS avg_order_value
    FROM orders
)
SELECT * FROM kpis;

--Monthly share of total revenue
WITH monthly_rev AS (SELECT  purchase_month, SUM(usd_price) AS revenue
    				FROM orders
    				GROUP BY purchase_month),total_rev AS (SELECT SUM(usd_price) AS total_revenue FROM orders)
SELECT purchase_month, ROUND(revenue::NUMERIC, 2) AS monthly_revenue,
    	ROUND((revenue::NUMERIC / total_revenue::NUMERIC) * 100, 2) AS pct_of_total
FROM monthly_rev, total_rev
WHERE purchase_month IS NOT NULL
ORDER BY purchase_month;







