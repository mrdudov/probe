DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS car;


CREATE TABLE car (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC(19, 2) NOT NULL
);


CREATE TABLE person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150),
    gender VARCHAR(7) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50),
    car_id BIGINT REFERENCES car (id),
    UNIQUE(car_id)
);


INSERT INTO person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Abigail', 'Newman', 'melissa23@example.org', 'Male', '1975-05-01', 'Turkmenistan');
INSERT INTO person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Brandon', 'Chan', 'jeffanderson@example.com', 'Male', '2001-10-25', 'Greece');
INSERT INTO person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Christopher', 'Lopez', 'dianaduffy@example.org', 'Male', '1992-03-18', 'Liberia');


INSERT INTO car (make, model, price) values ('Ford', 'B-Class', '30840.13');
INSERT INTO car (make, model, price) values ('Isuzu', 'X1', '10000.06');

UPDATE person SET car_id = 2 WHERE id = 1;
UPDATE person SET car_id = 1 WHERE id = 2;

-- INNER JOIN
SELECT * FROM person
JOIN car ON person.car_id = car.id;

SELECT person.first_name, car.make, car.model, car.price
FROM person
JOIN car ON person.car_id = car.id;

-- LEFT JOIN
SELECT * FROM person
LEFT JOIN car ON person.car_id = car.id;

SELECT * FROM person
LEFT JOIN car ON person.car_id = car.id
WHERE car.* IS NULL;


INSERT INTO car (
    id,
    make, 
    model, 
    price) 
VALUES (10, 'Audi', 'F250 Super Duty Super Cab', '10291.28');

INSERT INTO person (
    id,
    first_name, 
    last_name, 
    email, 
    gender, 
    date_of_birth, 
    country_of_birth) 
VALUES (15, 'Stacey', 'Buchanan', NULL, 'Male', '2013-03-03', 'Congo');

UPDATE person SET car_id = 10 WHERE id = 15;

DELETE FROM car WHERE id = 10;

\copy (SELECT * FROM person LEFT JOIN car ON person.car_id = car.id) TO '/home/user/projects/db-probe/postgresql/results.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM person_id_seq;

SELECT nextval('person_id_seq'::regclass);

ALTER SEQUENCE person_id_seq RESTART WITH 16;
