DROP TABLE IF EXISTS fact_inventory_daily_cleaned;

CREATE TABLE fact_inventory_daily_cleaned AS
SELECT
    inventory_id,
    date_id,
    store_id,
    product_id,

    CASE
      WHEN stock_on_hand IS NULL OR stock_on_hand < 0 THEN 0
      ELSE stock_on_hand
    END AS stock_on_hand,

    CASE
      WHEN reorder_level IS NULL OR reorder_level < 0 THEN 0
      ELSE reorder_level
    END AS reorder_level

FROM fact_inventory_daily_large
WHERE 
  inventory_id IS NOT NULL
  AND date_id   IS NOT NULL
  AND store_id  IS NOT NULL
  AND product_id IS NOT NULL;

ALTER TABLE fact_inventory_daily_cleaned
ADD CONSTRAINT pk_fact_inventory_daily_cleaned
PRIMARY KEY (inventory_id,store_id,product_id,date_id);

CREATE INDEX IF NOT EXISTS ix_fact_inv_cleaned_inventory  ON fact_inventory_daily_cleaned(inventory_id);
CREATE INDEX IF NOT EXISTS ix_fact_inv_cleaned_date    ON fact_inventory_daily_cleaned(date_id);
CREATE INDEX IF NOT EXISTS ix_fact_inv_cleaned_store   ON fact_inventory_daily_cleaned(store_id);
CREATE INDEX IF NOT EXISTS ix_fact_inv_cleaned_product ON fact_inventory_daily_cleaned(product_id);

