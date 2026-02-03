DROP TABLE IF EXISTS dim_date_cleaned;

CREATE TABLE dim_date_cleaned AS
SELECT
    date_id,
    full_date::date AS full_date,

    EXTRACT(YEAR FROM full_date::date)::int    AS year,
    EXTRACT(QUARTER FROM full_date::date)::int AS quarter,
    EXTRACT(MONTH FROM full_date::date)::int   AS month,
    TO_CHAR(full_date::date, 'Month')         AS month_name,
    EXTRACT(DOW FROM full_date::date)::int     AS dow,    
    TO_CHAR(full_date::date, 'Dy')            AS dow_name,
    CASE WHEN EXTRACT(DOW FROM full_date::date) IN (0,6) THEN 1 ELSE 0 END AS is_weekend
FROM dim_date_large
WHERE date_id IS NOT NULL
AND full_date IS NOT NULL;

ALTER TABLE dim_date_cleaned
ADD CONSTRAINT pk_dim_date_cleaned PRIMARY KEY (date_id);
