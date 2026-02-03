DROP TABLE IF EXISTS dim_employee_cleaned;

CREATE TABLE dim_employee_cleaned AS
SELECT
    employee_id,

    CASE WHEN NULLIF(TRIM(employee_role), '') IS NULL THEN 'Unknown' ELSE INITCAP(TRIM(employee_role)) END AS employee_role,

    store_id,

    CASE
      WHEN hire_date IS NULL THEN NULL
      ELSE hire_date::date
    END AS hire_date
FROM dim_employee_large
WHERE employee_id IS NOT NULL;

ALTER TABLE dim_employee_cleaned
ADD CONSTRAINT pk_dim_employee_cleaned PRIMARY KEY (employee_id);

