CREATE DATABASE LIBRARY_DEPI_EXAM
USE LIBRARY_DEPI_EXAM
---------------------------------------------------------- CREATE TABLES

CREATE TABLE EMPLOYEE     --Create the first table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
EMP_ID INT PRIMARY KEY IDENTITY,
F_NAME NVARCHAR(20) NOT NULL,
L_NAME NVARCHAR(20) NOT NULL,
PHONE INT,
EMAIL NVARCHAR(50),
BONUS MONEY ,
SALARY MONEY,
[ADDRESS] NVARCHAR(50),
DATE_OF_BIRTH DATE,
SUPER_ID INT REFERENCES EMPLOYEE(EMP_ID),
)
----------------------------------------------------
CREATE TABLE [FLOOR]   -- Create the second table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
FLOOR_NUMBER INT PRIMARY KEY IDENTITY,
NUMBER_BLOCKS INT ,
HIRING_DATE DATE,
EMP_ID INT REFERENCES EMPLOYEE(EMP_ID)
)
----------------------------------------------------------
ALTER TABLE EMPLOYEE ADD F_NUMBER INT REFERENCES [FLOOR](FLOOR_NUMBER)    -- Added a new FK column to EMPLOYEE table after creating FLOOR table to reference its PK
-------------------------------------------------------------------
CREATE TABLE [USER]  -- Create the third table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
SSN INT PRIMARY KEY IDENTITY,
EMAIL NVARCHAR(50),
[NAME] NVARCHAR(50),
EMP_ID INT REFERENCES EMPLOYEE(EMP_ID)
)
------------------------------------------------------
CREATE TABLE USER_PHONES   -- Create the fourth table because it was originally a multi valued attribute, and set a composite PK for it
(
SSN INT REFERENCES [USER](SSN),
PHONES INT ,
PRIMARY KEY (SSN,PHONES) 
)
----------------------------------------------------------
CREATE TABLE SHELF   -- Create the fifth table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
CODE INT PRIMARY KEY IDENTITY,
F_NUMBER INT REFERENCES [FLOOR](FLOOR_NUMBER)
)
----------------------------------------------------------
CREATE TABLE CATIGORY   -- Create the sixth table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
CAT_ID INT PRIMARY KEY IDENTITY,
CAT_NAME NVARCHAR(20)
)
----------------------------------------------------------
CREATE TABLE BOOK  -- Create the seventh table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
BOOK_ID INT PRIMARY KEY IDENTITY,
TITLE NVARCHAR(50),
CAT_ID INT REFERENCES CATIGORY(CAT_ID),
CODE INT REFERENCES SHELF(CODE)
)
----------------------------------------------------------
CREATE TABLE PUBLISHER   -- Create the eighth table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
PUB_ID INT PRIMARY KEY IDENTITY,
[NAME] NVARCHAR(50)
)
----------------------------------------------------------
ALTER TABLE BOOK ADD PUB_ID INT REFERENCES PUBLISHER(PUB_ID)   -- Added PUB_ID column as a FK to BOOK table referencing PUBLISHER table's PK
----------------------------------------------------------
CREATE TABLE BORROWING  -- Create the ninth table from a ternary relationship, using a composite PK as the best solution
(
DUE_DATE DATE,
DATE_BORROW SMALLDATETIME,
AMOUNT_OF_MONEY_FOR_BORROW MONEY,
SSN INT REFERENCES [USER](SSN),
E_ID INT REFERENCES EMPLOYEE(EMP_ID),
BOOK_ID INT REFERENCES BOOK(BOOK_ID),
PRIMARY KEY(BOOK_ID,DATE_BORROW)
)
----------------------------------------------------------
CREATE TABLE AUTHOR  -- Create the tenth table with columns, set PK as IDENTITY (Auto Number), and added the FK
(
AUTHOR_ID INT PRIMARY KEY,
[NAME] NVARCHAR(50)
)
----------------------------------------------------------
CREATE TABLE BOOK_AUTHOR  -- Create the eleventh table from an M:N relationship with a composite PK
(
BOOK_ID INT REFERENCES BOOK(BOOK_ID),
AUTHOR_ID INT REFERENCES AUTHOR(AUTHOR_ID),
PRIMARY KEY (BOOK_ID,AUTHOR_ID)
)
---------------------------------------------------------- 
---------------------------------------------------------- INSERT DATA (DML)


