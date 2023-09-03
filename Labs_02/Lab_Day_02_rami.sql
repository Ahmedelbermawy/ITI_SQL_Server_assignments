USE Company_SD
GO 

--1. Create the following schema and transfer the following tables to it 
--a. Company Schema i. Department table (Programmatically) ii. Project table (visually)
--b. Human Resource Schema i. Employee table (Programmatically)
--CREATE SCHEMA company 
--ALTER SCHEMA company TRANSFER departments

--CREATE SCHEMA humanresource 
--ALTER SCHEMA humanresource TRANSFER employee

--DROP SCHEMA IF EXISTS humanresource 

--SELECT * FROM company.Departments 
-------------------use iti db -------------------------------
--1. Create a view that displays student full name, course name if the student has a grade more than 50

USE ITI_new
GO
CREATE OR ALTER VIEW course_studentname
AS
SELECT CONCAT(s.St_Fname,'',s.St_Lname) AS fullname,c.Crs_Name,sc.Grade
FROM Course c JOIN Stud_Course sc
ON sc.crs_id=c.Crs_Id 
JOIN Student s
ON s.St_Id=sc.St_Id
WHERE grade >50

SELECT * FROM course_studentname

--2. Create an Encrypted view that displays manager names and the topics they teach.
-- Create a view that combines manager names and topics they teach
CREATE OR ALTER VIEW EncryptedManagerTopics 
WITH ENCRYPTION
AS
SELECT
    ins_name,d.Dept_Manager,d.Dept_Name,top_name
	FROM Instructor i JOIN Department d
	ON i.Dept_Id =d.Dept_Id 
	JOIN ins_course cs
	ON cs.Ins_Id=i.Ins_Id 
	JOIN Course c
	ON c.Crs_Id=cs.Crs_Id 
	JOIN topic t  
	ON t.Top_Id=c.Top_Id

SELECT * FROM EncryptedManagerTopics 

--3. Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
--“use Schema binding” and describe what is the meaning of Schema Binding

CREATE VIEW  dbo.isn_Departname_binding_schema
WITH SCHEMABINDING
AS
SELECT ins_name,dept_name
FROM dbo.instructor i JOIN dbo.department d
ON i.dept_id=D.dept_id
WHERE d.dept_name IN('SD','Java')

SELECT * FROM dbo.isn_Departname_binding_schema

--4. Create a view “V1” that displays student data for student who lives in Alex or Cairo.

CREATE OR ALTER VIEW stu_lives_alex_cairo
AS
SELECT CONCAT(st_fname,'',st_lname) AS fullname,St_Address
FROM student 
WHERE St_Address IN ('Alex','Cairo')

SELECT * FROM stu_lives_alex_cairo
--------------------------
--4. Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query Update V1 set st_address=’tanta’ Where st_address=’alex’
CREATE OR ALTER VIEW V
AS
SELECT
    St_Id,St_Fname,St_Lname,st_address
FROM
    Student
WHERE
    st_address IN ('Alex', 'Cairo')
WITH CHECK OPTION


 insert into V
 VALUES(15,'bermawy','raaad','alex'),
        (16,'amr','ahmed','alex')

SELECT * FROM V 

UPDATE V
SET St_Address='tanta'
WHERE St_Address='Alex'

--5. Create temporary table [Session based

CREATE TABLE ##GlobalTemporaryTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

--6. Create temporary table [Session based] on Company DB to save employee name and his today task
-- Use the Company database
USE Company_SD
GO

-- Create a session-based temporary table
CREATE TABLE #EmployeeTasks (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    TodayTask VARCHAR(255)
);

-- Insert data into the temporary table
INSERT INTO #EmployeeTasks (EmployeeID, EmployeeName, TodayTask)
VALUES
    (1, 'John Doe', 'Finish project report'),
    (2, 'Jane Smith', 'Review presentation'),
    (3, 'Michael Johnson', 'Attend team meeting');

SELECT * FROM #EmployeeTasks et


---------------------use company_db ----------------------------------
--1. Fill the Create a view that will display the project name and the number of employees work on it

CREATE OR ALTER VIEW dis_pname_count_emp
AS
SELECT CONCAT(e.Fname,'',e.Lname)AS fullname, pname, COUNT(e.SSN) AS num_of_emp
FROM Employee e JOIN works_for w 
ON e.ssn=w.ESSn
JOIN project p
ON P.Pnumber=w.Pno 
GROUP BY e.Fname,e.Lname,p.Pname

SELECT * FROM dis_pname_count_emp

--2. Create a view named “v_count “ that will display the project name and the number of hours for each one
CREATE OR ALTER VIEW v_count
AS
SELECT pname,hours,COUNT(hours) AS hours_pname
FROM project p JOIN works_for w
ON w.pno=P.pnumber
GROUP BY pname,w.Hours

SELECT * FROM v_count vc

--3. Create a view named “v_D30” that will display employee number, project number, hours of the projects in department 30. updated

CREATE OR ALTER VIEW  v_d30
as 
SELECT  COUNT(ssn) AS employee_number ,pnmuber,hours
FROM employee e JOIN Works_for wf 
ON e.SSN = wf.ESSn 
JOIN Project p
ON wf.Pno = p.Pnumber 
JOIN Departments d
ON p.Dnum = d.Dnum
WHERE dnum=30
GROUP BY p.Pnumber,wf.Hours 

SELECT * FROM v_d30
--6. Display the project name that contains the letter “c” Use the previous view created in Q#1

CREATE OR ALTER VIEW  Q1
AS
SELECT pname FROM project 
WHERE pname LIKE '%c%'

SELECT * FROM Q1

--8. Create Rule for Salary that is less than 2000 using rule.

CREATE  rule r1 AS @x<2000 
GO 
sp_bindrule r1 , 'employee.salary'
create default def1 as 5000

sp_bindefault  def1,'Employee.salary'

-- Create a rule to enforce Salary less than 2000
CREATE RULE Rule_SalaryLessThan2000
AS
    @Salary < 2000;

--9. Create a new user defined data type named loc with the following Criteria:
-- nchar(2)
-- default: NY
-- create a rule for this Data type :values in (NY,DS,KW)) and associate it to the location column

-- Create the user-defined data type 'loc'
CREATE TYPE loc
FROM nchar(2);
-- Create a rule for the 'loc' data type
CREATE RULE Rule_LocationValues
AS
    @value IN ('NY', 'DS', 'KW');

-- Bind the rule to the user-defined data type
EXEC sp_bindrule 'Rule_LocationValues', 'loc';

-- Create a table using the user-defined data type with a default value
CREATE TABLE SampleTable 
(
    ID INT PRIMARY KEY,
    Location loc DEFAULT 'NY'
);

--------------------------end--------------------------------

