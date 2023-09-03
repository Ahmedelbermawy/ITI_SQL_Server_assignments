USE ITI_new
GO
--1. Create a stored procedure to show the number of students per department
CREATE OR ALTER PROC countstudentperdepartment
AS
SELECT COUNT(st_id) AS count__student ,d.Dept_Name
FROM Student s JOIN Department d
ON s.Dept_Id = d.Dept_Id
GROUP BY d.Dept_Name
--
EXEC countstudentperdepartment

--3 and 2. Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”

CREATE TRIGGER t10
ON Department
INSTEAD OF INSERT 
AS
SELECT 'not allow insert in this table '+SUSER_NAME() 

--test
SELECT * FROM Department d
INSERT INTO Department (Dept_Id,Dept_Name,Dept_Desc,Dept_Location,Dept_Manager,Manager_hiredate)
VALUES(80,'erd','busieens','aswan',10,'2023-05-30')

--4. Create a stored procedure that will check for the number of total of employees in the project no.100  
--if they are more than 3 print message to the user “'The number of employees in the project 100 is 3 or more'” 
--if they are less display a message to the user “'The following employees work for the project 100” 
--in addition to the first name and last name of each one. 

USE company_sD
GO 

/*

SELECT fname,lname,COUNT(ssn) AS count_employee 
FROM employee e JOIN works_for wf
ON E.ssn=wf.essn 
JOIN project p 
ON wf.pno=P.pnumber
WHERE pnumber=100
GROUP by fname,lname
*/
CREATE OR alter PROC checkprojectemployee
AS

BEGIN
    DECLARE @employee_count INT;
    
    SELECT @employee_count = COUNT(ssn)
    FROM employee e JOIN works_for wf
	ON e.ssn=wf.essn
	JOIN project p 
	ON wf.pno=p.pnumber
    WHERE p.pnumber = 100;
    
    IF @employee_count >= 3
    BEGIN
        PRINT 'The number of employees in the project 100 is 3 or more';
    END
    ELSE
    BEGIN
        PRINT 'The following employees work for the project 100:';
        
        SELECT CONCAT(fname, ' ', Lname) AS EmployeeName
        FROM employee e JOIN works_for wf
	    ON e.ssn=wf.essn
	    JOIN project p 
	    ON wf.pno=p.pnumber
        WHERE p.pnumber = 100;
    END
END

EXEC checkprojectemployee

--6. Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. 
--The procedure should take 3 parameters (old Emp.SSN, new Emp.SSN and the project no.) 
--and it will be used to update works_on table. 

CREATE OR ALTER PROC ReplaceEmployeeInProject

    @old_ssn VARCHAR(20),
    @new_ssn VARCHAR(20),
    @project_no INT
AS
BEGIN
    -- Delete the old employee's entry from works_on
    DELETE FROM employee JOIN works_for 
	ON e.ssn=wf.essn
	JOIN project P 
	ON wf.pno=P.pnumber
    WHERE ssn = @old_ssn AND pnumber = @project_no;
    
    -- Insert the new employee's entry into works_on
    INSERT INTO works_for (emp_ssn, project_no)
    VALUES (@new_ssn, @project_no);
    
    -- Display a success message
    PRINT 'Employee replacement successful.';
END;


EXEC ReplaceEmployeeInProject @old_ssn = 'old_employee_ssn', @new_ssn = 'new_employee_ssn', @project_no = 100;


--8. Create a trigger that prevents the insertion Process for Employee table in March .

CREATE TRIGGER t11
ON Employee
FOR INSERT
AS
BEGIN
    IF MONTH(GETDATE()) = 3
    BEGIN
	ROLLBACK;
     RAISERROR('Insertion into Employee table is not allowed in March.', 16, 1);
    END
    --ELse
    --BEGIN
    --    INSERT INTO Employee (fname, lname, ssn,Bdate,Address,sex,salary,supersnn,dno ) -- Specify the columns here
    --    SELECT fname,lname,ssn,Bdate,Address,Sex,salary,superssn,dno
    --    FROM INSERTED;
    --END
END

--9. Create a trigger that prevents users from altering any table in Company DB.

-- Create a role
CREATE ROLE NoAlterRole;

-- Deny ALTER permission to the role
DENY ALTER TO NoAlterRole;

-- Add users to the role
ALTER USER [] ADD ROLE NoAlterRole;
