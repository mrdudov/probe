DROP TABLE IF EXISTS publisher;

CREATE TABLE publisher
(
    publisher_id int,
    publisher_name varchar(128) NOT NULL,
    address text

    CONSTRAINT PK_publisher_publisher_id  PRIMARY KEY(publisher_id)
);

CREATE TABLE book
(
    book_id int,
    title text NOT NULL,
    isbn varchar(32) NOT NULL,
    publisher_id int,

    CONSTRAINT PK_book_book_id PRIMARY KEY(book_id),
    CONSTRAINT FK_book_publisher FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

ALTER TABLE book
DROP CONSTRAINT FK_book_publisher;

ALTER TABLE book
ADD CONSTRAINT FK_book_publisher FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id);

