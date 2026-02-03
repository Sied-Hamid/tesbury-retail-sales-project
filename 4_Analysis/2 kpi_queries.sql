-- Which stores are the top and bottom performers by revenue?

-- TOP 10 
SELECT
  ds.store_id,
  ds.store_name,
  SUM(fs.net_sales) AS revenue
FROM fact_sales_cleaned fs
JOIN dim_store_cleaned ds ON ds.store_id = fs.store_id
GROUP BY ds.store_id, ds.store_name
ORDER BY revenue DESC
LIMIT 10;

-- BOTTOM 10
SELECT
  ds.store_id,
  ds.store_name,
  SUM(fs.net_sales) AS revenue
FROM fact_sales_cleaned fs
JOIN dim_store_cleaned ds ON ds.store_id = fs.store_id
GROUP BY ds.store_id,ds.store_name
ORDER BY revenue ASC
LIMIT 10;

-- What is the monthly revenue trend over time?

SELECT
  DATE_TRUNC('month', dd.full_date) AS month_start,
  SUM(fs.net_sales) AS revenue
FROM fact_sales_cleaned fs
JOIN dim_date_cleaned dd ON dd.date_id = fs.date_id
GROUP BY month_start 
ORDER BY month_start

-- What is Month-over-Month (MoM) revenue growth?

WITH monthly AS (
  SELECT
    DATE_TRUNC('month', dd.full_date) AS month_start,
    SUM(fs.net_sales) AS revenue
  FROM fact_sales_cleaned fs
  JOIN dim_date_cleaned dd ON dd.date_id = fs.date_id
  GROUP BY month_start
)
SELECT
  month_start,
  revenue,
  LAG(revenue) OVER (ORDER BY month_start) AS prev_month_revenue,
  ROUND(
    100 * (revenue - LAG(revenue) OVER (ORDER BY month_start))
    / NULLIF(LAG(revenue) OVER (ORDER BY month_start), 0)
  , 2) AS mom_growth_pct
FROM monthly
ORDER BY month_start;

-- What is Year-over-Year (YoY) revenue growth?

WITH monthly AS (
  SELECT
    DATE_TRUNC('month', dd.full_date) AS month_start,
    SUM(fs.net_sales) AS revenue
  FROM fact_sales_cleaned fs
  JOIN dim_date_cleaned dd ON dd.date_id = fs.date_id
  GROUP BY month_start
)
SELECT
  month_start,
  revenue,
  LAG(revenue, 12) OVER (ORDER BY month_start) AS revenue_last_year,
  ROUND(
    100 * (revenue - LAG(revenue, 12) OVER (ORDER BY month_start))
    / NULLIF(LAG(revenue, 12) OVER (ORDER BY month_start), 0)
  , 2) AS yoy_growth_pct
FROM monthly
ORDER BY month_start;

--What is the yearly revenue trend over time?
select 
    sum(net_sales) AS total_revenue,
    DATE_TRUNC('year',dd.full_date) as yearly
from 
    fact_sales_cleaned fs
inner JOIN dim_date_cleaned dd ON fs.date_id = dd.date_id
GROUP BY yearly
ORDER BY yearly