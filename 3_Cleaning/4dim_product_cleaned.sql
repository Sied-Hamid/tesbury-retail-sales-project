DROP TABLE IF EXISTS dim_product_cleaned;

CREATE TABLE dim_product_cleaned AS
SELECT
    product_id,

    CASE WHEN NULLIF(TRIM(product_name), '') IS NULL THEN 'Unknown' ELSE TRIM(product_name) END AS product_name,
    CASE WHEN NULLIF(TRIM(brand), '') IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(brand)) END AS brand,
    CASE WHEN NULLIF(TRIM(category), '') IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(category)) END AS category,
    CASE WHEN NULLIF(TRIM(subcategory), '') IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(subcategory)) END AS subcategory,
    unit_cost,
    unit_price
FROM dim_product_large
WHERE product_id IS NOT NULL;

ALTER TABLE dim_product_cleaned
ADD CONSTRAINT pk_dim_product_cleaned PRIMARY KEY (product_id);
