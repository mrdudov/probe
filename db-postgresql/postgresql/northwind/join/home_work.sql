-- 1. Найти заказчиков и обслуживающих их заказы сотрудников таких, что и заказчики и 
--     сотрудники из города London, а доставка идёт компанией Speedy Express. 
--     Вывести компанию заказчика и ФИО сотрудника.
SELECT
    c.company_name,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name
FROM
    orders AS o
JOIN 
    employees AS e USING(employee_id)
JOIN
    shippers AS s ON o.ship_via = s.shipper_id
JOIN
    customers AS c USING(customer_id)
WHERE 
    e.city = 'London' 
    AND c.city = 'London'
    AND s.company_name = 'Speedy Express';



-- 2. Найти активные (см. поле discontinued) продукты из категории Beverages и Seafood,
--     которых в продаже менее 20 единиц. Вывести наименование продуктов, кол-во единиц 
--     в продаже, имя контакта поставщика и его телефонный номер.
SELECT 
    p.product_name,
    p.units_in_stock,
    s.contact_name,
    s.phone
FROM
    products AS p
JOIN
    categories AS c USING(category_id)
JOIN
    suppliers AS s USING(supplier_id)
WHERE
    c.category_name IN('Beverages', 'Seafood')
    AND p.discontinued = 0
    AND p.units_in_stock < 20
ORDER BY
    p.units_in_stock;



-- 3. Найти заказчиков, не сделавших ни одного заказа. Вывести имя заказчика и order_id.
SELECT 
    contact_name,
    order_id
FROM 
    orders
RIGHT JOIN
    customers USING(customer_id)
WHERE
    order_id IS NULL;



-- 4. Переписать предыдущий запрос, использовав симметричный вид джойна (подсказка: речь о LEFT и RIGHT).
SELECT 
    contact_name,
    order_id
FROM 
    customers
RIGHT JOIN
    order USING(customer_id)
WHERE
    order_id IS NULL;
 