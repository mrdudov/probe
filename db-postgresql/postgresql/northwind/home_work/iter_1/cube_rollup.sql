-- 1 Вывести сумму продаж (цена * кол-во) по каждому сотруднику с подсчётом полного итога
--     (полной суммы по всем сотрудникам)  отсортировав по сумме продаж (по убыванию).
SELECT employee_id, ROUND(SUM(unit_price * quantity)::numeric, 2)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY ROLLUP(employee_id)
ORDER BY SUM(unit_price * quantity) DESC;


-- 2 Вывести отчёт показывающий сумму продаж по сотрудникам и странам отгрузки с подытогами по сотрудникам и общим итогом.
SELECT employee_id, ship_country,  ROUND(SUM(unit_price * quantity)::numeric, 2)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY ROLLUP(employee_id, ship_country)
ORDER BY employee_id, SUM(unit_price * quantity) DESC;


-- 3 Вывести отчёт показывающий сумму продаж по сотрудникам, странам отгрузки,
--     сотрудникам и странам отгрузки с подытогами по сотрудникам и общим итогом.
SELECT employee_id, ship_country, ROUND(SUM(unit_price * quantity)::numeric, 2)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY CUBE(employee_id, ship_country)
ORDER BY employee_id, SUM(unit_price * quantity) DESC;
