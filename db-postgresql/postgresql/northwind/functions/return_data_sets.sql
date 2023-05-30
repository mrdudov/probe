-- Return data sets 

CREATE OR REPLACE FUNCTION get_avarage_prices_by_prod_categories() 
        RETURNS SETOF double precision AS $$
    SELECT AVG(unit_price)
    FROM products
    GROUP BY category_id 
$$ LANGUAGE SQL;


SELECT *
FROM get_avarage_prices_by_prod_categories();



CREATE OR REPLACE FUNCTION get_avarage_prices_by_prod_cats(OUT sum_price real, OUT avg_price float8) 
        RETURNS SETOF RECORD AS $$
    SELECT SUM(unit_price), AVG(unit_price)
    FROM products
    GROUP BY category_id 
$$ LANGUAGE SQL;


SELECT *
FROM get_avarage_prices_by_prod_cats();

SELECT sum_price
FROM get_avarage_prices_by_prod_cats();

SELECT sum_price, avg_price
FROM get_avarage_prices_by_prod_cats();

DROP FUNCTION IF EXISTS get_avarage_prices_by_prod_cats;

CREATE OR REPLACE FUNCTION get_avarage_prices_by_prod_cats() 
        RETURNS SETOF RECORD AS $$
    SELECT SUM(unit_price), AVG(unit_price)
    FROM products
    GROUP BY category_id 
$$ LANGUAGE SQL;

SELECT get_avarage_prices_by_prod_cats();

SELECT * FROM get_avarage_prices_by_prod_cats() AS (sum_price real, avg_price float8);

CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country varchar)
        RETURNS TABLE (char_code char, company_name varchar) AS $$
    SELECT customer_id, company_name
    FROM customers
    WHERE country = customer_country
$$ LANGUAGE SQL;

SELECT *
FROM get_customers_by_country('USA');

SELECT company_name FROM get_customers_by_country('USA');


DROP FUNCTION IF EXISTS get_customers_by_country;

CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country varchar)
        RETURNS SETOF customers AS $$
    SELECT *
    FROM customers
    WHERE country = customer_country
$$ LANGUAGE SQL;

SELECT *
FROM get_customers_by_country('USA');
