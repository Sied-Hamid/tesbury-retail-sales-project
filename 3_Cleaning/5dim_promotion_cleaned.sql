DROP TABLE IF EXISTS dim_promotion_cleaned;

CREATE TABLE dim_promotion_cleaned AS
SELECT
    promotion_id,

    CASE WHEN NULLIF(TRIM(promotion_name), '') IS NULL THEN 'Unknown' ELSE TRIM(promotion_name) END AS promotion_name,
    CASE
      WHEN discount_percent IS NULL THEN NULL
      WHEN discount_percent < 0 THEN 0
      WHEN discount_percent > 100 THEN 100
      ELSE discount_percent
    END AS discount_percent,
    CASE
      WHEN discount_percent IS NULL THEN 0
      WHEN discount_percent > 0 THEN 1
      ELSE 0
    END AS is_discounted,
    start_date,
    end_date

FROM dim_promotion_large
WHERE promotion_id IS NOT NULL;

ALTER TABLE dim_promotion_cleaned
ADD CONSTRAINT pk_dim_promotion_cleaned PRIMARY KEY (promotion_id);

COMMIT;
