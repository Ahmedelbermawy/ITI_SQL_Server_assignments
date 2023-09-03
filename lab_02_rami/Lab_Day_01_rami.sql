USE ITI_new
GO 
--1. Display instructor Name and Department Name Note: 
--display all the instructors if they are attached to a department or not
SELECT i.Ins_Name,d.Dept_Name
FROM Instructor i  JOIN Department d 
ON d.Dept_Id=i.Dept_Id

--2. Display student full name and the name of the course he is taking 
--For only courses which have a grade
SELECT s.St_Fname,s.St_Lname,c.Crs_Name,grade
FROM Student s JOIN Stud_Course sc ON s.St_Id=sc.St_Id
JOIN Course c 
ON c.Crs_Id=sc.Crs_Id

--3. Display number of courses for each topic name

SELECT COUNT(crs_id)  AS count ,t.Top_Name
FROM Course c JOIN Topic t
ON c.Top_Id = t.Top_Id
GROUP BY t.Top_Name

--4. Display max and min salary for instructors

SELECT MAX(i.Salary) AS max_salary ,MIN(i.Salary) AS min_salary ,i.Ins_Name
FROM Instructor i
GROUP BY i.Ins_Name

--5. Display instructors who have salaries less than the average salary of all instructors.
SELECT Ins_Name
FROM Instructor
WHERE salary <= (SELECT AVG(salary) FROM Instructor i)

--6. Display the Department name that contains the instructor who receives the minimum salary.
SELECT d.Dept_Name,ins_name,MIN(salary) AS min_salary  
FROM Department d JOIN Instructor i
ON d.Dept_Id=i.Dept_Id
GROUP BY i.Ins_Name,d.Dept_Name

----------------Use AdventureWorks DB----------------------
USE AdventureWorks2012
GO 
--1. Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to 
--designate SalesOrders that occurred within the period ‘7/28/2008’ and ‘7/29/2014’
SELECT salesorderid,shipdate
FROM Sales.SalesOrderHeader soh
WHERE soh.ShipDate BETWEEN '2008-07-28' AND '2014-07-29'

--2. Display only Products with a StandardCost below $110.00 (show ProductID, Name only)

SELECT ProductID,Name 
FROM Production.Product
WHERE StandardCost <110.00 
--3. Display ProductID, Name if its weight is unknown
SELECT p.ProductID,p.Name 
FROM Production.Product p
WHERE p.Weight IS NULL

--4. Display all Products with a Silver, Black, or Red Color
SELECT * FROM Production.Product p
WHERE p.Color IN ('sliver ','black','red')

--5. Display any Product with a Name starting with the letter B

SELECT * 
FROM Production.Product
WHERE Name LIKE 'B%'

--6. Transfer the rowguid ,FirstName, SalesPerson 
--from Customer table in a newly created table named [customer_Archive] updatedNote: 
--Check your database to see the new table and how many rows in it? 
---Try the previous query but without transferring the data


CREATE TABLE customer_archive
(
rowguid UNIQUEIDENTIFIER,
firstname NVARCHAR(MAX),
salesperson NVARCHAR(MAX)
)
INSERT INTO customer_archive (rowguid,firstname,salesperson)
SELECT rowguid,firstname,SalesPerson
SELECT * FROM Sales.Customer c
SELECT COUNT(*) AS NumberOfRows
FROM customer_Archive;

----------------company_SD----------------------------------
USE Company_SD
GO 
--1. Display the Department id, name and SSN and the name of its manager
SELECT d.Dnum,d.Dname,d.MGRSSN,fname,lname
FROM Departments  d JOIN Employee e
ON d.MGRSSN = e.SSN

--2. Display the name of the departments and the name of the projects under its control

SELECT d.Dname,p.Pname 
FROM project p JOIN Departments d
ON D.Dnum=P.Dnum

--3. display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT fname,lname,salary 
FROM employee e JOIN Departments d
ON e.dno=d.Dnum AND  d.Dnum=30 AND e.Salary BETWEEN 1000 AND 2000 
 

 --4. Retrieve the names of all employees in department 10 
 --who works more than or equal 10 hours per week on "AL Rabwah" project.
 
SELECT CONCAT(fname,' ',lname),w.Hours,pname
FROM employee e JOIN Departments  d
ON e.dno=d.dnum AND  d.dnum=10 
JOIN works_for w
ON e.ssn=w.ESSn AND w.Hours >=10 
JOIN project p
ON w.pno=P.Pnumber AND p.Pname='Al rabwah'


--5. Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT e.Fname,e.Lname
FROM employee e JOIN employee s 
ON s.Superssn=e.SSN AND s.fname='Mr Mr kamel'AND s.Lname='Mohamed'
SELECT * FROM Employee e
--or --
SELECT fname,Lname 
FROM employee
WHERE Superssn = (SELECT ssn FROM employee WHERE Fname = 'Mr Mr Kamel' AND Lname=' Mohamed');

--6. Retrieve the names of all employees and
--the names of the projects they are working on, sorted by the project name.

SELECT concat (fname,' ',lname),pname 
FROM employee e JOIN Works_for wf
ON e.SSN = wf.ESSn JOIN Project p
ON wf.Pno = p.Pnumber 
ORDER BY p.Pname

--7. For each project located in Cairo City , find the project number, 
--the controlling department name ,the department manager last name ,address and birthdate
SELECT pnumber,dname, e.Lname,e.Address,e.Bdate
FROM project p JOIN Departments d
ON p.Dnum = d.Dnum AND  p.Plocation= 'cairo '
JOIN employee e
ON d.MGRSSN = e.SSN


--8. Display All Data of the mangers
SELECT * FROM employee e JOIN Departments d
ON e.SSN = d.MGRSSN

--9. Display All Employees data and the data of their dependents 
--even if they have no dependents
SELECT * FROM employee e RIGHT JOIN Dependent d
ON e.SSN=D.ESSN

select @@VERSION 
select @@SERVERNAME







