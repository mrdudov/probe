# data types

1. Переписать функцию, которую мы разработали ранее в одном из ДЗ таким образом,
    чтобы функция возвращала экземпляр композитного типа. Вот та самая функция:

    ``` sql
    create or replace function get_salary_boundaries_by_city
    (
        emp_city varchar, out min_salary numeric, out max_salary numeric
    )
    AS $$
        SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
        FROM employees
        WHERE city = emp_city
    $$ language sql;
    ```

2. Задание состоит из пунктов:
    Создать перечисление армейских званий США, включающее следующие значения: Private, Corporal, Sergeant
    Вывести все значения из перечисления.
    Добавить значение Major после Sergeant в перечисление
    Создать таблицу личного состава с колонками: person_id, first_name, last_name, person_rank (типа перечисления)
    Добавить несколько записей, вывести все записи из таблицы
