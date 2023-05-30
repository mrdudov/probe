-- CASE WHEN

SELECT product_name, unit_price, units_in_stock,
    CASE WHEN units_in_stock >= 100 THEN 'lots of'
         WHEN units_in_stock >= 50 AND units_in_stock < 100 THEN 'avarage'
         WHEN units_in_stock < 50 THEN 'low  number'
         ELSE 'unknown'
    END AS amount
FROM products
ORDER BY units_in_stock;


SELECT order_id, order_date,
    CASE
        WHEN date_part('month', order_date) BETWEEN 3 AND 5 THEN 'spring'
        WHEN date_part('month', order_date) BETWEEN 6 AND 8 THEN 'summer'
        WHEN date_part('month', order_date) BETWEEN 9 AND 11 THEN 'autumn'
        ELSE 'winter'
    END AS season
FROM orders;


SELECT product_name, unit_price,
    CASE
        WHEN unit_price >= 30 THEN 'expensive'
        WHEN unit_price < 30 THEN 'inexpensive'
        ELSE 'unknown'
    END AS price_description
FROM products;


-- COALESCE & NULLIF

SELECT *
FROM orders
LIMIT 10;

SELECT order_id, order_date, COALESCE(ship_region, 'unknown') AS ship_region
FROM orders
LIMIT 10;

SELECT *
FROM employees;

SELECT last_name, first_name, COALESCE(region, 'N/A') AS region
FROM employees;

SELECT * 
FROM customers;

SELECT contact_name, COALESCE(NULLIF(city, ''), 'unknown') AS city
FROM customers;

CREATE TABLE IF NOT EXISTS budgets
(
    dept serial,
    current_year decimal,
    previous_year decimal
);

INSERT INTO budgets (current_year, previous_year) VALUES(100000, 150000);
INSERT INTO budgets (current_year, previous_year) VALUES(NULL, 300000);
INSERT INTO budgets (current_year, previous_year) VALUES(0, 100000);
INSERT INTO budgets (current_year, previous_year) VALUES(NULL, 150000);
INSERT INTO budgets (current_year, previous_year) VALUES(300000, 250000);
INSERT INTO budgets (current_year, previous_year) VALUES(170000, 170000);
INSERT INTO budgets (current_year, previous_year) VALUES(150000, NULL);

SELECT * 
FROM budgets;

SELECT dept,
    COALESCE(TO_CHAR(NULLIF(current_year, previous_year), 'FM99999999'), 'Same as last year') as budget
FROM budgets
WHERE current_year IS NOT NULL;

DROP TABLE IF EXISTS budgets;
