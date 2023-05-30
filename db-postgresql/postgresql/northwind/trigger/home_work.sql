-- Triggers home work

-- 1. Автоматизировать логирование времени последнего изменения в таблице products.
--     Добавить в products соответствующую колонку и реализовать построчный триггер.

ALTER TABLE products
ADD COLUMN last_updated timestamp;

CREATE OR REPLACE FUNCTION track_products_changes() RETURNS trigger AS $$
BEGIN
    NEW.last_updated = NOW();
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS products_timestamp ON products;

CREATE TRIGGER products_timestamp BEFORE INSERT OR UPDATE ON products
FOR EACH ROW EXECUTE PROCEDURE track_products_changes();

SELECT last_updated, * FROM products
WHERE product_id = 2;

ALTER TABLE products
DISABLE TRIGGER audit_products_update;

UPDATE products
SET unit_price = 22.5
WHERE product_id = 2;

SELECT last_updated, * FROM products
WHERE product_id = 2;

-- 2. Автоматизировать аудит операций в таблице order_details. Создайте отдельную
--     таблицу для аудита, добавьте туда колонки для хранения наименования операций,
--     имени пользователя и временного штампа. Реализуйте триггеры на утверждения.

DROP TABLE IF EXISTS order_details_audit;

CREATE TABLE order_details_audit
(
    op char(1) NOT NULL,
    user_changed text NOT NULL,
    time_stamp timestamp NOT NULL,

	order_id int2 NOT NULL,
	product_id int2 NOT NULL,
	unit_price float4 NOT NULL,
	quantity int2 NOT NULL,
	discount float4 NOT NULL
);

CREATE OR REPLACE FUNCTION build_audit_order_details() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO order_details_audit
        SELECT 'I', session_user, NOW(), nt.* FROM new_table nt;
    ELSEIF TG_OP = 'UPDATE' THEN 
        INSERT INTO order_details_audit
        SELECT 'U', session_user, NOW(), nt.* FROM new_table nt;
    ELSEIF TG_OP = 'DELETE' THEN 
        INSERT INTO order_details_audit
        SELECT 'D', session_user, NOW(), ot.* FROM old_table ot;
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS audit_order_details_insert ON order_details;
CREATE TRIGGER audit_order_details_insert AFTER INSERT ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update ON order_details;
CREATE TRIGGER audit_order_details_update AFTER UPDATE ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete ON order_details;
CREATE TRIGGER audit_order_details_delete AFTER DELETE ON order_details
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

SELECT *
FROM order_details
ORDER BY order_id DESC;

INSERT INTO order_details (order_id,product_id,unit_price,quantity,discount) 
VALUES (11900,77,13.0,2,0.0);

SELECT *
FROM order_details_audit;

UPDATE order_details
SET unit_price = 50
WHERE order_id = 11900;

SELECT *
FROM order_details_audit;

DELETE FROM order_details
WHERE order_id = 11900;

SELECT *
FROM order_details_audit;
