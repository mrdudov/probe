SELECT * FROM pg_available_extensions;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT uuid_generate_v4();


DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS car;


CREATE TABLE car (
    car_uid UUID NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    price NUMERIC(19, 2) NOT NULL
);


CREATE TABLE person (
    person_uid UUID NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150),
    gender VARCHAR(7) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50),
    car_uid UUID REFERENCES car (car_uid),
    UNIQUE(car_uid)
);


INSERT INTO person (person_uid, first_name, last_name, email, gender, date_of_birth, country_of_birth) 
VALUES (uuid_generate_v4(), 'Abigail', 'Newman', 'melissa23@example.org', 'Male', '1975-05-01', 'Turkmenistan');

INSERT INTO person (person_uid, first_name, last_name, email, gender, date_of_birth, country_of_birth) 
VALUES (uuid_generate_v4(), 'Brandon', 'Chan', 'jeffanderson@example.com', 'Male', '2001-10-25', 'Greece');

INSERT INTO person (person_uid, first_name, last_name, email, gender, date_of_birth, country_of_birth) 
VALUES (uuid_generate_v4(), 'Christopher', 'Lopez', 'dianaduffy@example.org', 'Male', '1992-03-18', 'Liberia');


INSERT INTO car (car_uid, make, model, price) VALUES (uuid_generate_v4(), 'Ford', 'B-Class', '30840.13');
INSERT INTO car (car_uid, make, model, price) VALUES (uuid_generate_v4(), 'Isuzu', 'X1', '10000.06');


SELECT FROM person
JOIN car USING (car_uid);