INSERT INTO EMPLOYEE (F_NAME,L_NAME,PHONE,EMAIL,BONUS,SALARY,[ADDRESS],DATE_OF_BIRTH,SUPER_ID)
VALUES
('OMAR','AMR',111000001,'omar@gmail.com',500,15000,'CAIRO','1985-01-15',NULL),
('ALI','MOHAMED',111000002,'ali@gmail.com',300,12000,'ALEX','1990-05-10',1),
('SAM','KAMEL',111000003,'sam@gmail.com',250,11000,'GIZA','1993-09-09',1),
('MOHAMED','HASSAN',111000004,NULL,400,13000,'CAIRO','1988-03-15',2),
('SARA','FATHY',111000005,NULL,800,NULL,NULL,'1995-07-20',2),
('YOUSSEF','ADEL',111000006,'youssef@gmail.com',350,14000,'ALEX','1991-02-10',3),
('NOUR','SALEM',111000007,'nour@gmail.com',200,10500,'MINYA','1994-11-01',3),
('KARIM','FAROUK',111000008,NULL,600,16000,'CAIRO','1987-04-25',4),
('DINA','MAGDY',111000009,'dina@gmail.com',280,12500,'ASWAN','1996-08-14',4),
('TAREK','SABER',111000010,'tarek@gmail.com',NULL,9000,'LUXOR','1999-01-05',5),
('RANIA','GAMAL',111000011,NULL,700,17000,'CAIRO','1986-06-30',5),
('HASSAN','NABIL',111000012,'hassan@gmail.com',320,13500,'ALEX','1992-12-12',6),
('LAILA','AHMED',111000013,'laila@gmail.com',260,11500,'TANTA','1997-03-03',6),
('WAEL','IBRAHIM',111000014,'wael@gmail.com',NULL,14500,'CAIRO','1989-10-19',7),
('MAI','OSAMA',111000015,'mai@gmail.com',120,8000,'MINYA','1998-05-05',7)

INSERT INTO [FLOOR] (NUMBER_BLOCKS,HIRING_DATE,EMP_ID)
VALUES
(4,'2020-01-10',1),
(3,'2022-04-15',2),
(5,'2021-11-01',3),
(6,'2022-03-10',4),
(2,'2019-07-07',5),
(4,'2022-06-01',6),
(3,'2022-05-31',7)

UPDATE EMPLOYEE SET F_NUMBER = 1 WHERE EMP_ID IN (1,2,3)
UPDATE EMPLOYEE SET F_NUMBER = 2 WHERE EMP_ID IN (4,5)
UPDATE EMPLOYEE SET F_NUMBER = 3 WHERE EMP_ID IN (6,7)
UPDATE EMPLOYEE SET F_NUMBER = 4 WHERE EMP_ID IN (8,9)
UPDATE EMPLOYEE SET F_NUMBER = 5 WHERE EMP_ID IN (10,11)
UPDATE EMPLOYEE SET F_NUMBER = 6 WHERE EMP_ID IN (12,13)
UPDATE EMPLOYEE SET F_NUMBER = 7 WHERE EMP_ID IN (14,15)

INSERT INTO [USER] (EMAIL,[NAME],EMP_ID)
VALUES
('u1@gmail.com','AMIRA SALAH',1),
('u2@gmail.com','ENGY FEKRY',2),
('u3@gmail.com','MONA ADEL',1),
('u4@gmail.com','MONA ADEL',2),
('u5@gmail.com','KARIM SAID',3),
('u6@gmail.com','HEBA MAGDY',3),
('u7@gmail.com','YARA HANY',4),
('u8@gmail.com','OMAR TAREK',4),
('u9@gmail.com','NADA FAROUK',5),
('u10@gmail.com','SHERIF NABIL',5),
('u11@gmail.com','DALIA MOHSEN',6),
('u12@gmail.com','FADY RAAFAT',6),
('u13@gmail.com','REHAM SAYED',7),
('u14@gmail.com','AHMED FATHY',7),
('u15@gmail.com','MARWA SABER',8),
('u16@gmail.com','PETER SAMY',8),
('u17@gmail.com','GINA MELAD',9),
('u18@gmail.com','BASSEM ADEL',9),
('u19@gmail.com','NOHA KAMAL',10),
('u20@gmail.com','SEIF ELDIN',10)

