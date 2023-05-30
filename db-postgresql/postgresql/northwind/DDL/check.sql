DROP TABLE IF EXISTS book;

CREATE TABLE book
(
    book_id int,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id),
);

ALTER TABLE book
ADD COLUMN price decimal CONSTRAINT chk_book_price CHECK (price >= 0);