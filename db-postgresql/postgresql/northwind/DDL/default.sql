DROP TABLE IF EXISTS customer;

CREATE TABLE customer
(
    customer_id serial,
    full_name text,
    status char DEFAULT 'r',

    CONSTRAINT PK_customer_customer_id PRIMARY KEY(customer_id),
    CONSTRAINT CHK_customer_status CHECK (status = 'r' OR status = 'p')
);

INSERT INTO customer (full_name)
VALUES
('name');

INSERT INTO customer (full_name, status)
VALUES
('name', 'p');

SELECT *
FROM customer;


ALTER TABLE customer
ALTER COLUMN status DROP DEFAULT;

INSERT INTO customer (full_name, status)
VALUES
('name', 'd');