INSERT INTO USER_PHONES (SSN,PHONES)
VALUES
(1,120000001),(1,120000021),
(2,120000002),(2,120000022),
(3,120000003),
(4,120000004),
(5,120000005),
(6,120000006),
(7,120000007),
(8,120000008),
(9,120000009),
(10,120000010),
(11,120000011),
(12,120000012),
(13,120000013),
(14,120000014),
(15,120000015),
(16,120000016),
(17,120000017),
(18,120000018),
(19,120000019),
(20,120000020)

INSERT INTO CATIGORY (CAT_NAME)
VALUES ('Programming'),('Fiction'),('History'),('Science'),('Business'),('Health'),('Fantasy')

INSERT INTO PUBLISHER ([NAME])
VALUES ('HarperCollins'),('Penguin'),('OReilly'),('Wiley'),('Pearson'),('Scholastic'),('Macmillan')

INSERT INTO SHELF (F_NUMBER)
VALUES (1),(1),(2),(2),(3),(3),(4),(4)

INSERT INTO BOOK (TITLE,CAT_ID,CODE)
VALUES
('Clean Code',1,1),
('Clean Architecture',1,2),
('Design Patterns',1,1),
('Harry Potter',2,3),
('Harry Potter 2',2,3),
('The Hobbit',2,4),
('Sapiens',3,5),
('1984',2,5),
('Brief History Of Time',4,6),
('A Short History',3,6),
('The Alchemist',2,7),
('Zero To One',5,7),
('Rich Dad Poor Dad',5,8),
('Atomic Habits',6,8),
('Why We Sleep',6,1),
('Fantasy Realms',7,2),
('Murder On Orient Express',2,3),
('Animal Farm',2,4),
('Effective Java',1,5),
('The Pragmatic Programmer',1,6)

UPDATE BOOK SET PUB_ID = 3 WHERE BOOK_ID IN (1,2,19,20)
UPDATE BOOK SET PUB_ID = 4 WHERE BOOK_ID IN (3,9,15)
UPDATE BOOK SET PUB_ID = 1 WHERE BOOK_ID IN (4,5,7,10)
UPDATE BOOK SET PUB_ID = 6 WHERE BOOK_ID IN (6,16)
UPDATE BOOK SET PUB_ID = 7 WHERE BOOK_ID IN (8,17,18)
UPDATE BOOK SET PUB_ID = 2 WHERE BOOK_ID IN (11,13)
UPDATE BOOK SET PUB_ID = 5 WHERE BOOK_ID IN (12,14)

INSERT INTO AUTHOR (AUTHOR_ID,[NAME])
VALUES
(1,'Robert Martin'),
(2,'J.K Rowling'),
(3,'Yuval Harari'),
(4,'Malak Adel'),
(5,'Ahmed Zaki'),
(6,'Sara Youssef'),
(7,'George Orwell'),
(8,'Agatha Christie'),
(9,'J.R Tolkien'),
(10,'Stephen Hawking')

INSERT INTO BOOK_AUTHOR (BOOK_ID,AUTHOR_ID)
VALUES
(1,1),(2,1),(3,1),(3,6),(4,2),(5,2),(6,9),(7,3),(8,7),(9,10),
(10,3),(11,4),(12,5),(13,5),(14,6),(15,10),(16,8),(17,8),(18,7),(19,1),(20,1)

