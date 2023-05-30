SELECT product_id, product_name, unit_price 
FROM products;

SELECT product_id, product_name, unit_price * units_in_stock
FROM products;

SELECT DISTINCT city
FROM employees;

SELECT DISTINCT city, country
FROM employees;

SELECT COUNT(*) 
FROM orders;

SELECT COUNT(DISTINCT country)
FROM employees;

SELECT company_name, contact_name, phone, country
FROM customers
WHERE country = 'USA';

SELECT *
FROM products
WHERE unit_price > 20;

SELECT COUNT(*)
FROM products
WHERE unit_price > 20;

SELECT *
FROM products
WHERE discontinued = 1;

SELECT *
FROM customers
WHERE city <> 'Berlin'; -- <> the same !=

SELECT *
FROM orders
WHERE order_date > '1998-03-01';

SELECT *
FROM products
WHERE unit_price > 25 AND units_in_stock > 40;


SELECT *
FROM customers
WHERE city = 'Berlin' OR city = 'London' OR city = 'San Francisco';

SELECT * 
FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 75 OR freight > 150); 

SELECT * 
FROM orders
WHERE freight BETWEEN 20 AND 40;

SELECT *
FROM customers
WHERE city IN ('Berlin', 'London', 'San Francisco');

SELECT *
FROM customers
WHERE city NOT IN ('Berlin', 'London', 'San Francisco');

SELECT DISTINCT country
FROM customers
ORDER BY country ASC;

SELECT DISTINCT country
FROM customers
ORDER BY country DESC;

SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city ASC;

SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London';

SELECT MAX(order_date)
FROM orders
WHERE ship_city = 'London';

SELECT AVG(unit_price)
FROM products
WHERE discontinued != 1;

SELECT SUM(units_in_stock)
FROM products
WHERE discontinued != 1;

SELECT last_name, first_name
FROM employees
WHERE first_name LIKE '%n';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'B%';

SELECT product_name, unit_price
FROM products
WHERE discontinued <> 1
ORDER BY unit_price DESC
LIMIT 10;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NULL;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NOT NULL;

SELECT ship_country, COUNT(*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC;

SELECT category_id, SUM(units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM(units_in_stock) DESC
LIMIT 5;

SELECT category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC;


SELECT country
FROM customers
UNION
SELECT country
FROM employees;

SELECT country
FROM customers
UNION ALL
SELECT country
FROM employees;

SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers;

SELECT country
FROM customers
EXCEPT
SELECT country
FROM suppliers;

SELECT country
FROM customers
EXCEPT ALL
SELECT country
FROM suppliers;
