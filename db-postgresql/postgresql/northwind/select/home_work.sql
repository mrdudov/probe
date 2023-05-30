-- 1. Выбрать все данные из таблицы customers

SELECT *
FROM customers;

-- 2. Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город"

SELECT contact_name, city
FROM customers;

-- 3. Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку, значение в которой
--      мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.

SELECT order_id, shipped_date - order_date
FROM orders;

-- 4. Выбрать все уникальные города в которых "зарегестрированы" заказчики

SELECT DISTINCT city
FROM customers;

-- 5. Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики

SELECT DISTINCT city, country
FROM customers;

-- 6. Посчитать кол-во заказчиков

SELECT COUNT(*)
FROM customers;

-- 7. Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики

SELECT COUNT(DISTINCT country)
FROM customers;

-- 8. Выбрать все заказы из стран France, Austria, Spain

SELECT *
FROM orders
WHERE ship_country IN ('France', 'Austria', 'Spain');

-- 9. Выбрать все заказы, отсортировать по required_date (по убыванию) и отсортировать по дате отгрузке (по возрастанию)

SELECT * 
FROM orders
ORDER BY required_date DESC, shipped_date ASC;

-- 10. Выбрать минимальное кол-во  единиц товара среди тех продуктов, которых в продаже более 30 единиц.

SELECT MIN(units_in_stock) 
FROM products
WHERE units_in_stock > 30;

-- 11. Выбрать максимальное кол-во единиц товара среди тех продуктов, которых в продаже более 30 единиц.

SELECT MAX(units_in_stock) 
FROM products
WHERE units_in_stock > 30;

-- 12. Найти среднее значение дней уходящих на доставку с даты формирования заказа в USA

SELECT AVG(shipped_date - order_date)
FROM orders
WHERE ship_country = 'USA';

-- 13. Найти сумму, на которую имеется товаров (кол-во * цену) причём таких, 
--      которые планируется продавать и в будущем (см. на поле discontinued)

SELECT SUM(units_in_stock * unit_price)
FROM products
WHERE discontinued != 0;

-- 14. Выбрать все записи заказов в которых наименование страны отгрузки начинается с 'U'

SELECT *
FROM orders
WHERE ship_country LIKE 'U%';

-- 15. Выбрать записи заказов (включить колонки идентификатора заказа, идентификатора заказчика, веса и страны отгузки),
--      которые должны быть отгружены в страны имя которых начинается с 'N', отсортировать по весу (по убыванию) и вывести
--      только первые 10 записей.

SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 10;

-- 16. Выбрать записи работников (включить колонки имени, фамилии, телефона, региона) в которых регион неизвестен

SELECT first_name, last_name, home_phone, region
FROM employees
WHERE region IS NULL;

-- 17. Подсчитать кол-во заказчиков регион которых известен

SELECT COUNT(*)
FROM customers
WHERE region IS NOT NULL;

-- 18. Подсчитать кол-во поставщиков в каждой из стран и отсортировать результаты группировки по убыванию кол-ва

SELECT country, COUNT(*)
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;

-- 19. Подсчитать суммарный вес заказов (в которых известен регион) по странам, затем отфильтровать по 
--      суммарному весу (вывести только те записи где суммарный вес больше 2750) и отсортировать по убыванию 
--      суммарного веса.

SELECT ship_country, SUM(freight) 
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750 
ORDER BY SUM(freight) DESC;

-- 20. Выбрать все уникальные страны заказчиков и поставщиков и отсортировать страны по возрастанию

SELECT country
FROM customers
UNION
SELECT country
FROM suppliers
ORDER BY country;

-- 21. Выбрать такие страны в которых "зарегистированы" одновременно и заказчики и поставщики и работники.

SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers
INTERSECT
SELECT country
FROM employees;

-- 22. Выбрать такие страны в которых "зарегистированы" одновременно заказчики и поставщики, 
    --  но при этом в них не "зарегистрированы" работники.

SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers
EXCEPT
SELECT country
FROM employees; 
