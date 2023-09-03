USE iti_new
GO

--1. Create a scalar function that takes date and returns Month name of that date.
CREATE OR ALTER FUNCTION GetMonthName (@inputdATE DATE )
RETURNS varchar (50)
AS
BEGIN 
DECLARE @monthname VARCHAR(50)
SELECT @monthname = DATENAME(month,@inputdATE )
RETURN @monthname 

END
SELECT dbo.GetMonthName('2023-08-23') AS MonthName;


--2. Create a multi-statements table-valued function that takes 2 integers and returns the values between them

CREATE OR alter FUNCTION GetStudentsInRange(@startID INT,@endID INT)
RETURNS @StudentTable TABLE (StudentID INT, StudentName NVARCHAR(100))
AS
BEGIN
    INSERT INTO @StudentTable (StudentID, StudentName)
    SELECT st_id, St_fname
    FROM Student
    WHERE St_Id BETWEEN @startID AND @endID;
    
    RETURN
END;

SELECT * FROM dbo.GetStudentsInRange(2, 3);

--3. Create a tabled valued function that takes Student No and returns Department Name with Student full name.

CREATE OR ALTER FUNCTION GetStudentDepartmentInfo(@studnetno int )
RETURNS TABLE 
AS
RETURN 
(
SELECT st_fname,st_lname,d.Dept_Name
FROM student  t JOIN Department d
ON d.dept_id=T.dept_id
WHERE st_id=@studnetno
)
SELECT * FROM GetStudentDepartmentInfo(2)


--4. Create a scalar function that takes Student ID and returns a message to user

CREATE OR ALTER FUNCTION GetStudentMessage(@studentID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @message NVARCHAR(100)
    DECLARE @firstName NVARCHAR(50)
    DECLARE @lastName NVARCHAR(50)

    SELECT @firstName = st_fname, @lastName = st_lname
    FROM Student
    WHERE St_Id = @studentID
    
    IF @firstName IS NULL AND @lastName IS NULL
        SET @message = 'First name & last name are null'
    ELSE IF @firstName IS NULL
        SET @message = 'First name is null'
    ELSE IF @lastName IS NULL
        SET @message = 'Last name is null'
    ELSE
        SET @message = 'First name & last name are not null'
    
    RETURN @message
END;


DECLARE @studentMessage NVARCHAR(100)
SET @studentMessage = dbo.GetStudentMessage(1000);

PRINT @studentMessage;


--Create a function that takes integer which represents the format of the Manager hiring date 
--and displays department name, Manager Name and hiring date with this format.

CREATE FUNCTION GetFormattedManagerInfo( @dateFormat INT)
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @formattedInfo NVARCHAR(200)
    
    SELECT @formattedInfo = 
        CASE 
            WHEN @dateFormat = 1 THEN 
                'Department: ' + d.dept_name + ', Manager: ' + i.ins_name + ', Hiring Date: ' + CONVERT(NVARCHAR(20), d.manager_hiredate, 101)
            WHEN @dateFormat = 2 THEN 
                'Department: ' + d.dept_name + ', Manager: ' + i.ins_name  + ', Hiring Date: ' + CONVERT(NVARCHAR(20), d.manager_hiredate, 103)
            ELSE 
                'Invalid format code'
        END
    FROM  Instructor i join department D 
	ON i.Dept_Id=d.Dept_Id
    WHERE i.Dept_Id = 1
    
    RETURN @formattedInfo
END;


DECLARE @formattedInfo NVARCHAR(200)
SET @formattedInfo = dbo.GetFormattedManagerInfo(2);

PRINT @formattedInfo;


--7. Write a query that returns the Student No and Student first name without the last char

CREATE OR ALTER FUNCTION RemoveLastChar(@inputString NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @result NVARCHAR(100)
    SET @result = LEFT(@inputString, LEN(@inputString) - 1)
    RETURN @result
END;

SELECT St_id, dbo.RemoveLastChar(st_fName) AS FirstNameWithoutLastChar
FROM Student;

--8. Write a query that takes the columns list and table name into variables and then return the result of this query “Use exec command”


--1. Create function that takes project number and display all employees in this project
USE Company_SD
GO 
CREATE OR ALTER FUNCTION GetEmployeesInProject(@pnmuber INT )
RETURNS TABLE 
AS
RETURN 
(
SELECT ssn,fname,lname,pname,pnumber
FROM project p JOIN works_for wf
ON wf.pno=p.pnumber
JOIN employee e
ON wf.essn=e.ssn
WHERE pnumber =@pnmuber 
)
SELECT * FROM GetEmployeesInProject(400) 
---------------------------end 