INSERT INTO BORROWING (SSN,E_ID,BOOK_ID,DATE_BORROW,DUE_DATE,AMOUNT_OF_MONEY_FOR_BORROW)
VALUES
(1,3,11,'2022-11-01 09:00','2022-12-01',27),
(1,1,1,'2022-03-05 09:00','2022-04-01',50),
(1,2,2,'2022-04-10 10:00','2022-05-01',40),
(1,1,3,'2022-05-15 11:00','2022-06-01',35),
(1,3,4,'2022-06-20 09:30','2022-07-05',45),
(1,1,5,'2022-07-25 14:00','2022-08-10',30),
(2,2,6,'2022-02-01 08:00','2022-03-01',25),
(2,2,7,'2022-08-05 10:00','2022-09-01',20),
(2,4,8,'2022-09-10 09:00','2022-10-15',60),
(2,2,9,'2022-10-05 11:00','2022-11-01',55),
(3,3,10,'2022-04-01 09:00','2022-06-01',15),
(3,5,11,'2022-05-05 09:00','2022-07-01',65),
(4,4,12,'2022-06-15 10:00','2022-06-30',70),
(5,6,13,'2022-03-20 09:00','2022-06-20',80),
(5,6,14,'2022-09-01 09:00','2022-11-01',42),
(6,7,15,'2022-07-10 09:00','2022-08-01',33),
(7,7,16,'2022-08-15 09:00','2022-09-15',28),
(8,8,17,'2022-09-25 09:00','2022-10-25',90),
(9,9,18,'2022-03-01 00:00','2022-06-01',22),
(10,10,19,'2022-05-01 09:00','2022-06-15',38),
(11,11,20,'2022-10-01 00:00','2022-12-01',48),
(12,12,1,'2022-04-15 09:00','2022-06-01',52),
(13,13,2,'2022-06-01 09:00','2022-07-15',44),
(14,14,3,'2022-07-01 09:00','2022-08-15',36),
(15,15,4,'2022-08-01 09:00','2022-09-30',58),
(16,1,5,'2022-03-15 09:00','2022-05-01',62),
(17,2,6,'2022-09-15 09:00','2022-10-01',24),
(18,3,7,'2022-04-25 09:00','2022-06-25',34),
(19,4,8,'2022-05-20 09:00','2022-06-20',66),
(20,5,9,'2022-06-10 09:00','2022-07-10',29),
(2,1,10,'2022-07-05 09:00','2022-08-05',18)
----------------------------------------------------------
---------------------------------------------------------- DQL

--Q1
SELECT E.F_NAME + ' ' + E.L_NAME [FULL_NAME]   --I used LEN() to check the length of the first name and filtered for names longer than 3 letters
FROM EMPLOYEE E
WHERE LEN(E.F_NAME)>3

-------------------------------------------------------------------

--Q2
SELECT COUNT(B.BOOK_ID)[NO_OF_PROGRAMMING_BOOKS]     --I joined BOOK with CATIGORY to filter by category name, then used COUNT to get the total
FROM BOOK B INNER JOIN CATIGORY C
ON C.CAT_ID = B.CAT_ID
WHERE C.CAT_NAME = 'PROGRAMMING'

-------------------------------------------------------------------

--Q3
SELECT COUNT(B.BOOK_ID)[NO_OF_BOOKS]     --I joined BOOK with PUBLISHER to filter by publisher name, then used COUNT to get the total
FROM BOOK B INNER JOIN PUBLISHER P
ON P.PUB_ID = B.PUB_ID
WHERE P.[NAME] = 'HarperCollins'

-------------------------------------------------------------------

--Q4
SELECT U.SSN ,BR.DATE_BORROW,BR.DUE_DATE  --I joined USER with BORROWING to get the borrowing info, then filtered using DUE_DATE
FROM [USER] U INNER JOIN BORROWING BR
ON BR.SSN = U.SSN
WHERE BR.DUE_DATE < '7/1/2022'

-------------------------------------------------------------------

--Q5
SELECT CONCAT(B.TITLE,' is written by ',A.[NAME]) [BOOK_AUTHORITY]   --I joined BOOK, BOOK_AUTHOR and AUTHOR together, then used CONCAT to build the sentence in one column
FROM BOOK B INNER JOIN BOOK_AUTHOR BA
ON BA.BOOK_ID = B.BOOK_ID
INNER JOIN AUTHOR A
ON BA.AUTHOR_ID = A.AUTHOR_ID

-------------------------------------------------------------------

--Q6
SELECT U.[NAME]   --I used LIKE with % on both sides to search for the letter A anywhere in the name
FROM [USER] U 
WHERE U.[NAME] LIKE '%A%'

-------------------------------------------------------------------

