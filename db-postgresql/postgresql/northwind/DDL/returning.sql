DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id serial,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    rating real,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

INSERT INTO book (title, isbn, rating)
VALUES
('title 1', 'isbn 1', 4.6)
RETURNING *;


UPDATE book 
SET rating = 4.7
WHERE title = 'title 1'
RETURNING *;
