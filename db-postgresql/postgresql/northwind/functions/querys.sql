-- CREATE FUNCTION

SELECT *
FROM customers:

SELECT *
INTO tmp_customers
FROM customers;

SELECT *
FROM tmp_customers;

UPDATE tmp_customers
SET region = 'unknown'
WHERE region IS NULL;

CREATE OR REPLACE FUNCTION fix_customers_region() RETURNS void AS $$
    UPDATE tmp_customers
    SET region = 'unknown'
    WHERE region IS NULL;
$$ LANGUAGE SQL;

SELECT fix_customers_region();

SELECT *
FROM tmp_customers;

-- scalar functions 

CREATE OR REPLACE FUNCTION get_total_number_of_goods() RETURNS bigint AS $$
    SELECT SUM(units_in_stock)
    FROM products;
$$ LANGUAGE SQL;

SELECT get_total_number_of_goods();

CREATE OR REPLACE FUNCTION get_avg_price() RETURNS real AS $$
    SELECT avg(unit_price)
    FROM products;
$$ LANGUAGE SQL;

SELECT get_avg_price() AS avg_price;


-- in, out, default

CREATE OR REPLACE FUNCTION get_product_price_by_name(IN prod_name varchar) RETURNS real AS $$
    SELECT unit_price
    FROM products
    WHERE product_name = prod_name
$$ LANGUAGE SQL;


SELECT get_product_price_by_name('Chocolade') AS price;

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN(unit_price)
    FROM products
$$ LANGUAGE SQL;

SELECT get_price_boundaries();

SELECT * 
FROM get_price_boundaries();


CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinuity(IN is_discontinued int DEFAULT 1, OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN(unit_price)
    FROM products
    WHERE discontinued = is_discontinued
$$ LANGUAGE SQL;

SELECT get_price_boundaries_by_discontinuity();

SELECT * 
FROM get_price_boundaries_by_discontinuity();

SELECT * 
FROM get_price_boundaries_by_discontinuity(0);