--Q7
SELECT TOP(1) U.SSN, COUNT(*) [COUNT]   --I joined BORROWING with USER, grouped by SSN, counted the records, then sorted descending and took the top one (first line)
FROM BORROWING BOR INNER JOIN [USER] U 
ON BOR.SSN = U.SSN
GROUP BY U.SSN
ORDER BY [COUNT] DESC

-------------------------------------------------------------------

--Q8
SELECT U.SSN , SUM(BOR.AMOUNT_OF_MONEY_FOR_BORROW) [TOTAL AMOUNT OF MONEY]     --I joined BORROWING with USER, then grouped by SSN and used SUM to get total money paid per user
FROM BORROWING BOR INNER JOIN [USER] U 
ON BOR.SSN = U.SSN
GROUP BY U.SSN

-------------------------------------------------------------------

--Q9
SELECT C.CAT_NAME
FROM BOOK B INNER JOIN BORROWING BOR   --I joined BOOK, BORROWING and CATIGORY together, then used a subquery with MIN to filter on the lowest amount
ON BOR.BOOK_ID = B.BOOK_ID
INNER JOIN CATIGORY C
ON B.CAT_ID = C.CAT_ID
WHERE BOR.AMOUNT_OF_MONEY_FOR_BORROW = 
(
SELECT MIN(AMOUNT_OF_MONEY_FOR_BORROW)
FROM BORROWING
)

-------------------------------------------------------------------

--Q10
SELECT E.EMP_ID , COALESCE(E.EMAIL,E.[ADDRESS], CONVERT(NVARCHAR(50),E.[DATE_OF_BIRTH])) [INFO]    --I used COALESCE to return EMAIL first, then ADDRESS, then DATE_OF_BIRTH converted to text if the others are null
FROM EMPLOYEE E

-------------------------------------------------------------------

--Q11
SELECT C.CAT_ID , C.CAT_NAME , COUNT(B.BOOK_ID) [Count Of Books]    --I joined BOOK with CATIGORY, then grouped by category and used COUNT to get number of books per category
FROM BOOK B INNER JOIN CATIGORY C
ON B.CAT_ID = C.CAT_ID
GROUP BY C.CAT_ID , C.CAT_NAME

-------------------------------------------------------------------

--Q12
SELECT B.BOOK_ID    --I used a subquery to get the code of the shelf on floor 1 (which is A1), then excluded books with that code
FROM BOOK B 
WHERE B.CODE NOT IN (SELECT S.CODE FROM SHELF S WHERE S.F_NUMBER = 1 AND S.CODE = 1)

-------------------------------------------------------------------

--Q13
SELECT F.FLOOR_NUMBER , F.NUMBER_BLOCKS , COUNT(F.EMP_ID) [NUMBER_EMPLOYEE]   --I joined FLOOR with EMPLOYEE, then grouped by floor and used COUNT to get number of employees on each floor
FROM [FLOOR] F INNER JOIN EMPLOYEE E
ON F.EMP_ID = E.EMP_ID 
GROUP BY F.FLOOR_NUMBER , F.NUMBER_BLOCKS

-------------------------------------------------------------------

--Q14
SELECT B.TITLE , U.[NAME] , BOR.DATE_BORROW   --I joined BOOK, BORROWING and USER together, then filtered DATE_BORROW using BETWEEN for the given period
FROM BOOK B INNER JOIN BORROWING BOR
ON BOR.BOOK_ID = B.BOOK_ID
INNER JOIN [USER] U 
ON BOR.SSN = U.SSN
WHERE DATE_BORROW BETWEEN '3/1/2022' AND '10/1/2022'

-------------------------------------------------------------------

--Q15
SELECT EMP.F_NAME + ' ' + EMP.L_NAME [EMP_NAME], SUPERVISOR.F_NAME + ' ' + SUPERVISOR.L_NAME [SUPER_NAME]    --I joined EMPLOYEE with itself using SUPER_ID to get each employee's name next to their supervisor's name
FROM EMPLOYEE AS [EMP] INNER JOIN EMPLOYEE AS [SUPERVISOR]
ON SUPERVISOR.EMP_ID = EMP.SUPER_ID

-------------------------------------------------------------------

