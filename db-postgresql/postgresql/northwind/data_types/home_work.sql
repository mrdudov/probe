-- 1. Переписать функцию, которую мы разработали ранее в одном из ДЗ таким образом,
--     чтобы функция возвращала экземпляр композитного типа. Вот та самая функция:

create or replace function get_salary_boundaries_by_city
(
    emp_city varchar, out min_salary numeric, out max_salary numeric
)
AS $$
    SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
    FROM employees
    WHERE city = emp_city
$$ language sql;

DROP TYPE IF EXISTS price_bounds;

CREATE TYPE IF NOT EXISTS price_bounds AS 
(
    min_price numeric,
    max_price numeric
);

CREATE OR REPLACE FUNCTION get_salary_boundaries_by_city(emp_city varchar) RETURNS SETOF price_bounds AS $$
    SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary 
    FROM employees
    WHERE city = emp_city
$$ language sql;

SELECT * FROM get_salary_boundaries_by_city('London');


-- 2. Задание состоит из пунктов:
--     Создать перечисление армейских званий США, включающее следующие значения: Private, Corporal, Sergeant
--     Вывести все значения из перечисления.
--     Добавить значение Major после Sergeant в перечисление
--     Создать таблицу личного состава с колонками: person_id, first_name, last_name, person_rank (типа перечисления)
--     Добавить несколько записей, вывести все записи из таблицы

CREATE TYPE army_rank AS ENUM 
(
    'Private',
    'Corporal',
    'Sergeant'
);

SELECT enum_range(null::army_rank);

ALTER TYPE army_rank
ADD VALUE 'Major' AFTER 'Sergeant';

SELECT enum_range(null::army_rank);

CREATE TABLE personnel 
(
    person_id serial PRIMARY KEY,
    first_name text,
    last_name text,
    person_rank army_rank
);

INSERT INTO personnel (first_name, last_name, person_rank)
VALUES
('Donald', 'Boyd', 'Private'),
('Alonzo', 'Duncan', 'Sergeant');

SELECT * 
FROM personnel;
