CREATE TABLE dim_customer_large (
    customer_id     INT PRIMARY KEY,
    gender          VARCHAR(10) NOT NULL,
    age_band        VARCHAR(10) NOT NULL,
    loyalty_member  BOOLEAN NOT NULL,
    signup_date     DATE NOT NULL
);
CREATE TABLE dim_date_large (
    date_id       INT PRIMARY KEY,
    full_date     DATE NOT NULL,
    day_of_week   VARCHAR(10) NOT NULL,
    week_number   INT NOT NULL,
    month         INT NOT NULL,
    month_name    VARCHAR(15) NOT NULL,
    quarter       INT NOT NULL,
    year          INT NOT NULL,
    is_weekend    BOOLEAN NOT NULL
);
CREATE TABLE dim_employee_large (
    employee_id    INT PRIMARY KEY,
    employee_role  VARCHAR(30) NOT NULL,
    store_id       INT NOT NULL,
    hire_date      DATE NOT NULL,
    CONSTRAINT fk_employee_store
    FOREIGN KEY (store_id) REFERENCES dim_store_large(store_id)
);
CREATE TABLE dim_product_large (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(100) NOT NULL,
    category      VARCHAR(50) NOT NULL,
    subcategory   VARCHAR(50) NOT NULL,
    brand         VARCHAR(50) NOT NULL,
    unit_cost     NUMERIC(10,2) NOT NULL,
    unit_price    NUMERIC(10,2) NOT NULL
);
CREATE TABLE dim_promotion_large (
    promotion_id      INT PRIMARY KEY,
    promotion_name    VARCHAR(50) NOT NULL,
    discount_percent  NUMERIC(5,2) NOT NULL,
    start_date        DATE NOT NULL,
    end_date          DATE NOT NULL
);
CREATE TABLE dim_store_large (
    store_id      INT PRIMARY KEY,
    store_name    VARCHAR(100) NOT NULL,
    city          VARCHAR(50) NOT NULL,
    region        VARCHAR(50) NOT NULL,
    postcode      VARCHAR(10) NOT NULL,
    store_type    VARCHAR(20) NOT NULL,
    opening_date  DATE NOT NULL
);
CREATE TABLE fact_inventory_daily_large (
    inventory_id    BIGINT PRIMARY KEY,
    date_id         INT NOT NULL,
    store_id        INT NOT NULL,
    product_id      INT NOT NULL,
    stock_on_hand   INT NOT NULL,
    reorder_level   INT NOT NULL,

    CONSTRAINT fk_inv_date FOREIGN KEY (date_id)    REFERENCES dim_date_large(date_id),
    CONSTRAINT fk_inv_store FOREIGN KEY (store_id)   REFERENCES dim_store_large(store_id),
    CONSTRAINT fk_inv_product FOREIGN KEY (product_id) REFERENCES dim_product_large(product_id)
);
CREATE TABLE fact_sales_large (
    sales_id         BIGINT PRIMARY KEY,
    date_id          INT NOT NULL,
    store_id         INT NOT NULL,
    product_id       INT NOT NULL,
    customer_id      INT NOT NULL,
    employee_id      INT NOT NULL,
    promotion_id     INT NOT NULL,
    quantity_sold    INT NOT NULL,
    payment_method   VARCHAR(10) NOT NULL,
    gross_sales      NUMERIC(12,2) NOT NULL,
    discount_amount  NUMERIC(12,2) NOT NULL,
    net_sales        NUMERIC(12,2) NOT NULL,
    vat_amount       NUMERIC(12,2) NOT NULL,

CONSTRAINT fk_sales_date FOREIGN KEY (date_id) REFERENCES dim_date_large(date_id),
CONSTRAINT fk_sales_store FOREIGN KEY (store_id) REFERENCES dim_store_large(store_id),
CONSTRAINT fk_sales_product FOREIGN KEY (product_id) REFERENCES dim_product_large(product_id),
CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES dim_customer_large(customer_id),
CONSTRAINT fk_sales_employee FOREIGN KEY (employee_id) REFERENCES dim_employee_large(employee_id),
CONSTRAINT fk_sales_promotion FOREIGN KEY (promotion_id) REFERENCES dim_promotion_large(promotion_id)
);
-- set ownership of the tables to the postgres user
ALTER TABLE public.dim_customer_large OWNER TO postgres;
ALTER TABLE public.dim_date_large OWNER TO postgres;
ALTER TABLE public.dim_employee_large OWNER TO postgres;
ALTER TABLE public.dim_product_large OWNER TO postgres;
ALTER TABLE public.dim_promotion_large OWNER TO postgres;
ALTER TABLE public.dim_store_large OWNER TO postgres;
ALTER TABLE public.fact_inventory_daily_large OWNER TO postgres;
ALTER TABLE public.fact_sales_large OWNER TO postgres;

-- create indexes on foreign key columns for better performance
CREATE INDEX idx_sales_date ON fact_sales_large(date_id);
CREATE INDEX idx_sales_store ON fact_sales_large(store_id);
CREATE INDEX idx_sales_product ON fact_sales_large(product_id);
CREATE INDEX idx_sales_customer ON fact_sales_large(customer_id);
CREATE INDEX idx_inv_date ON fact_inventory_daily_large(date_id);
CREATE INDEX idx_inv_store ON fact_inventory_daily_large(store_id);
CREATE INDEX idx_inv_product ON fact_inventory_daily_large(product_id);
