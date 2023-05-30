ALTER TABLE customers
ADD COLUMN last_updated timestamp;

CREATE OR REPLACE FUNCTION track_changes_on_customers() RETURNS trigger AS $$
BEGIN
    NEW.last_updated = now();
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS customers_timestamp ON customers;

CREATE TRIGGER customers_timestamp BEFORE INSERT OR UPDATE ON customers
    FOR EACH ROW EXECUTE PROCEDURE track_changes_on_customers();

SELECT * FROM customers;

UPDATE customers
SET address = 'test asddress'
WHERE customer_id = 'ALFKI';

SELECT * 
FROM customers
WHERE customer_id = 'ALFKI';

INSERT INTO customers 
(
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax,
    last_updated
)
VALUES
('AABBB','fake_company','Alfred Mann',NULL,NULL,NULL,NULL,NULL,'Austria',NULL,NULL,NULL);

SELECT * 
FROM customers
WHERE customer_id = 'AABBB';


ALTER TABLE employees
ADD COLUMN user_changed text;

CREATE OR REPLACE FUNCTION track_changes_on_employees() RETURNS trigger AS $$
BEGIN
    NEW.user_changed = session_user;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS employees_user ON employees;

CREATE TRIGGER employees_user BEFORE INSERT OR UPDATE ON employees
    FOR EACH ROW EXECUTE PROCEDURE track_changes_on_employees();

SELECT *
FROM employees;

UPDATE employees
SET postal_code = '99999'
WHERE employee_id = 1;


SELECT *
FROM employees
WHERE employee_id = 1;

INSERT INTO employees 
(
    employee_id,
    last_name,
    first_name,
    title,title_of_courtesy,
    birth_date,
    hire_date,
    address,
    city,region,
    postal_code,
    country,
    home_phone,
    "extension",
    photo,
    notes,
    reports_to,
    photo_path,
    user_changed
) 
VALUES
(10,'Buchanan','Steven','Sales Manager','Mr.','1955-03-04','1993-10-17','14 Garrett Hill','London',NULL,'SW1 8JR','UK','(71) 555-4848','3453',decode('','hex'),'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses Successful Telemarketing and International Sales Management.  He is fluent in French.',2,'http://accweb/emmployees/buchanan.bmp',NULL);

SELECT *
FROM employees
WHERE employee_id = 10;


DROP TABLE IF EXISTS products_audit;

CREATE TABLE products_audit
(
    op char(1) NOT NULL,
    user_changed text NOT NULL,
    time_stamp timestamp NOT NULL,

	product_id smallserial NOT NULL,
	product_name varchar(40) NOT NULL,
	supplier_id int2 NULL,
	category_id int2 NULL,
	quantity_per_unit varchar(20) NULL,
	unit_price float4 NULL,
	units_in_stock int2 NULL,
	units_on_order int2 NULL,
	reorder_level int2 NULL,
	discontinued int4 NOT NULL
);

CREATE OR REPLACE FUNCTION build_audit_products() RETURNS trigger AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO products_audit
        SELECT 'I', session_user, NOW(), nt.* FROM new_table nt;
    ELSEIF TG_OP = 'UPDATE' THEN 
        INSERT INTO products_audit
        SELECT 'U', session_user, NOW(), nt.* FROM new_table nt;
    ELSEIF TG_OP = 'DELETE' THEN 
        INSERT INTO products_audit
        SELECT 'D', session_user, NOW(), ot.* FROM old_table ot;
    END IF;
    RETURN NULL;
END
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS audit_products_insert ON products;
CREATE TRIGGER audit_products_insert AFTER INSERT ON products
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_products();

DROP TRIGGER IF EXISTS audit_products_update ON products;
CREATE TRIGGER audit_products_update AFTER UPDATE ON products
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_products();

DROP TRIGGER IF EXISTS audit_products_delete ON products;
CREATE TRIGGER audit_products_delete AFTER DELETE ON products
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_products();


SELECT *
FROM products
ORDER BY product_id DESC;

INSERT INTO products 
(
    product_name,supplier_id,category_id,quantity_per_unit,unit_price,
    units_in_stock,units_on_order,reorder_level,discontinued
) 
VALUES
('Konbu',6,8,'2 kg box',6.0,24,0,5,0);

SELECT * FROM products_audit;

UPDATE products
SET unit_price = 60
WHERE product_id = 79;

SELECT * FROM products_audit;

DELETE FROM products
WHERE product_id = 79;

SELECT * FROM products_audit;