--Q16
SELECT E.F_NAME + '' + E.L_NAME [EMP_FULL_NAME] , COALESCE(E.SALARY , E.BONUS ) [SALARY OR BONUS]   --I used COALESCE to return SALARY if it exists, otherwise BONUS
FROM EMPLOYEE E

-------------------------------------------------------------------

--Q17
SELECT MAX(SALARY) [MAX_SALARY], MIN(SALARY) [MIN_SALARY]   --I used MAX and MIN together on SALARY to get the highest and lowest salary in one row
FROM EMPLOYEE E

-------------------------------------------------------------------

--Q18
CREATE FUNCTION EVEN_OR_ODD (@NUMBER INT)   -- I created a scalar function that checks the number with the modulus operator and returns EVEN or ODD
RETURNS NVARCHAR(5)
AS
BEGIN
    IF @NUMBER % 2 = 0
        RETURN 'EVEN'

    RETURN 'ODD'
END

-------------------------------------------------------------------

--Q19
CREATE FUNCTION B_CAT (@CAT_NAME NVARCHAR(20)) RETURNS TABLE   --I created a inline function that takes a category name as a parameter and returns the titles of books in that category
AS
RETURN
(
SELECT B.TITLE
FROM CATIGORY C INNER JOIN BOOK B
ON B.CAT_ID = C.CAT_ID
WHERE @CAT_NAME = C.CAT_NAME
)

-------------------------------------------------------------------

--Q20
CREATE FUNCTION BORR (@PH INT) RETURNS TABLE    --I created a inline function that takes a phone number as a parameter, joined it through USER_PHONES to get the borrowing details
AS
RETURN
(
SELECT B.TITLE , U.[NAME] , BOR.AMOUNT_OF_MONEY_FOR_BORROW
FROM BOOK B INNER JOIN BORROWING BOR
ON BOR.BOOK_ID = B.BOOK_ID
INNER JOIN [USER] U
ON BOR.SSN = U.SSN
INNER JOIN USER_PHONES UP
ON UP.SSN = U.SSN
WHERE @PH = UP.PHONES
)

-------------------------------------------------------------------

--Q21
CREATE FUNCTION CHEK_USER_NAME (@U_N NVARCHAR(50)) RETURNS @RESULT TABLE (U_N NVARCHAR(50))     --I created a multi statement function that counts how many times a username appears, then returns a message based on the count (repeated, not repeated, or not found)

AS
BEGIN
DECLARE @COUNT INT
SELECT @COUNT = COUNT(U.[NAME])
FROM [USER] U
WHERE U.[NAME] = @U_N

IF @COUNT > 1
INSERT INTO @RESULT
VALUES(CONCAT(@U_N, ' IS REPEATED ' , @COUNT))

ELSE IF @COUNT = 1
INSERT INTO @RESULT
VALUES(CONCAT(@U_N, ' NOT REPEATED ' , @COUNT))

ELSE 
INSERT INTO @RESULT
VALUES(CONCAT(@U_N, ' NOT FOUND ' , @COUNT))
 RETURN
END

-------------------------------------------------------------------

--Q22
CREATE FUNCTION [DATE_FORMAT] (@DATE DATE , @FORMAT NVARCHAR(20)) RETURNS NVARCHAR(20)      --I created a scalar function that takes a date and a format, then uses FORMAT() to return it in the required shape
AS
BEGIN
RETURN FORMAT(@DATE,@FORMAT)
END

-------------------------------------------------------------------

--Q23
CREATE PROC NUM_BOOKS      --I created a stored procedure that joins CATIGORY with BOOK and groups by category to show the number of books in each one
AS
SELECT C.CAT_ID , COUNT(B.BOOK_ID) [NUM_BOOKS_BER_CATEGORY]
FROM CATIGORY C INNER JOIN BOOK B
ON B.CAT_ID = C.CAT_ID
GROUP BY C.CAT_ID

-------------------------------------------------------------------

--Q24
CREATE PROCEDURE UPDATE_FLOOR_MANAGER @OLD_ID INT , @NEW_ID INT , @FLOOR_NUMBER INT       --I created a stored procedure that takes the old manager id, new manager id and floor number, then updates the floor with the new manager
AS
BEGIN
UPDATE [FLOOR]
SET [FLOOR].EMP_ID = @NEW_ID
WHERE [FLOOR].FLOOR_NUMBER = @FLOOR_NUMBER AND [FLOOR].EMP_ID = @OLD_ID
END

