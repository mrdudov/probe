DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id serial,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    rating real,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

INSERT INTO book (book_id, title, isbn)
VALUES
(3, 'title 1', 'isbn 1'),
(4, 'title 2', 'isbn 2'),
(5, 'title 3', 'isbn 3'),
(6, 'title 4', 'isbn 4'),
(7, 'title 5', 'isbn 5'),
(8, 'title 6', 'isbn 6');

DELETE FROM book
WHERE book_id = 7;

SELECT *
FROM book;

-- delete all
DELETE FROM book;


-- delete all without logging
TRUNCATE TABLE book;
