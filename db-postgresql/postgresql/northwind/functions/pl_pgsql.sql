CREATE OR REPLACE FUNCTION get_total_number_of_goods() RETURNS bigint AS $$
BEGIN
    RETURN SUM(units_in_stock)
    FROM products;
END;
$$ LANGUAGE plpgsql;

SELECT get_total_number_of_goods();

CREATE OR REPLACE FUNCTION get_max_price_from_discontinued() RETURNS real AS $$
BEGIN
    RETURN MAX(unit_price)
    FROM products
    WHERE discontinued = 1;
END;
$$ LANGUAGE plpgsql;

SELECT get_max_price_from_discontinued();

DROP FUNCTION IF EXISTS get_price_boundaries;

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
BEGIN
    max_price := MAX(unit_price) FROM products;
    min_price := MIN(unit_price) FROM products;
END;
$$ LANGUAGE plpgsql;

SELECT get_price_boundaries();

DROP FUNCTION IF EXISTS get_price_boundaries;

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
BEGIN
    SELECT MAX(unit_price), MIN(unit_price)
    INTO max_price, min_price 
    FROM products;
END;
$$ LANGUAGE plpgsql;

SELECT get_price_boundaries();

SELECT * FROM get_price_boundaries();


CREATE OR REPLACE FUNCTION get_sum(x int, y int, OUT result int) AS $$
BEGIN
    result := x + y; -- the same result = x + y;
END;
$$ LANGUAGE plpgsql;

SELECT get_sum(1, 2);

DROP FUNCTION IF EXISTS get_customers_by_country;
CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country varchar) RETURNS SETOF customers AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM customers
    WHERE country = customer_country;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_customers_by_country('USA');


-- DECLARE

CREATE OR REPLACE FUNCTION get_square(ab real, bc real, ca real) RETURNS real AS $$
DECLARE
    perimetr real;
BEGIN
    perimetr = (ab + bc + ca) / 2;
    RETURN sqrt(perimetr * (perimetr - ab) * (perimetr - bc) * (perimetr - ca));
END;
$$ LANGUAGE plpgsql;

SELECT get_square(5,6,7);


CREATE FUNCTION calc_middle_price() RETURNS SETOF products AS $$
DECLARE
    avg_price real;
    low_price real;
    high_price real;
BEGIN
    SELECT AVG(unit_price) INTO avg_price
    FROM products;

    low_price = avg_price * 0.75;
    high_price = avg_price * 1.25;

    RETURN QUERY 
    SELECT *
    FROM products
    WHERE unit_price BETWEEN low_price AND high_price;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM calc_middle_price();
