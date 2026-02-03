DROP TABLE IF EXISTS fact_sales_cleaned;

CREATE TABLE fact_sales_cleaned AS
SELECT
    sales_id,
    date_id,
    store_id,
    product_id,
    customer_id,
    employee_id,
    promotion_id,

    CASE
      WHEN quantity_sold IS NULL OR quantity_sold < 0 THEN 0
      ELSE quantity_sold
    END AS quantity_sold,

    CASE
      WHEN payment_method IS NULL OR NULLIF(TRIM(payment_method), '') IS NULL THEN 'Unknown'
      WHEN TRIM(LOWER(payment_method)) IN ('card','credit card','debit card') THEN 'Card'
      WHEN TRIM(LOWER(payment_method)) IN ('online','digital','paypal') THEN 'Online'
      ELSE INITCAP(TRIM(payment_method))
    END AS payment_method,

    CASE WHEN gross_sales      IS NULL OR gross_sales      < 0 THEN 0 ELSE gross_sales      END AS gross_sales,
    CASE WHEN discount_amount  IS NULL OR discount_amount  < 0 THEN 0 ELSE discount_amount  END AS discount_amount,
    CASE WHEN net_sales        IS NULL OR net_sales        < 0 THEN 0 ELSE net_sales        END AS net_sales,
    CASE WHEN vat_amount       IS NULL OR vat_amount       < 0 THEN 0 ELSE vat_amount       END AS vat_amount,

--  net check: if net_sales missing but gross - discount exists
    CASE
      WHEN net_sales IS NULL AND gross_sales IS NOT NULL
        THEN GREATEST(gross_sales - COALESCE(discount_amount,0), 0)
      ELSE net_sales
    END AS net_sales_effective
FROM fact_sales_large
WHERE sales_id  IS NOT NULL
  AND date_id   IS NOT NULL
  AND store_id  IS NOT NULL
  AND product_id IS NOT NULL;

ALTER TABLE fact_sales_cleaned
ADD CONSTRAINT pk_fact_sales_cleaned PRIMARY KEY (sales_id);

CREATE INDEX IF NOT EXISTS ix_fact_sales_cleaned_date    ON fact_sales_cleaned(date_id);
CREATE INDEX IF NOT EXISTS ix_fact_sales_cleaned_store   ON fact_sales_cleaned(store_id);
CREATE INDEX IF NOT EXISTS ix_fact_sales_cleaned_product ON fact_sales_cleaned(product_id);
CREATE INDEX IF NOT EXISTS ix_fact_sales_cleaned_customer ON fact_sales_cleaned(customer_id);


