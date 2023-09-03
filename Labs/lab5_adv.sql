Use ITI_new
go 
--Index

--1. Create an index on column (Hiredate) that allow u to cluster the data in the table Department. What will happen?
create clustered index allowhiredate 
on department(Manager_hiredate)

--2. Create an index that allows you to enter unique ages in the student table. What will happen?  
create unique index ageunquie 
on student(st_age)
--3. create a non-clustered index on column(Dept_Manager) that allows you to enter a unique instructor id in the table Department.  
create nonclustered index cdept_manager
on department (Dept_Manager)

--Use Cursor For the following Problems 

--Problem 1: Calculate Total Salary for Each Department
--Description: Calculate the total salary for each department and display the department name along with the total salary
use Company_SD
go 
declare c1 cursor 
for 
select sum(salary) as total_salary ,dname
from Departments d join employee e
on e.Dno=d.Dnum
group by d.dname
for read only 
declare @total_salary int ,@name varchar(50)
open c1
fetch c1 into @total_salary,@name
while @@FETCH_STATUS=0
begin 
select @total_salary as total_salary,@name as dept_name
fetch c1 into @total_salary,@name
end 
close c1
deallocate c1

--Problem 2: Update Employee Salaries Based on Department
--Description: Update employee salaries by increasing them by a certain percentage for a specific department.
declare c2 cursor 
for 
select salary ,dno
from Employee
for update 
declare @sal float,@dept_id int
open c2
fetch c2 into @sal,@dept_id
while @@FETCH_STATUS=0
begin 
if(@dept_id=10)
begin
update Employee
set salary +=0.10*Salary
where current of c2
end
fetch c2 into @sal,@dept_id
end
close c2
deallocate c2

select * from employee


--Problem 3: Calculate Average Project Hours per Employee
--Description: Calculate the average number of hours each employee has worked on projects, and display their names along with the calculated average hours
declare c3 cursor 
for
select fname,lname,Avg(hours) as avg_hour_project 
from employee e join Works_for w 
on w.essn=e.SSN join  project p
on w.Pno=p.pnumber 
group by fname,Lname
for read  only
declare @name1 varchar(50),@name2 varchar(50),@avg_hours float  
open c3
fetch c3 into @name1 ,@name2, @avg_hours
while @@FETCH_STATUS=0
begin
select @name1 as fname,@name2 as lname,@avg_hours as avg_hours
fetch c3 into @name1 ,@name2,@avg_hours 
end
close c3 
deallocate c3 


select * from Works_for

--Problem 4:  in employee table Check if Gender='M' add 'Mr Befor Employee name    
--else if Gender='F' add Mrs Befor Employee name  then display all names  
--use cursor for update
declare c4 cursor 
for 
select fname,Sex
from Employee
for update 
declare @fname varchar(50),@gender varchar(5)
open c4
fetch c4 into @fname,@gender 
while @@FETCH_STATUS=0
begin 
if(@gender='M')
begin
update Employee
set Fname ='Mr' +' '+Fname
where current of c4
end
else 
begin
update employee 
set Fname='Mrs'+' '+Fname
where current of c4
end
fetch c4 into @fname,@gender
end
close c4
deallocate c4

select * from employee
--------------------------final------------------------------