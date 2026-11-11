-- =====================================================================
--  COMPLETE FILE: sample data + all questions (C2 - C14) with queries
--  SQL Section C - Research Project : College Library Management
--  Name    : CHETHAN M P
--  Class   : BCA 3rd Semester, Section C
--  Run this single file in MySQL 8.0+ (Workbench: File > Open SQL Script > Run)
--  Part 1: create database + sample data   Part 2: queries, procedure, trigger
-- =====================================================================

-- ############### PART 1 : DATABASE AND SAMPLE DATA ###############
DROP DATABASE IF EXISTS librarydb;
CREATE DATABASE librarydb;
USE librarydb;

CREATE TABLE members (
  member_id   INT PRIMARY KEY,
  member_name VARCHAR(50) NOT NULL,
  member_type VARCHAR(10) NOT NULL CHECK (member_type IN ('Student','Faculty')),
  joined_date DATE
);

CREATE TABLE books (
  book_id          INT PRIMARY KEY,
  title            VARCHAR(100) NOT NULL,
  author           VARCHAR(60),
  category         VARCHAR(30),
  price            DECIMAL(8,2),
  copies_available INT
);

CREATE TABLE issues (
  issue_id    INT PRIMARY KEY,
  member_id   INT NOT NULL,
  book_id     INT NOT NULL,
  issue_date  DATE,
  due_date    DATE,
  return_date DATE NULL,
  FOREIGN KEY (member_id) REFERENCES members(member_id),
  FOREIGN KEY (book_id)   REFERENCES books(book_id)
);

INSERT INTO members VALUES
  (1, 'Aarav Sharma', 'Student', '2024-07-01'),
  (2, 'Priya Nair', 'Student', '2024-07-03'),
  (3, 'Rohan Mehta', 'Student', '2024-08-10'),
  (4, 'Dr. Anita Rao', 'Faculty', '2020-06-15'),
  (5, 'Prof. Suresh Kumar', 'Faculty', '2019-01-20'),
  (6, 'Sneha Reddy', 'Student', '2025-01-12'),
  (7, 'Imran Khan', 'Student', '2025-02-05'),
  (8, 'Kavya Iyer', 'Student', '2025-07-18'),
  (9, 'Dr. Mohan Das', 'Faculty', '2021-09-01'),
  (10, 'Neha Gupta', 'Student', '2025-08-22'),
  (11, 'Vikram Singh', 'Student', '2025-09-09'),
  (12, 'Pooja Patel', 'Student', '2025-09-15');

INSERT INTO books VALUES
  (1, 'Database System Concepts', 'Silberschatz', 'Computer Science', 650, 3),
  (2, 'Let Us C', 'Yashavant Kanetkar', 'Computer Science', 350, 0),
  (3, 'Python Crash Course', 'Eric Matthes', 'Computer Science', 500, 2),
  (4, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 250, 4),
  (5, 'The Discovery of India', 'Jawaharlal Nehru', 'History', 400, 2),
  (6, 'Concept of Physics', 'H.C. Verma', 'Science', 450, 0),
  (7, 'Engineering Mathematics', 'B.S. Grewal', 'Mathematics', 600, 5),
  (8, 'Malgudi Days', 'R.K. Narayan', 'Fiction', 200, 3),
  (9, 'The Guide', 'R.K. Narayan', 'Fiction', 220, 1),
  (10, 'Operating System Concepts', 'Galvin', 'Computer Science', 700, 2),
  (11, 'Indian Polity', 'M. Laxmikanth', 'Civics', 550, 2),
  (12, 'Organic Chemistry', 'Morrison and Boyd', 'Science', 800, 1);

