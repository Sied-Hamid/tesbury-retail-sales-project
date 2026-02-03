DROP TABLE IF EXISTS dim_store_cleaned;

CREATE TABLE dim_store_cleaned AS
SELECT
    store_id,

    NULLIF(TRIM(store_name), '') AS store_name,

    CASE WHEN NULLIF(TRIM(city), '')   IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(city))   END AS city,
    CASE WHEN NULLIF(TRIM(region), '') IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(region)) END AS region,
    postcode,
    store_type,
    opening_date

FROM public.dim_store_large
WHERE store_id IS NOT NULL;

ALTER TABLE dim_store_cleaned
ADD CONSTRAINT pk_dim_store_cleaned PRIMARY KEY (store_id);

