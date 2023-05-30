DROP TABLE IF EXISTS chair;

CREATE TABLE chair 
(
    chair_id serial PRIMARY KEY,
    chair_name varchar,
    dean varchar
);

INSERT INTO chair
VALUES
(1, 'name', 'dean');

 SELECT *
 FROM chair;


DROP TABLE IF EXISTS chair;

-- PRIMARY KEY может быть только один на одну таблицу

CREATE TABLE chair 
(
    chair_id serial UNIQUE NOT NULL,
    chair_name varchar,
    dean varchar
);

SELECT constraint_name
FROM information_schema.key_column_usage
WHERE table_name = 'chair';
