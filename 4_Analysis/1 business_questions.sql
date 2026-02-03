-- What are our headline KPIs (total Revenue, total Units, total Transactions, ATV)?

SELECT
  SUM(fs.net_sales) AS total_revenue,
  SUM(fs.quantity_sold) AS total_units,
  COUNT(DISTINCT fs.sales_id) AS total_transactions,
  ROUND(
    SUM(fs.net_sales) / NULLIF(COUNT(DISTINCT fs.sales_id), 0)
  , 2) AS avg_transaction_value
FROM fact_sales_cleaned fs;

-- Which products generate the most revenue (Top 10)?

SELECT
  dp.product_id,
  dp.product_name,
  SUM(fs.net_sales) AS revenue,
  SUM(fs.quantity_sold) AS units
FROM fact_sales_cleaned fs
JOIN dim_product_cleaned dp ON dp.product_id = fs.product_id
GROUP BY dp.product_id, dp.product_name
ORDER BY revenue DESC
LIMIT 10;

-- Which categories contribute most to total revenue?

SELECT
  dp.category,
  SUM(fs.net_sales) AS revenue,
  ROUND(
    100.0 * SUM(fs.net_sales) / NULLIF(SUM(SUM(fs.net_sales)) OVER (), 0)
  , 2) AS revenue_share_pct
FROM fact_sales_cleaned fs
JOIN dim_product_cleaned dp ON dp.product_id = fs.product_id
GROUP BY dp.category
ORDER BY revenue DESC;
