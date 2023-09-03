---1---Create a view that shows the project number and name along with the total number of hours worked on each project.

use Company_SD
go

create view total_num_hours
 as 
 select Pnumber,Pname,sum(Hours) as sum_hours
 from Project p  join Works_for w
 on p.Pnumber=w.Pno
 group by pnumber,Pname
go
 select * from total_num_hours

 --2--Create a view that displays the project number and name along with the name of the department managing the project, ordered by project number

create or alter view manage_project
as
select Pnumber,pname ,Dname
from project p  right join Departments d
on p.Dnum=d.Dnum 
go
select * from manage_project
order by Pnumber

--3--Create a view that shows the project name and location along with the total number of employees working on each project

create or alter view emp_numproj
as
select pname,plocation ,count(essn) as total_num_Emp
from project p join Works_for w
on p.Pnumber=w.Pno
group by pname,Plocation 
go
select * from emp_numproj

--4--Create a view that displays the department number, name, and the number of employees in each department

create or alter view emp_num
as
select dnum,dname ,count(ssn) as num_of_employee
from Departments d join Employee e
on  d.Dnum=e.Dno
group by Dnum,Dname
go 
select * from emp_num 
--5--Create a view that shows the names of employees who work on more than one project, along with the count of projects they work on

create or alter view emp_proj_num
as
select concat (fname,' ',lname) as fullname ,count(pnumber) as p_num
from Employee e join Works_for w 
on e.ssn=w.ESSn 
join Project p
on w.pno=p.Pnumber
group by Fname,Lname
go 
select * from emp_proj_num
where  p_num>1
--6--Create a view that displays the average salary of employees in each department, along with the department name
create or alter  view salary_emp_dept
as
select avg(salary) as salary_emp , dname
from Employee e join Departments d
on e.dno=d.Dnum
group by Dname
go 
select * from salary_emp_dept

--7--Create a view that lists the names and age of employees and their dependents in a single result set. The age should be calculated based on the current date
create or alter view lists_of_name
as 
select CONCAT(fname,' ',lname) as fullname , (year(getdate())-(year(Bdate))) as age 
from employee 
union 
select Dependent_name as fullname , (year(getdate())-(year(Bdate))) as age 
from Dependent 
go 
select * from lists_of_name
--8--Create a view that displays the names of employees who have dependents, along with the number of dependents each employee has.
 create or alter view num_depend_emp 
 as
 select CONCAT(fname,' ',lname) as fullname,count(ESSN) as emp_num
 from employee e join Dependent d
 on e.SSN=d.ESSN 
 group by fname,Lname
 go
 select * from num_depend_emp 
select * from project 
for xml auto 
 9--Create a new user defined data type named loc with the following Criteria:
 create type loc from nchar(2) not null;
 go 
 create rule compare as @c in (NY,DS,KW)
 go 
 create default k as NY
 go 
 sp_bindrule compare,loc
 go
 sp_bindefault k,loc
 go
 create table project3
 (
 idno int primary key ,
 name nvarchar(50),
 location nchar(2) 
 )
 go 
 alter table project3
 alter column location loc


 --10--. Create a view that displays the full name (first name and last name), salary, and the name of the department for employees working in the department with the highest average salary.
 create or alter view emp_num_dept_high_salary
 as
 select concat(Fname,' ',Lname) as fullname, Salary,dname
 from employee e join Departments d
 on d.Dnum=e.Dno
 where salary >all (select avg(salary) from Employee)
 go
 select * from emp_num_dept_hight_salary 
 --11--Create a view that displays the names and salaries of employees who earn more than the average salary of their department.
 create or alter view emp_num_dept_more
 as
select concat(fname,'',lname) as fullname ,Salary,Dname
from employee e join  Departments d
on d.Dnum=e.Dno
where salary >all(select AVG(Salary) from Employee where  Dno=Dnum)
go 
select * from emp_num_dept_more 
