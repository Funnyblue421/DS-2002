# Sets Wait Timeouts Longer
SET GLOBAL innodb_lock_wait_timeout = 5000;
SET innodb_lock_wait_timeout = 5000;

# Specifies Schema
USE sakila_dw;

# Adds New Columns
ALTER TABLE sakila_dw.fact_orders
ADD COLUMN payment_date_key int NOT NULL AFTER payment_date,
ADD COLUMN rental_date_key int NOT NULL AFTER rental_date,
ADD COLUMN return_date_key int NOT NULL AFTER return_date;

# Updates New Columns with Values from Dimension Table WHERE Business Keys in Both Tables Match
UPDATE sakila_dw.fact_orders AS fo
JOIN sakila_dw.dim_date AS dd
ON DATE(fo.payment_date) = dd.full_date
SET fo.payment_date_key = dd.date_key;

UPDATE sakila_dw.fact_orders AS fo
JOIN sakila_dw.dim_date AS dd
ON DATE(fo.rental_date) = dd.full_date
SET fo.rental_date_key = dd.date_key;

UPDATE sakila_dw.fact_orders AS fo
JOIN sakila_dw.dim_date AS dd
ON DATE(fo.return_date) = dd.full_date
SET fo.return_date_key = dd.date_key;

# Verifies that Newly Updated Columns have Correct Data
SELECT payment_date
	, payment_date_key
    , rental_date
	, rental_date_key
    , return_date
    , return_date_key
FROM sakila_dw.fact_orders
LIMIT 10;

# Drops Old Columns
ALTER TABLE northwind_dw.fact_orders
DROP COLUMN order_date,
DROP COLUMN shipped_date,
DROP COLUMN paid_date;

# Validates Finished Truth Table
SELECT * FROM sakila_dw.fact_orders
LIMIT 10;
