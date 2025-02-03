-- QUERYING DATA
-- CREATING DATABASE
CREATE DATABASE LIBRARY;
USE LIBRARY ;

-- CREATING TABLE 1
CREATE TABLE Branch(
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address CHAR(25),
Contact_no INT
);


-- INSERTING DATA TO TABLE 1
INSERT INTO Branch(Branch_no,Manager_Id,Branch_address,Contact_no)
VALUE
(1,963,'EVMK','949596998');
INSERT INTO Branch(Branch_no,Manager_Id,Branch_address,Contact_no)
VALUES
(2,964,'TVK','93952298'),
(3,965,'KCH','99789298'),
(4,966,'TVM','94959114'),
(5,967,'WYD','97912598'),
(6,968,'OKX','97869298');
SELECT *FROM  Branch;

-- CREATING TABLE 2
CREATE TABLE Employee(
  Emp_Id INT PRIMARY KEY,
  Emp_name CHAR(20),
  Position CHAR(20),
  Salary DECIMAL(10,2),
  Branch_num INT,
FOREIGN KEY (Branch_num) REFERENCES Branch(Branch_no) 
);

INSERT INTO Employee(Emp_Id ,Emp_name,Position, Salary, Branch_num)
VALUE
(111,'LAIJI','HR','85000',1);
INSERT INTO Employee(Emp_Id ,Emp_name,Position, Salary, Branch_num)
VALUES
(222,'LIJI','CFO','95000',2),
(333,'LEENA','CMO','80000',3),
(444,'LINDA','CEO','88000',2),
(555,'LISHA','CMO','89000',2),
(666,'LALY','CEO','99000',6);
SELECT *FROM Employee ;

-- CREATING TABLE 3
CREATE TABLE Books(
 ISBN INT PRIMARY KEY ,
 Book_title VARCHAR(20),
 Category VARCHAR(10),
 Rental_Price INT,
 Status ENUM('YES','NO'),
 Author VARCHAR(20),
 Publisher VARCHAR(20)
);

INSERT INTO Books(ISBN,Book_title,Category,Rental_Price,Author,Publisher)
VALUE
(1122,'GO','POEM','120','R K ROY','ROZARIO');
INSERT INTO Books(ISBN,Book_title,Category,Rental_Price,Author,Publisher)
VALUES
(2233,'ITS_GOOD','STORY','550','ERNEST PHILIP','AMY ABRAHAM'),
(3344,'HAPPY','ARTICLE','290','KASILI HUZAIN','CRISTY DZUSA'),
(4455,'MINE','STORY','130','ABUL KALAS','TITANIA RAO'),
(5566,'FAMILY','POEM','100','BASIL J','TOM CJ'),
(6677,'LOVE','ARTICLE','800','JALIA RAM','NORAJ');
SELECT *FROM BOOKS;
 
 
-- CREATING TABLE 4
CREATE TABLE Customer(
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(20),
Customer_address VARCHAR(20),
Reg_date DATE
);

INSERT INTO Customer(Customer_id,Customer_name ,Customer_address ,Reg_date)
VALUE
(335678,'VARUN','EKM','2023-10-14');
INSERT INTO Customer(Customer_id,Customer_name ,Customer_address ,Reg_date)
VALUES
(335679,'RANI','TVM','1999-10-14'),
(335680,'ARUN','TRS','2000-11-10'),
(335681,'RUPA','KOH','1990-08-12'),
(335682,'AISHU','IJK','1992-01-04'),
(335683,'SHARON','CHK','1994-03-31');
SELECT *FROM Customer;


-- CREATING TABLE 5
CREATE TABLE IssueStatus( 
Issue_Id INT PRIMARY KEY ,
Issued_cust VARCHAR(20),
Issued_book_name VARCHAR(20) NULL,
Issue_date DATE NULL,
Isbn_book int NULL,
FOREIGN KEY (Isbn_book) REFERENCES  Books(ISBN) 
);

INSERT INTO IssueStatus( Issue_Id ,Issued_cust, Issued_book_name ,Issue_date ,Isbn_book)
VALUE
(123,'JIO','GO','2023-06-12',1122);
INSERT INTO IssueStatus( Issue_Id ,Issued_cust, Issued_book_name ,Issue_date ,Isbn_book)
VALUES
(124,'ZIOU','ITS_GOOD','2022-10-14',2233),
(125,'RIO',NULL,NULL,NULL),
(126,'TINO','MINE','2003-04-11',4455),
(127,'UIO','FAMILY','1999-11-04',5566),
(128,'MIA','LOVE','1998-03-31',6677);
SELECT *FROM IssueStatus;

-- CREATING TABLE 6
CREATE TABLE ReturnStatus( 
Return_Id INT PRIMARY KEY ,
Return_cust INT,
Return_book_name VARCHAR(20),
Return_date DATE,
Isbn_book2 int,
FOREIGN KEY (Isbn_book2) REFERENCES  Books(ISBN) 
);

INSERT INTO ReturnStatus(Return_Id,Return_cust ,Return_book_name ,Return_date ,Isbn_book2 )
VALUE
(900,5678,'GOOSE','2000-10-11',1122);
INSERT INTO ReturnStatus(Return_Id,Return_cust ,Return_book_name ,Return_date ,Isbn_book2 )
VALUES
(901,5679,'ROYAL','2020-12-24',2233),
(902,5680,'ALHAMDULLILA','2023-04-24',3344),
(903,5681,'RUPAS_HOUSE','2003-04-01',4455),
(904,5682,'AI_IMPS','2000-10-04',5566),
(905,5683,'SHARK','2021-03-31',6677);
SELECT *FROM ReturnStatus;


# To retrieve the book title, category, and rental price of all available books.
select Book_title,Category,Rental_Price from Books;

# List the employee names and their respective salaries in descending order of salary.
select Emp_name,Salary from Employee
order by Salary desc;

# Retrieve the book titles and the corresponding customers who have issued those books. 
select Books.Book_title , IssueStatus.Issued_cust from Books
inner join IssueStatus on Books.ISBN=IssueStatus.Isbn_book;


# Display the total count of books in each category. 
select Category,count(*) as total_count_of_books from Books
group by Category;


#  Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select Emp_name,Position from Employee
where Salary>50000;

# List the customer names who registered before 2022-01-01 and have not issued any books yet
select Customer_name,Reg_date from Customer
left join IssueStatus on Issued_book_name
where Reg_date <'2022-01-01'
and Issued_book_name IS NULL;


# Display the branch numbers and the total count of employees in each branch. 
select Branch_no from Branch;
select Branch_num,count(*) as total_count_of_employee from Employee
group by Branch_num;


# Display the names of customers who have issued books in the month of June 2023.
select Issued_cust from IssueStatus
where Issue_date >='2023-06-01' and Issue_date <='2023-06-30';


# Retrieve book_title from book table containing Family.
select book_title from Books
where book_title='Family';


# Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
select Branch_num,count(Emp_name) as employee_count from Employee
group by Branch_num
having count(Emp_name)>1;


# Retrieve the names of employees who manage branches and their respective branch address 
select emp_name,branch_address from employee
right join  branch on employee.emp_name=branch.branch_no
where branch.Manager_Id =966;


#  Display the names of customers who have issued books with a rental price higher than Rs.130
select Issued_cust from IssueStatus
join books on  books.book_title=IssueStatus.issued_book_name
where books.rental_price >130
