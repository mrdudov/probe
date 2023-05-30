-- 1. Создать функцию, которая вычисляет средний фрахт по заданным странам (функция принимает список стран).

CREATE OR REPLACE FUNCTION get_avg_freight_by_countries(VARIADIC countries text[]) RETURNS float8 AS $$
    SELECT AVG(freight)
    FROM orders
    WHERE ship_country = ANY(countries);
$$ LANGUAGE SQL;

SELECT get_avg_freight_by_countries('USA', 'UK');

SELECT get_avg_freight_by_countries(VARIADIC ARRAY['USA', 'UK']);


-- 2. Написать функцию, которая фильтрует телефонные номера по коду оператора.
--     Принимает 3-х значный код мобильного оператора и список телефонных номеров в формате +1(234)5678901 (variadic)
--     Функция возвращает только те номера, код оператора которых соответствует значению соответствующего аргумента.
--     Проверить функцию передав следующие аргументы:
--     903, +7(903)1901235, +7(926)8567589, +7(903)1532476
--     Попробовать передать аргументы с созданием массива и без.
--     Подсказка: чтобы передать массив в VARIADIC-аргумент, надо перед массивом прописать, собственно, ключевое слово variadic.

CREATE OR REPLACE FUNCTION filtr_by_operator(oper int, VARIADIC numbers text[]) RETURNS SETOF text AS $$
DECLARE
    cur_val text;
BEGIN
    FOREACH cur_val IN ARRAY numbers
    LOOP
        RAISE NOTICE 'cur_val is %', cur_val;
        CONTINUE WHEN cur_val NOT LIKE CONCAT('__(', oper, ')%');
        RETURN NEXT cur_val;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM filtr_by_operator(903, '+7(903)1901235', '+7(926)8567589', '+7(903)1532476');

SELECT * FROM filtr_by_operator(903, VARIADIC ARRAY['+7(903)1901235', '+7(926)8567589', '+7(903)1532476']);