-------------------------------------------------------------------

--Q25
CREATE VIEW AlexAndCairoEmp        --I created a view that filters employees living in Alex or Cairo
AS
SELECT *
FROM EMPLOYEE E
WHERE E.[ADDRESS] IN ('ALEX','CAIRO')

-------------------------------------------------------------------

--Q26
CREATE VIEW V2              --I created a view that joins BOOK with SHELF and groups by shelf code to count how many books are on each shelf
AS
SELECT SH.CODE , COUNT(B.BOOK_ID) [NUMBER_BOOKS]
FROM BOOK B INNER JOIN SHELF SH
ON B.CODE = SH.CODE
GROUP BY SH.CODE

-------------------------------------------------------------------

--Q27               --I created a view on top of V2 that orders by number of books descending and takes the shelf with the most books
CREATE VIEW V3
AS
SELECT TOP(1) V2.CODE
FROM DBO.V2
ORDER BY V2.NUMBER_BOOKS DESC

-------------------------------------------------------------------

--Q28 
CREATE TABLE RETURNED_BOOKS               --I created the ReturnedBooks table to store returned book records
(
USER_SSN INT REFERENCES [USER](SSN),
BOOK_ID INT REFERENCES BOOK(BOOK_ID),
DUE_DATE DATE,
RETURN_DATE DATE, 
FEES MONEY
)

CREATE TRIGGER T_RETURN_BOOK    --I created an INSTEAD OF INSERT trigger that checks the due date against the return date, calculates a 20% fee if they don't match, then inserts the row myself
ON RETURNED_BOOKS
INSTEAD OF INSERT
AS
BEGIN
DECLARE @DUE_DATE DATE, @RETURN_DATE DATE, @FEES MONEY
SELECT @DUE_DATE = I.DUE_DATE,
@RETURN_DATE = I.RETURN_DATE,
@FEES = BOR.AMOUNT_OF_MONEY_FOR_BORROW * 0.2
FROM INSERTED I INNER JOIN BORROWING BOR ON BOR.SSN = I.USER_SSN AND BOR.BOOK_ID = I.BOOK_ID
IF (@DUE_DATE = @RETURN_DATE)
SET @FEES = 0
INSERT INTO RETURNED_BOOKS (USER_SSN, BOOK_ID, DUE_DATE, RETURN_DATE, FEES)
SELECT USER_SSN, BOOK_ID, DUE_DATE, RETURN_DATE, @FEES
FROM INSERTED
END

-------------------------------------------------------------------

--Q29
/*My dataset doesn't have an employee with SSN = 20, so I had to add one myself first.
Since EMP_ID is IDENTITY, I can't set its value manually, so I turned IDENTITY_INSERT ON
to force the value 20, then turned it back OFF right after so the table goes back to normal.*/
SET IDENTITY_INSERT EMPLOYEE ON
INSERT INTO EMPLOYEE (EMP_ID, F_NAME, L_NAME, PHONE, EMAIL, BONUS, SALARY, [ADDRESS], DATE_OF_BIRTH, SUPER_ID)
VALUES (20, 'TEST', 'MANAGER', 111000020, 'test20@gmail.com', 100, 10000, 'CAIRO', '1990-01-01', 1)
SET IDENTITY_INSERT EMPLOYEE OFF

/*Same thing here, my dataset doesn't have an employee with SSN = 12 (Ali Mohamed) either,
so I added him the same way using IDENTITY_INSERT before assigning him the floor later.*/
SET IDENTITY_INSERT EMPLOYEE ON
INSERT INTO EMPLOYEE (EMP_ID, F_NAME, L_NAME, PHONE, EMAIL, BONUS, SALARY, [ADDRESS], DATE_OF_BIRTH, SUPER_ID)
VALUES (12, 'ALI', 'MOHAMED', 111000012, 'ali12@gmail.com', 100, 10000, 'CAIRO', '1990-01-01', 1)
SET IDENTITY_INSERT EMPLOYEE OFF

