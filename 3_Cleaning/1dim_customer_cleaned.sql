DROP TABLE IF EXISTS dim_customer_cleaned;

CREATE TABLE dim_customer_cleaned AS
SELECT
    customer_id,

    CASE
        WHEN TRIM(LOWER(gender)) IN ('male', 'm') THEN 'Male'
        WHEN TRIM(LOWER(gender)) IN ('female', 'f') THEN 'Female'
        ELSE 'Unknown'
    END AS gender,

    CASE
        WHEN TRIM(age_band) LIKE '%18%' THEN '18-25'
        WHEN TRIM(age_band) LIKE '%26%' THEN '26-35'
        WHEN TRIM(age_band) LIKE '%36%' THEN '36-50'
        WHEN TRIM(age_band) LIKE '%51%' THEN '51+'
        ELSE 'Unknown'
    END AS age_band,

    loyalty_member,

    CASE
        WHEN loyalty_member = TRUE THEN 1
        ELSE 0
    END AS is_loyalty_member,

    signup_date

FROM dim_customer_large
WHERE customer_id IS NOT NULL;