INSERT INTO issues VALUES
  (1, 1, 1, '2026-08-01', '2026-08-15', '2026-08-14'),
  (2, 1, 2, '2026-08-20', '2026-09-03', '2026-09-10'),
  (3, 2, 2, '2026-08-05', '2026-08-19', '2026-08-25'),
  (4, 2, 3, '2026-09-01', '2026-09-15', '2026-09-14'),
  (5, 3, 1, '2026-09-05', '2026-09-19', '2026-09-30'),
  (6, 3, 3, '2026-09-10', '2026-09-24', '2026-09-22'),
  (7, 4, 1, '2026-08-10', '2026-08-24', '2026-08-23'),
  (8, 4, 10, '2026-09-15', '2026-09-29', '2026-10-02'),
  (9, 5, 5, '2026-08-12', '2026-08-26', '2026-08-26'),
  (10, 5, 11, '2026-09-20', '2026-10-04', NULL),
  (11, 6, 4, '2026-09-02', '2026-09-16', '2026-09-18'),
  (12, 6, 2, '2026-10-01', '2026-10-15', NULL),
  (13, 7, 6, '2026-10-05', '2026-10-19', NULL),
  (14, 7, 3, '2026-08-25', '2026-09-08', '2026-09-20'),
  (15, 8, 8, '2026-09-12', '2026-09-26', '2026-09-25'),
  (16, 8, 9, '2026-10-02', '2026-10-16', '2026-10-14'),
  (17, 9, 7, '2026-08-18', '2026-09-01', '2026-09-01'),
  (18, 9, 12, '2026-10-10', '2026-10-24', NULL),
  (19, 10, 1, '2026-10-12', '2026-10-26', NULL),
  (20, 10, 4, '2026-09-25', '2026-10-09', '2026-10-12'),
  (21, 1, 3, '2026-10-08', '2026-10-22', '2026-10-20'),
  (22, 2, 1, '2026-10-14', '2026-10-28', NULL),
  (23, 3, 2, '2026-09-28', '2026-10-12', '2026-10-20'),
  (24, 4, 3, '2026-10-03', '2026-10-17', '2026-10-16'),
  (25, 6, 1, '2026-10-20', '2026-11-03', '2026-11-02');

-- ############### PART 2 : QUESTIONS AND QUERIES ###############

USE librarydb;

-- ---------------------------------------------------------------------
-- Look at every table first
-- ---------------------------------------------------------------------
SELECT * FROM members LIMIT 10;
SELECT * FROM books   LIMIT 10;
SELECT * FROM issues  LIMIT 10;

-- =====================================================================
-- PHASE 1 : KNOW YOUR DATA
-- =====================================================================

-- C1 : ERD -> see ERD.png / ERD.svg
--   members (1) ----< (N) issues (N) >---- (1) books
--   issues.member_id -> members.member_id (FK)
--   issues.book_id   -> books.book_id     (FK)

-- C2 : Count of members, books and issue records
SELECT
    (SELECT COUNT(*) FROM members) AS total_members,
    (SELECT COUNT(*) FROM books)   AS total_books,
    (SELECT COUNT(*) FROM issues)  AS total_issue_records;
-- Expected output on sample data:
--   total_members | total_books | total_issue_records
--   12 | 12 | 25

-- =====================================================================
-- PHASE 2 : BUSINESS QUESTIONS
-- =====================================================================

-- C3 : Titles and total copies in each category
SELECT category,
       COUNT(*)              AS total_titles,
       SUM(copies_available) AS total_copies
FROM books
GROUP BY category
ORDER BY total_titles DESC;
-- Expected output on sample data:
--   category | total_titles | total_copies
--   Computer Science | 4 | 7
--   Science | 2 | 1
--   Fiction | 2 | 4
--   Mathematics | 1 | 5
--   History | 1 | 2
--   Civics | 1 | 2
--   Biography | 1 | 4

-- C4 : Top 5 most borrowed books
SELECT b.book_id, b.title, COUNT(i.issue_id) AS times_borrowed
FROM books b
JOIN issues i ON i.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC
LIMIT 5;
-- Expected output on sample data:
--   book_id | title | times_borrowed
--   1 | Database System Concepts | 6
--   3 | Python Crash Course | 5
--   2 | Let Us C | 4
--   4 | Wings of Fire | 2
--   5 | The Discovery of India | 1

