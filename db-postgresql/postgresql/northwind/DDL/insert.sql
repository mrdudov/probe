DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id serial,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    rating real,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);


INSERT INTO book
VALUES
(1, 'title1', 'isbn1', 4.5);

SELECT *
FROM book;



INSERT INTO book (book_id, title, isbn)
VALUES
(2, 'title2', 'isbn2');

SELECT *
FROM book;


INSERT INTO book (book_id, title, isbn)
VALUES
(3, 'title d g', 'isbn2'),
(4, 'title gergerg', 'is5gbn2'),
(5, 'title ergerg', 'isg54bn2'),
(6, 'titleg4r3t4', 'isbn25g5'),
(7, 'title54tg54t', 'isbn25g45'),
(8, 'titleg45', 'isb5g5n2');

SELECT *
FROM book;


SELECT *
INTO book_backup
FROM book;

SELECT * 
FROM book_backup;


SELECT INTO book_backup
SELECT *
FROM book;
