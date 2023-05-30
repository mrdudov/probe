-- 1. Найти заказчиков и обслуживающих их заказы сотрудников таких, что и заказчики и
--     сотрудники из города London, а доставка идёт компанией Speedy Express.
--     Вывести компанию заказчика и ФИО сотрудника.
SELECT 
    customers.company_name, 
    employees.first_name, 
    employees.last_name
FROM orders
JOIN employees USING(employee_id)
JOIN customers USING(customer_id)
JOIN shippers ON shippers.shipper_id = orders.ship_via
WHERE 
    customers.city = 'London' 
    AND employees.city = 'London'
    AND shippers.company_name = 'Speedy Express';


-- 2. Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood,
--     которых в продаже менее 20 единиц. Вывести наименование продуктов, кол-во единиц
--     в продаже, имя контакта поставщика и его телефонный номер.
SELECT 
    products.product_name,
    products.units_in_stock,
    suppliers.contact_name,
    suppliers.phone
FROM products
JOIN categories USING(category_id)
JOIN suppliers USING(supplier_id)
WHERE
    products.units_in_stock < 20
    AND products.discontinued = 0
    AND category_name IN ('Beverages', 'Seafood');


-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT order_id, contact_name
FROM orders
RIGHT JOIN customers USING(customer_id)
WHERE order_id IS NULL;


-- 4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
SELECT order_id, contact_name
FROM customers
LEFT JOIN orders USING(customer_id)
WHERE order_id IS NULL;