-- C5 : Members who have never borrowed a book (LEFT JOIN ... IS NULL)
SELECT m.member_id, m.member_name, m.member_type
FROM members m
LEFT JOIN issues i ON i.member_id = m.member_id
WHERE i.issue_id IS NULL;
-- Expected output on sample data:
--   member_id | member_name | member_type
--   11 | Vikram Singh | Student
--   12 | Pooja Patel | Student

-- C6 : Books currently issued (not returned): member, title, due date
SELECT m.member_name, b.title, i.due_date
FROM issues i
JOIN members m ON m.member_id = i.member_id
JOIN books   b ON b.book_id   = i.book_id
WHERE i.return_date IS NULL
ORDER BY i.due_date;
-- Expected output on sample data:
--   member_name | title | due_date
--   Prof. Suresh Kumar | Indian Polity | 2026-10-04
--   Sneha Reddy | Let Us C | 2026-10-15
--   Imran Khan | Concept of Physics | 2026-10-19
--   Dr. Mohan Das | Organic Chemistry | 2026-10-24
--   Neha Gupta | Database System Concepts | 2026-10-26
--   Priya Nair | Database System Concepts | 2026-10-28

-- C7 : Books returned late, days late and fine (Rs. 2 per day)
SELECT i.issue_id, m.member_name, b.title,
       i.due_date, i.return_date,
       DATEDIFF(i.return_date, i.due_date)     AS days_late,
       DATEDIFF(i.return_date, i.due_date) * 2 AS fine_rs
FROM issues i
JOIN members m ON m.member_id = i.member_id
JOIN books   b ON b.book_id   = i.book_id
WHERE i.return_date IS NOT NULL
  AND i.return_date > i.due_date
ORDER BY fine_rs DESC;
-- Expected output on sample data:
--   issue_id | member_name | title | due_date | return_date | days_late | fine_rs
--   14 | Imran Khan | Python Crash Course | 2026-09-08 | 2026-09-20 | 12 | 24
--   5 | Rohan Mehta | Database System Concepts | 2026-09-19 | 2026-09-30 | 11 | 22
--   23 | Rohan Mehta | Let Us C | 2026-10-12 | 2026-10-20 | 8 | 16
--   2 | Aarav Sharma | Let Us C | 2026-09-03 | 2026-09-10 | 7 | 14
--   3 | Priya Nair | Let Us C | 2026-08-19 | 2026-08-25 | 6 | 12
--   8 | Dr. Anita Rao | Operating System Concepts | 2026-09-29 | 2026-10-02 | 3 | 6
--   20 | Neha Gupta | Wings of Fire | 2026-10-09 | 2026-10-12 | 3 | 6
--   11 | Sneha Reddy | Wings of Fire | 2026-09-16 | 2026-09-18 | 2 | 4

-- C8 : Total fine per member (only members with a fine)
SELECT m.member_id, m.member_name,
       SUM(DATEDIFF(i.return_date, i.due_date) * 2) AS total_fine_rs
FROM issues i
JOIN members m ON m.member_id = i.member_id
WHERE i.return_date > i.due_date
GROUP BY m.member_id, m.member_name
HAVING total_fine_rs > 0
ORDER BY total_fine_rs DESC;
-- Expected output on sample data:
--   member_id | member_name | total_fine_rs
--   3 | Rohan Mehta | 38
--   7 | Imran Khan | 24
--   1 | Aarav Sharma | 14
--   2 | Priya Nair | 12
--   4 | Dr. Anita Rao | 6
--   10 | Neha Gupta | 6
--   6 | Sneha Reddy | 4

-- C9 : Student vs Faculty usage
SELECT m.member_type, COUNT(i.issue_id) AS books_borrowed
FROM members m
JOIN issues i ON i.member_id = m.member_id
GROUP BY m.member_type;
-- Expected output on sample data:
--   member_type | books_borrowed
--   Faculty | 7
--   Student | 18

-- C10 : Rank members by number of books borrowed (RANK window function)
SELECT m.member_id, m.member_name,
       COUNT(i.issue_id) AS books_borrowed,
       RANK() OVER (ORDER BY COUNT(i.issue_id) DESC) AS borrow_rank
