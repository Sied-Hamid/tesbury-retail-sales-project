-- Which city are underperforming relative to others?

SELECT
  ds.city,
  SUM(fs.net_sales) AS revenue,
  COUNT(DISTINCT fs.sales_id) AS transactions,
  ROUND(SUM(fs.net_sales) / NULLIF(COUNT(DISTINCT fs.sales_id), 0), 2) AS atv
FROM fact_sales_large fs
JOIN dim_store_large ds ON ds.store_id = fs.store_id
GROUP BY ds.city
ORDER BY revenue DESC;

-- Which products have high volume but low revenue (pricing or discount issue)?

WITH product_perf AS (
  SELECT
    dp.product_id,
    dp.product_name,
    SUM(fs.quantity_sold) AS units,
    SUM(fs.net_sales) AS revenue,
    ROUND(SUM(fs.net_sales) / NULLIF(SUM(fs.quantity_sold), 0), 2) AS net_price_per_unit
  FROM fact_sales_large fs
  JOIN dim_product_cleaned dp ON dp.product_id = fs.product_id
  GROUP BY dp.product_id, dp.product_name
)
SELECT *
FROM product_perf
WHERE units >= (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY units) FROM product_perf)
  AND net_price_per_unit <= (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY net_price_per_unit) FROM product_perf)
ORDER BY units DESC;

-- Are promotions actually improving performance (promo vs no promo)?

SELECT
  CASE WHEN fs.promotion_id IS NULL THEN 'No Promotion' ELSE 'Promotion' END AS promo_flag,
  SUM(fs.net_sales) AS revenue,
  SUM(fs.quantity_sold) AS units,
  COUNT(DISTINCT fs.sales_id) AS transactions,
  ROUND(SUM(fs.net_sales) / NULLIF(COUNT(DISTINCT fs.sales_id), 0), 2) AS atv
FROM fact_sales_cleaned fs
GROUP BY promo_flag
ORDER BY revenue DESC;

