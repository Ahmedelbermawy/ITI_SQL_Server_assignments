use ITI
go 
--1- Create a stored procedure to show the total number of students per department
create or alter proc total_of_num 
as
select count(s.St_Id) as count_num,d.Dept_Name
from student s join Department d
on s.dept_id= d.Dept_Id
group by d.Dept_Name

execute total_of_num  

Use Company_SD
go
--2. Create a trigger to prevent anyone from inserting a new record in 
--the Department table. Print a message for the user to tell him that 
--“he can’t insert a new record in that table”
create or alter  trigger read_onl
on departments 
instead of insert,update,delete 
as 
select 'you cant insert a new reocrd in that table '
select * from Departments

insert into Departments (Dname,dnum)
values ('dp4',40)

--3- Create a trigger on student table after 
--insert to add Row in a Student Audit table (Server User Name, Date, Note) 
--where the note will be “ username Insert New Row with Key=Id in table student”
create table student_audit_table
(
id_saudit int identity (1,1) primary key ,
server_user_name  varchar (100),
date_audit date ,
note varchar(255)
)


create or alter trigger add_column
on student 
after insert 
as
begin
insert into student_audit_table
(
server_user_name,
date_audit,
note
)
select 
St_Fname,
getdate(),
'New row instered into student table with id='+ cast(St_Id as varchar(10))'INS'
from inserted 
 
end
insert into Student (st_id,St_Fname,St_Lname,St_Age)
values (20,'Ahmed','ibrahim',25)
select * from student_audit_table

--4- Create a stored procedure that will be used in case there is an old 
--employee has left the project and a new one become instead of him. 
--The procedure should take 3 parameters (old Emp. SSN, new Emp. SSN and the project number) 
--and it will be used to update works_for table. (use exists)
create or alter proc new_old_emp
@old_emp_ssn varchar(100),
@new_emp_ssn varchar(100),
@project_number int 
as
begin
if exists (select * from employee where ssn=@new_emp_ssn )
begin 
update works_for 
set essn=@new_emp_ssn
where essn=@old_emp_ssn and pno=@project_number
end
else 
select ('not vaild')

end
select * from employee
 new_old_emp 669955,225588,300
select * from works_for
--5. Create an Audit table with the following structure ProjectNo
--NewThis table will be used to audit the update trials on the Hours 
--column (works_for table, Company DB)
--Example: If a user updated the Hours column then the project number,
--the user name that made that update, the date of the modification and
--the value of the old and the new Hours will be inserted into the Audit table
--Note: This process will take place only if the user updated the Hours column

use Company_SD
go
create  table audittt
(
projectno int  ,
username varchar(50),
modifieddate date,
hours_old int ,
hours_new int
)
create or alter trigger t10
on works_for 
after update 
as
if update (hours)
   begin
   declare @old int
   select @old= hours from deleted
   declare @new int
   select @new= hours from INSERTED  
   declare @pno int 
   select @pno=pno from works_for
   insert into audittt values(@pno,SUSER_NAME(),GETDATE(),@old,@new) 

   end
   update works_for
   set hours=14
   where pno=400
   select * from audittt
   select * from works_for

  --6. Create a trigger that prevents users from altering any table in Company DB.
  create or alter trigger t15
  on database

   for Alter_table
  as
  begin
  raiserror ('dont allow to this database daughter ',16,1)
  end

  alter table employee
  add email varchar(200)