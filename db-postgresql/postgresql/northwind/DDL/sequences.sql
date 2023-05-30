CREATE SEQUENCE seq1;

SELECT nextval('seq1');

SELECT currval('seq1');

SELECT lastval();

SELECT setval('seq1', 16, true);
SELECT currval('seq1');
SELECT nextval('seq1');

SELECT setval('seq1', 16, false);
-- при false currval не модифицируется
SELECT currval('seq1');
SELECT nextval('seq1');


CREATE SEQUENCE IF NOT EXISTS seq2 INCREMENT 16;
SELECT nextval('seq2');

CREATE SEQUENCE IF NOT EXISTS seq3 
INCREMENT 16
MINVALUE 0
MAXVALUE 128
START WITH 0;

SELECT nextval('seq3');

ALTER SEQUENCE seq3 RENAME TO seq4;

ALTER SEQUENCE seq4 RESTART WITH 16;

DROP SEQUENCE seq4;


DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id int NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)

);

SELECT *
FROM book;

CREATE SEQUENCE IF NOT EXISTS book_book_seq
START WITH 1 OWNED BY book.book_id;

ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_seq');

INSERT INTO book (title, isbn, publisher_id)
VALUES 
('title', 'isbn', 1);


CREATE TABLE book
(
    book_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int NOT NULL,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

