CREATE DOMAIN text_no_space_null AS text NOT NULL CHECK (value ~ '^(?!\s*$).+');

CREATE TABLE agent 
(
    first_name text_no_space_null,
    last_name text_no_space_null
);

INSERT INTO agent
VALUES ('bob', 'taylor');

SELECT * FROM agent;

INSERT INTO agent
VALUES ('', 'taylor');

INSERT INTO agent
VALUES (NULL, 'taylor');

INSERT INTO agent
VALUES ('   ', 'taylor');

INSERT INTO agent
VALUES ('bob junior', 'taylor');

SELECT * FROM agent;

ALTER DOMAIN text_no_space_null
ADD CONSTRAINT text_no_space_null_length32 CHECK (length(value)<=32) NOT VALID;

ALTER DOMAIN text_no_space_null
VALIDATE CONSTRAINT text_no_space_null_length32;

DROP TABLE IF EXISTS agent;
DROP DOMAIN IF EXISTS text_no_space_null;

-- Composite Types

DROP FUNCTION IF EXISTS get_price_boundaries;

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
    SELECT MAX(unit_price), MIN(unit_price)
    FROM products
$$ LANGUAGE SQL;

SELECT * FROM get_price_boundaries();

CREATE TYPE price_bounds AS 
(
    max_price real,
    min_price real
);

DROP FUNCTION IF EXISTS get_price_boundaries;

CREATE OR REPLACE FUNCTION get_price_boundaries() RETURNS SETOF price_bounds AS $$
    SELECT MAX(unit_price), MIN(unit_price)
    FROM products
$$ LANGUAGE SQL;

SELECT * FROM get_price_boundaries();

CREATE TYPE complex AS 
(
    r float8,
    i float8
);

CREATE TABLE math_calcs
(
    math_id serial,
    val complex
);


INSERT INTO math_calcs (val)
VALUES 
(ROW(3.0, 4.0)),
(ROW(2.0, 1.0));

SELECT * FROM math_calcs;

SELECT (val).r FROM math_calcs;

SELECT (math_calcs.val).r FROM math_calcs;

SELECT (val).* FROM math_calcs;

UPDATE math_calcs
SET val = ROW(5.0, 4.0)
WHERE math_id = 1;

SELECT * FROM math_calcs;

UPDATE math_calcs
SET val.r= 7.9
WHERE math_id = 1;

SELECT * FROM math_calcs;

UPDATE math_calcs
SET val.r = val.r + 0.9
WHERE math_id = 1;

SELECT * FROM math_calcs;

-- Enumerated Types

CREATE TABLE IF NOT EXISTS chess_title
(
    title_id serial PRIMARY KEY,
    title text
);

INSERT INTO chess_title (title)
VALUES
('Candidate Master'),
('FIDE Master'),
('International Master'),
('Grand Master');

SELECT * FROM chess_title;


CREATE TABLE IF NOT EXISTS chess_player
(
    player_id serial PRIMARY KEY,
    first_name text,
    last_name text,
    title_id int REFERENCES chess_title(title_id)
);

INSERT INTO chess_player (first_name, last_name, title_id)
VALUES
('Wesly', 'So', 4),
('Vlad', 'Kramnik', 4),
('Vasily', 'Pupkin', 1);

SELECT * 
FROM chess_player
JOIN chess_title USING(title_id);


DROP TABLE IF EXISTS chess_player;
DROP TABLE IF EXISTS chess_title;


CREATE TYPE chess_title AS ENUM
(
    'Candidate Master',
    'FIDE Master',
    'International Master'
);

SELECT enum_range(null::chess_title);

ALTER TYPE chess_title
ADD VALUE 'Grand Master' AFTER 'International Master'; 

CREATE TABLE IF NOT EXISTS chess_player
(
    player_id serial PRIMARY KEY,
    first_name text,
    last_name text,
    title chess_title
);

INSERT INTO chess_player (first_name, last_name, title)
VALUES
('Wesly', 'So', 'Grand Master'),
('Vlad', 'Kramnik', 'Grand Master'),
('Vasily', 'Pupkin', 'Candidate Master');

SELECT * FROM chess_player;


DROP TABLE IF EXISTS chess_player;

