CREATE SCHEMA IF NOT EXISTS exercise68;

CREATE TABLE IF NOT EXISTS Book(
	book_id INT PRIMARY KEY,
    title VARCHAR(30),
    publisher_name VARCHAR(30) REFERENCES Publisher(pname) ON DELETE SET NULL ON UPDATE CASCADE
    -- could also ON DELETE CASCADE to delete Book entries without a Publisher
);

CREATE TABLE IF NOT EXISTS Book_authors(
	book_id INT REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    -- if a Book is deleted, the corresponding Book_authors are deleted. 
    author_name VARCHAR(30),
    PRIMARY KEY (book_id, author_name)
);

CREATE TABLE IF NOT EXISTS Publisher(
	pname VARCHAR(30) PRIMARY KEY,
    address VARCHAR(30),
    phone VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Book_copies(
	book_id INT REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    -- if a Book is deleted or updated propagate to corresponding Book_copies
    branch_id INT REFERENCES Library_branch(branch_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    no_of_copies INT
);

CREATE TABLE IF NOT EXISTS Book_loans(
	book_id INT REFERENCES Book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    -- delete loans for deleted books and update
    branch_id INT REFERENCES Library_branch(branch_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- do not allow library_branch to be deleted if there is loans
    card_no INT REFERENCES Borrower(card_no) ON DELETE RESTRICT ON UPDATE CASCADE,
    -- do not allow a borrower to be deleted if there is loans
    date_out DATE,
    due_date DATE
);

CREATE TABLE IF NOT EXISTS Library_branch(
	branch_id INT PRIMARY KEY,
    branch_name VARCHAR(30),
    address VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Borrower(
	card_no INT PRIMARY KEY,
    bname VARCHAR(30),
    address VARCHAR(30),
    phone VARCHAR(30)
);