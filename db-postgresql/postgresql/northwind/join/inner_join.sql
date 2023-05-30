SELECT 
    product_name, 
    suppliers.company_name, 
    units_in_stock 
FROM
    products
INNER JOIN 
    suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY 
    units_in_stock DESC;


SELECT 
    category_name, 
    SUM(units_in_stock)
FROM 
    products
INNER JOIN 
    categories ON products.category_id = categories.category_id
GROUP BY 
    category_name
ORDER BY 
    SUM(units_in_stock) DESC
LIMIT 
    5;


SELECT 
    category_name, 
    SUM(unit_price * units_in_stock)
FROM 
    products
INNER JOIN 
    categories ON products.category_id = categories.category_id
WHERE
    discontinued <> 1
GROUP BY
    category_name
HAVING
    SUM(unit_price * units_in_stock) > 5000
ORDER BY 
    SUM(unit_price * units_in_stock) DESC;


SELECT
    order_id,
    customer_id,
    first_name,
    last_name,
    title
FROM 
    orders
INNER JOIN 
    employees ON orders.employee_id = employees.employee_id;


SELECT 
    order_date,
    product_name,
    ship_country,
    products.unit_price,
    quantity,
    discount
FROM
    orders
INNER JOIN
    order_details ON orders.order_id = order_details.order_id
INNER JOIN
    products ON order_details.product_id = products.product_id;


SELECT
    contact_name, 
    company_name, 
    phone, 
    first_name, 
    last_name, 
    title,
    order_date, 
    product_name,
    ship_country, 
    products.unit_price,
    quantity, 
    discount
FROM 
    orders
JOIN 
    order_details USING(order_id)
JOIN
    products USING(product_id)
JOIN
    customers USING(customer_id)
JOIN 
    employees USING(employee_id)
WHERE
    ship_country = 'USA';


SELECT 
    order_id,
    customer_id,
    first_name,
    last_name
FROM
    orders
NATURAL JOIN -- never use NATURAL JOIN, this is bad practice
    employee;


SELECT 
    COUNT(*) AS employee_count
FROM
    employees;


SELECT 
    COUNT(DISTINCT country) AS country
FROM
    employees;


SELECT 
    category_id,
    SUM(units_in_stock) AS units_in_stock
FROM
    products
GROUP BY 
    category_id
ORDER BY
    units_in_stock DESC
LIMIT 
    5;


SELECT
    category_id,
    SUM(unit_price * units_in_stock) AS total_price
FROM
    products
WHERE
    discontinued <> 1
GROUP BY 
    category_id
HAVING 
    SUM(unit_price * units_in_stock) > 5000
ORDER BY
    total_price DESC;
