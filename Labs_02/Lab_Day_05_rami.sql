USE ITI_new
GO 

--1. Write a query to rank the students according to their ages in each dept without gapping in ranking.use ITI
SELECT *,DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY st_age DESC) AS rank_student
FROM student 
WHERE Dept_Id IS NOT null

--2. Divide the products into 30 segments according to their weight to handle some operations in shipment use AdventureWorks
USE AdventureWorks2012
GO
WITH ProductWeightRanges 
AS (
    SELECT
        ProductID,
        Weight,
        NTILE(30) OVER (ORDER BY Weight) AS WeightSegment
    FROM
        Production.Product
)
SELECT
    WeightSegment,
    MIN(Weight) AS MinWeight,
    MAX(Weight) AS MaxWeight,
    COUNT(*) AS ProductCount
FROM
    ProductWeightRanges
GROUP BY
    WeightSegment
ORDER BY
    WeightSegment;

--3. Write a query to select the all highest two salaries for instructors in Each Department 
--who have salaries. “using one of Ranking Functions”.use ITI

USE ITI_new
GO 

SELECT TOP 2 i.Salary,i.Ins_Name,i.Dept_Id 
FROM Instructor i

SELECT *
FROM (
SELECT i.Salary,i.Ins_Name,i.Dept_Id ,DENSE_RANK() OVER(PARTITION BY i.Dept_Id ORDER BY i.Salary DESC) AS rank_Salary
FROM Instructor i 
) AS new_table
WHERE rank_Salary <=2

--SELECT * FROM Instructor

--4. Write a query to select the third project that took long time (works_for table). 
--use Company_SD ● try to redo it use CTE

USE Company_SD
GO 
WITH  thirdproject 
AS
(
SELECT  pname,plocation,city,SUM(hours) AS sum_hours ,
ROW_NUMBER() OVER ( ORDER BY SUM(wf.Hours)desc ) AS rank_project
FROM project p JOIN Works_for wf ON p.Pnumber = wf.Pno
GROUP BY p.Pname,p.Plocation,P.City
) 
SELECT * FROM thirdproject 
WHERE rank_project =3

--5. Try to create index on column (Hiredate) 
--that allow u to cluster the data in table Department. What will happen?

CREATE NONCLUSTERED INDEX IX_Department_HireDate
ON Department (HireDate);

USE ITI_new
GO 
--6. Try to create index that allow u to enter unique ages in student table

ALTER TABLE student
ADD CONSTRAINT UQ_UniqueAge UNIQUE (st_age);

--7. create a non-clustered index on column(Dept_Manager) that 
--allows you to enter a unique instructor id in the table Department.
USE Company_SD
GO 

CREATE UNIQUE NONCLUSTERED INDEX ix_dept_manager 
ON Departments (MGRSSN)