/* I inserted the new floor with 2 blocks and made employee 20 the temporary manager,
with the hiring date set to today using GETDATE() as the question asked.*/
INSERT INTO [FLOOR] (NUMBER_BLOCKS,EMP_ID,HIRING_DATE)
VALUES(2,20,GETDATE())

/*FLOOR_NUMBER is also IDENTITY, so I couldn't control which number the new floor got.
I checked my table and the new floor ended up as number 7, so I used 7 directly here
to move Omar Amr (SSN=5) in as the manager of this new floor, replacing employee 20.*/
UPDATE [FLOOR] SET EMP_ID = 5 WHERE FLOOR_NUMBER = 7

/*Since Omar Amr moved to the new floor (7), his old floor is now empty of a manager.
I used a subquery to find his old floor (the one with EMP_ID = 5 that isn't floor 7),
and gave it to Ali Mohamed (SSN=12) instead.*/
UPDATE [FLOOR] SET EMP_ID = 12 WHERE FLOOR_NUMBER = (SELECT FLOOR_NUMBER FROM [FLOOR] WHERE EMP_ID = 5 AND FLOOR_NUMBER != 7)

-------------------------------------------------------------------

--Q30
CREATE VIEW v_2006_check AS           --I created a view that filters floors with a hiring date between March and May 2022
SELECT EMP_ID, FLOOR_NUMBER, NUMBER_BLOCKS, HIRING_DATE
FROM [FLOOR]
WHERE HIRING_DATE BETWEEN '2022-03-01' AND '2022-05-31'

CREATE TRIGGER T_CHECK_2006_INSERT   --I created an INSTEAD OF INSERT trigger on the view that only inserts the row if the hiring date matches the condition, otherwise it prints a message
ON v_2006_check
INSTEAD OF INSERT
AS
BEGIN
DECLARE @HIRING_DATE DATE
SELECT @HIRING_DATE = HIRING_DATE 
FROM INSERTED
IF (@HIRING_DATE BETWEEN '2022-03-01' AND '2022-05-31')
BEGIN
INSERT INTO [FLOOR] (EMP_ID, NUMBER_BLOCKS, HIRING_DATE)
SELECT EMP_ID, NUMBER_BLOCKS, HIRING_DATE FROM INSERTED
END
ELSE
BEGIN
PRINT 'Hiring date must be between March and May 2022'
END
END

INSERT INTO v_2006_check (EMP_ID, NUMBER_BLOCKS, HIRING_DATE)       --I tried inserting a floor with a date inside the allowed period, this one should succeed
VALUES (12, 3, '2022-04-10') 

INSERT INTO v_2006_check (EMP_ID, NUMBER_BLOCKS, HIRING_DATE)      --I tried inserting a floor with a date outside the allowed period, this one should get rejected by the trigger
VALUES (12, 4, '2022-08-15')

-------------------------------------------------------------------

--Q31
CREATE TRIGGER T_PROTECT_EMPLOYEE        --I created an INSTEAD OF trigger on EMPLOYEE for insert, update and delete, so any of these actions gets blocked and shows a message instead
ON EMPLOYEE
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
PRINT 'You can not take any action with this table'
END

-------------------------------------------------------------------

--Q32

DELETE FROM EMPLOYEE  --Try to delete a parent row that still has children linked to it
WHERE EMP_ID = 1
/*This will not actually run because the protection trigger from Q31 blocks any delete on EMPLOYEE first,
so it never even reaches the point of checking the FK with FLOOR*/

INSERT INTO BOOK (TITLE, CAT_ID, CODE) --Try to insert a child row with a value that doesn't exist in the parent table
VALUES ('Test', 999, 1)
-- This will fail because CAT_ID = 999 doesn't exist in CATIGORY table


UPDATE EMPLOYEE --Try to change the primary key value of a parent row
SET EMP_ID = 100 
WHERE EMP_ID = 1  
/*This will not actually run either because the same protection trigger blocks any update on EMPLOYEE,
so the IDENTITY restriction and the FK reference never get tested here*/

INSERT INTO [USER] (EMAIL, [NAME], EMP_ID) 
VALUES ('x@gmail.com', 'Test', NULL)  --Try to insert a child row with NULL in the foreign key column
--This will succeed because FK allows NULL, meaning no employee is linked yet

-------------------------------------------------------------------
