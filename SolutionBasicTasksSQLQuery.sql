-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books values('978-1-60129-456-2','To Kill a Mockingbird','Classic',6.00,'yes','Harper Lee', 'J.B. Lippincott & Co.')

select * from books

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103'
select * from members

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121'

SELECT * FROM issued_status
WHERE issued_id = 'IS121'


-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT b.*,e.emp_name FROM books b
JOIN issued_status i ON b.isbn=i.issued_book_isbn
JOIN employees e on i.issued_emp_id=e.emp_id
WHERE e.emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.


SELECT 
    ist.issued_emp_id,
     e.emp_name, COUNT(*)numbers_book
FROM issued_status  ist
JOIN employees  e
ON e.emp_id = ist.issued_emp_id
GROUP BY ist.issued_emp_id, e.emp_name
HAVING COUNT(*) > 1

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**


SELECT 
    b.isbn,
    b.book_title,
    COUNT(ist.issued_id) AS number_issued
INTO book_cnts
FROM books AS b
JOIN issued_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title

select * from book_cnts

-- Task 7: Find Total Rental Income by Category:


SELECT
    b.category,
    SUM(b.rental_price)totalrentalprice,
    COUNT(*)numberofthem
FROM books as b
JOIN
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.category


-- List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE DATEDIFF(DAY,reg_date,GETDATE())  <= 180

-- task 9 List Employees with Their Branch Manager's Name and their branch details:

SELECT e.emp_id,e.emp_name,e.position,e.salary,
b.branch_id,b.manager_id,b.branch_address,b.contact_no
FROM employees e
JOIN branch b on b.branch_id=e.branch_id

-- Task 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
SELECT 
    *
INTO books_price_than_7
FROM books AS b
where b.rental_price>7

select * from books_price_than_7

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT 
DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL

    


