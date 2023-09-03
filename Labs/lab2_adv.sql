use Company_SD
go
--1-      Create Scalar function name GetEmployeeSupervisor Type: Scalar Description:
--Returns the name of an employee's supervisor based on their SSN.

create or alter function getemployeesupervisor (@ssn int) 
returns varchar(50)
 begin 
    declare @name varchar(50)
  select @name=s.Fname 
  from employee e join employee s
  on s.ssn=e.superssn
  where e.SSN=@ssn
  return @name
 end 
 --select * from Employee
select dbo.getemployeesupervisor (112233) as fname

--2- Create Inline Table-Valued Function GetHighSalaryEmployees Description:
--Returns a table of employees with salaries higher than a specified amount

create or alter function GetHighSalaryEmployees(@specified_amount int )
returns table 
as 
return 
(
select fname,lname, salary
from employee 
where Salary>@specified_amount

)
go 
select * from GetHighSalaryEmployees(2000)

--select * from Employee 

--3- Create function with name GetTotalSalary Type: Scalar Function Description: 
--Calculates and returns the total salary of all employees in the specified department.

create or alter function GetTotalSalary(@id_dum int )
returns int
  begin
   declare @tolsalary int
   select @tolsalary=sum(salary)
   from employee 
   where Dno=@id_dum
   return @tolsalary
  end 
go
select * from Employee
select  dbo.GetTotalSalary(10) --10-20-30

--4- Create function with GetDepartmentManager Type: Inline Table-Valued Function Description: 
--Returns the manager's name and details for a specific department.

create or alter function GetDepartmentManager(@specific_dept int )
returns table
as
return
(
  select fname,lname,dname,Dnum
  from employee e join Departments d 
  on e.SSN=d.MGRSSN
  where Dnum=@specific_dept
)
go
select * from GetDepartmentManager(10)

--6-Create multi-statements table-valued function that takes a string parameter 
--If string='first name' returns student first name 
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
--Note: Use “ISNULL()” function

create or alter function getemployee (@reqname varchar(50))
returns @t table (ename varchar(50))
as
begin 
 if @reqname = 'first name'
   begin
    insert @t 
	select isnull(fname,' ') 
	from employee 
   end 
 else if @reqname='last name' 
   begin
    insert @t 
	select isnull(lname,' ')
	from  employee 
   end
 else if @reqname='full name'
   begin
  insert @t 
  select isnull(fname+' '+lname,' ') 
  from employee 
   end
 return 
end
go

select * from  getemployee ('full name')
---------------------iti DB----------------------------------
--1-. Table-Valued Function - Get Instructors with Null Evaluation:
--   This function returns a table containing the details of instructors who have null evaluations for any course.
use ITI_new
go 
create or alter function Get_Instructors_with_Null_Evaluation ()
returns table
as
return 
(
select ins_name,Ins_degree,salary , c.Evaluation
from Instructor i join Ins_Course c
on i.Ins_Id  =c.Ins_Id and c.Evaluation is null
)
select * from Instructor
select * from Get_Instructors_with_Null_Evaluation ()

--2-2. Table-Valued Function - Get Top Students: 
---This function returns a table containing the top students based on their average grades.
create or alter function Get_Top_Students(@num int )
returns table 
as
return 
(
select top (@num) concat (st_fname,' ',st_lname) as fullname, avg(grade) as avggrade--over(order by grade desc ) as avg_grade
from Student s join Stud_Course c
on s.St_Id=c.st_id
group by St_Fname,St_Lname
order by avg(Grade) desc
)
go
SELECT * FROM Get_Top_Students(1);

--3-Table-Valued Function - Get Students without Courses: 
--This function returns a table containing details of students who are not registered for any course.

create or alter function Get_Students_without_Courses()
returns table
as
return 
(
select concat (st_fname,' ',st_lname) as fullname ,c.Crs_id
from Student s left join Stud_Course c
on s.St_Id=c.St_Id
where c.St_Id is null 
)
go
--select * from Student,course
select * from  Get_Students_without_Courses()
---------------------------final-------------------------------------
