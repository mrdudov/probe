CREATE DATABASE testdb;

CREATE TABLE publisher
(
    publisher_id integer PRIMARY KEY,
    org_name varchar(128) NOT NULL,
    address text NOT NULL
);

CREATE TABLE book
(
    book id integer PRIMARY KEY,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    fk_publisher_id integer REFERENCES publisher(publisher_id) NOT NULL 
);


ALTER TABLE book
ADD COLUMN fk_publisher_id;

ALTER TABLE book
ADD CONSTRAINT fk_book_publisher 
FOREIGN KEY(fk_publisher_id) REFERENCES publisher(publisher_id);

 
INSERT INTO book
VALUES
(1, 'The Diary of a Young Girl', '0199535566', 1),
(2, 'Pride and Prejudice', '9780307594006', 1),
(3, 'To Kill a Mockingbird', '0446310786', 2),
(4, 'The Book of Gutsy Women: Favorite Stories of Courage and Resilience', '1501178415', 2),
(5, 'War and Peace', '1788886526', 2);


INSERT INTO publisher
VALUES
(1, 'Everyman''s Library', 'NY'),
(1, 'Oxford University Press', 'NY'),
(1, 'Grand Central Publisher', 'Washington'),
(1, 'Simon & Schuster', 'Chicago');


DROP TABLE publisher;

DROP TABLE book;


CREATE TABLE person
(
    person_id int PRIMARY KEY,
    first_name varchar(64) NOT NULL,
     last_name varchar(64) NOT NULL
);

CREATE TABLE passport
(
    passport_id int PRIMARY KEY,
    serial_numper int NOT NULL,
    registgation text NOT NULL,
    fk_passport_person int REFERENCES person(person_id)
);


INSERT INTO person VALUES (1, 'John', 'Snow');
INSERT INTO person VALUES (2, 'Ned', 'Stark');
INSERT INTO person VALUES (3, 'Rob', 'Baratheon');


INSERT INTO passport VALUES (1, 123456, 'Winterfell', 1);
INSERT INTO passport VALUES (2, 789012, 'Winterfell', 2);
INSERT INTO passport VALUES (3, 345678, 'King''s Landing', 3);


DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS book_author;

CREATE TABLE book
(
    book_id int PRIMARY KEY,
    title text NOT NULL,
    isbn text NOT NULL
);

CREATE TABLE author
(
    author_id int PRIMARY KEY,
    full_name text NOT NULL,
    rating real
);

CREATE TABLE book_author
(
    book_id int REFERENCES book(book_id),
    author_id int REFERENCES author(author_id)

    CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id) -- composite key
);

INSERT INTO book
VALUES
(1, 'The Diary of a Young Girl', '0199535566'),
(2, 'Pride and Prejudice', '9780307594006'),
(3, 'To Kill a Mockingbird', '0446310786'),
(4, 'The Book of Gutsy Women: Favorite Stories of Courage and Resilience', '1501178415'),
(5, 'War and Peace', '1788886526');

INSERT INTO author
VALUES
(1, 'Bob', 4.5),
(2, 'Alice', 4.0),
(3, 'John', 4.7);

INSERT INTO book_author
VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(4, 3);
