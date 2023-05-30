CREATE DATABASE test;

DROP DATABASE db_name;


CREATE TABLE person (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(7),
    date_of_birth DATE
);

DROP TABLE person;

CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150),
    gender VARCHAR(7) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50)
);

INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth
)
VALUES ('Anne', 'Smith', 'FEMALE', date '1988-01-09');

INSERT INTO person (
    first_name,
    last_name,
    gender,
    date_of_birth,
    email
)
VALUES ('Jake', 'Jonse', 'MALE', date '1990-12-31', 'jake@gmail.com');

SELECT * from person;

SELECT first_name, last_name FROM person;

-- 123 - ASC
-- 321 - DESC

SELECT * FROM person ORDER BY first_name DESC, country_of_birth ASC;

SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;

SELECT * 
FROM person 
WHERE 
    gender = 'Female' 
    AND 
        (country_of_birth = 'Poland' OR country_of_birth = 'China')
    AND
        last_name = 'Kim';

SELECT 1 = 1;
SELECT 1 <> 2; -- not equal

SELECT * FROM person LIMIT 10;

SELECT * FROM person OFFSET 10 LIMIT 10;

SELECT * FROM person OFFSET 5 FETCH FIRST 10 ROW ONLY;

SELECT *
FROM person
WHERE country_of_birth IN ('China', 'Brazil', 'France');


SELECT *
FROM person
WHERE date_of_birth BETWEEN DATE '2000-01-01' AND '2015-01-01';

SELECT * FROM person WHERE email LIKE '%.com';

SELECT * FROM person WHERE email LIKE '_____@%';

SELECT * FROM person WHERE country_of_birth ILIKE 'p%';

SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;

SELECT country_of_birth, COUNT(*) 
FROM person 
GROUP BY country_of_birth 
HAVING COUNT(*) > 5
ORDER BY country_of_birth;

SELECT MAX(price) FROM car;

SELECT MIN(price) FROM car;

SELECT ROUND(AVG(price)) FROM car;

SELECT make, model, MIN(price) FROM car GROUP BY make, model;

SELECT SUM(price) FROM car;

SELECT make, SUM(price) FROM car GROUP BY make;

SELECT 
    id, 
    make, 
    model, 
    price AS original_price, 
    ROUND(price * .10, 2) AS ten_percent_value, 
    ROUND(price - (price * .10), 2) AS discount_after_ten_percent
FROM car;

SELECT COALESCE(null, null, 1, 10) AS number;

SELECT COALESCE(email, 'Email not provided') FROM person;

SELECT 1 / 0;

SELECT NULLIF(10, 10);

SELECT NULLIF(10, 1);

SELECT 10 / NULLIF(0, 0);

SELECT COALESCE(10 / NULLIF(0, 0), 0);

SELECT NOW();

SELECT NOW()::DATE;

SELECT NOW()::TIME;

SELECT NOW() - INTERVAL '1 YEAR';

SELECT NOW() - INTERVAL '10 YEARS';

SELECT NOW() - INTERVAL '10 MONTHS';

SELECT (NOW() + INTERVAL '10 MONTHS')::DATE;

SELECT EXTRACT(YEAR FROM NOW());

SELECT 
    first_name,
    last_name,
    gender,
    country_of_birth,
    date_of_birth,
    AGE(NOW(), date_of_birth) AS age
FROM person;

ALTER TABLE person DROP CONSTRAINT person_pkey;

ALTER TABLE person ADD PRIMARY KEY (id);

SELECT email, COUNT(*) FROM person GROUP BY email HAVING COUNT(*) > 1;

ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE (email);

ALTER TABLE person DROP CONSTRAINT unique_email_address;

ALTER TABLE person ADD UNIQUE (email);

SELECT DISTINCT gender FROM person;

ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK (gender = 'Female' OR gender = 'Male');

DELETE FROM person; -- delete all rows

DELETE FROM person WHERE id = 5;

UPDATE person SET email = 'new@emaill.com' WHERE id = 4;

INSERT INTO 
    person (
        id,
        first_name, 
        last_name, 
        email, 
        gender, 
        date_of_birth, 
        country_of_birth) 
VALUES (
    1,
    'Abigail', 
    'Newman', 
    'melissa23@example.org', 
    'Male', 
    '1975-05-01', 
    'Turkmenistan'
)
ON CONFLICT (id) DO NOTHING;


INSERT INTO 
    person (
        id,
        first_name, 
        last_name, 
        email, 
        gender, 
        date_of_birth, 
        country_of_birth) 
VALUES (
    1,
    'Abigail', 
    'Newman', 
    'melissa23@another.com', -- <<<<< 
    'Male', 
    '1975-05-01', 
    'Turkmenistan'
)
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;