FROM members m
LEFT JOIN issues i ON i.member_id = m.member_id
GROUP BY m.member_id, m.member_name
ORDER BY borrow_rank, m.member_name;
-- Expected output on sample data:
--   member_id | member_name | books_borrowed | borrow_rank
--   1 | Aarav Sharma | 3 | 1
--   4 | Dr. Anita Rao | 3 | 1
--   2 | Priya Nair | 3 | 1
--   3 | Rohan Mehta | 3 | 1
--   6 | Sneha Reddy | 3 | 1
--   9 | Dr. Mohan Das | 2 | 6
--   7 | Imran Khan | 2 | 6
--   8 | Kavya Iyer | 2 | 6
--   10 | Neha Gupta | 2 | 6
--   5 | Prof. Suresh Kumar | 2 | 6
--   12 | Pooja Patel | 0 | 11
--   11 | Vikram Singh | 0 | 11

-- C11 : Most popular category (issues per category)
SELECT b.category, COUNT(i.issue_id) AS total_issues
FROM issues i
JOIN books b ON b.book_id = i.book_id
GROUP BY b.category
ORDER BY total_issues DESC;
-- Expected output on sample data:
--   category | total_issues
--   Computer Science | 16
--   Science | 2
--   Fiction | 2
--   Biography | 2
--   Mathematics | 1
--   History | 1
--   Civics | 1

-- C12 : Books with zero copies available AND pending issues (subquery)
SELECT b.book_id, b.title, b.copies_available
FROM books b
WHERE b.copies_available = 0
  AND b.book_id IN (SELECT i.book_id
                    FROM issues i
                    WHERE i.return_date IS NULL);
-- Expected output on sample data:
--   book_id | title | copies_available
--   2 | Let Us C | 0
--   6 | Concept of Physics | 0

-- =====================================================================
-- PHASE 3 : AUTOMATE  (work on COPIES so original data stays safe)
-- =====================================================================

-- C13 : Stored procedure - all books borrowed by one member
DROP PROCEDURE IF EXISTS member_history;
DELIMITER //
CREATE PROCEDURE member_history(IN p_member_id INT)
BEGIN
    SELECT m.member_name, b.title, b.author,
           i.issue_date, i.due_date, i.return_date
    FROM issues i
    JOIN members m ON m.member_id = i.member_id
    JOIN books   b ON b.book_id   = i.book_id
    WHERE i.member_id = p_member_id
    ORDER BY i.issue_date;
END //
DELIMITER ;

-- Test call (change 1 to any valid member_id)
CALL member_history(1);
-- Expected: 3 rows for Aarav Sharma (Database System Concepts, Let Us C, Python Crash Course)

-- C14 : Trigger on copies of the tables
DROP TABLE IF EXISTS issues_copy;
DROP TABLE IF EXISTS books_copy;
CREATE TABLE books_copy  AS SELECT * FROM books;
CREATE TABLE issues_copy AS SELECT * FROM issues;

DROP TRIGGER IF EXISTS trg_reduce_copies;
DELIMITER //
CREATE TRIGGER trg_reduce_copies
AFTER INSERT ON issues_copy
FOR EACH ROW
BEGIN
    UPDATE books_copy
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;

-- Test: BEFORE
SELECT book_id, title, copies_available FROM books_copy WHERE book_id = 1;

-- Insert a new issue (issue_id 9001 chosen to avoid clashes; use valid member/book ids)
INSERT INTO issues_copy (issue_id, member_id, book_id, issue_date, due_date, return_date)
VALUES (9001, 1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), NULL);

-- Test: AFTER  -> copies_available must be 1 less than BEFORE
-- Expected: BEFORE = 3, AFTER = 2
SELECT book_id, title, copies_available FROM books_copy WHERE book_id = 1;

-- =====================================================================
-- PHASE 4 : CONCLUSION (C15) -> see README.txt
-- Supporting queries: C4 (popular), C6 (pending), C7/C8 (late & fines),
-- C12 (out of stock + pending)
-- =====================================================================
