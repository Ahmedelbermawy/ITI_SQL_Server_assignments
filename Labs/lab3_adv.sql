use ITI_new
go 
--1. Identifying the Top Instructors by Average Evaluation Score:  Run these queries first: 
--alter table Ins_Course add evaluation_int int update Ins_Course set evaluation_int =100 where evaluation='Good' update Ins_Course set evaluation_int =200 where evaluation='VGood' update Ins_Course set evaluation_int =400 where evaluation='Distinct'
--Use the "Ins_Course" table to calculate the average evaluation score for each instructor.
--Rank the instructors based on their average evaluation scores and identify the top instructors with the highest scores.

alter table ins_course 
add evaluation_int int 
update ins_course 
set evaluation_int=100
where evaluation='good'

update ins_course 
set evaluation_int =200
where evaluation='vgood'

update ins_course 
set evaluation_int =400
where evaluation='Distinct'

--select evaluation_int from Ins_Course
with cte 
as
(
select ins_name ,avg(Evaluation_int) as avg_ev
from Instructor i join Ins_Course c
on i.Ins_Id=c.Ins_Id 
group by Ins_Name
)
select ins_name,avg_ev ,Dense_rank()over(order by avg_ev desc) as rank_i
from cte 
order by avg_ev desc

--2. Identifying the Top Topics by the Number of Courses:
-- Use the "Topic" and "Course" tables to count the number of courses available for each topic.
-- Rank the topics based on the count of courses and identify the most popular topics with the highest number of courses.

with cte 
as
(
select Crs_Name,count(crs_id)over (partition by top_name) as count_topic
from Topic t  join course c
on t.Top_Id=c.Top_Id
)
select crs_name,count_topic,rank () over (order by count_topic desc) as high_num_of_hours
from cte 


--3. Finding Students with the Highest Overall Grades:
--Use the "Stud_Course" table to calculate the total grades for each student across all courses.
-- Rank the students based on their total grades and identify the students with the highest overall grades.

with cte 
as
(
select distinct concat(st_fname,'',st_lname)as fullname 
,sum (Grade)over (partition by concat(st_fname,'',st_lname) ) as total_grades
from student s join stud_course sc
on s.st_id= sc.st_id
)
select *,rank() over(order by total_grades desc) as high_overall_grades 
from cte 
--select grade from Stud_Course
--------------------------company_sD---------------------------------

use Company_SD
go 

--1. Employee Ranking within Departments: Challenge:
--You want to rank employees within each department based on their salaries

select concat (fname,'',lname) as fullname,Dname,salary,rank()over(partition by dname order by salary desc) as rank_salary 
from employee e join Departments d
on e.dno=d.Dnum

--2. Employee Ranking by Project Contributions: Challenge: 
--You want to rank employees based on the number of hours they worked on each project.
select concat (fname,'',lname) as fullname ,sum(Hours) as sum_h,dense_rank () over ( order by sum(hours) desc) as num_of_hours
from employee e join Works_for w
on e.SSN=w.ESSn join project p
on w.Pno=p.Pnumber
group by concat (fname,'',lname) 
--3-Project Ranking by Employee Contributions: Challenge: 
--You want to rank projects based on the total number of hours worked on each project
select pname,pnumber,sum(hours) as sum_h,rank() over(order by sum(hours) )as hours_rk 
from project p join  Works_for w
on w.pno=p.Pnumber
group by Pname,Pnumber
--4. Department Ranking by Project Count: Challenge:
--You want to rank departments based on the number of projects they have.
select d.Dname ,count(pnumber) as count_num,rank() over (order by count(pnumber)) as orders 
from project p join Departments d 
on p.Dnum= d.Dnum
group by d.Dname
--5-Employee Age Ranking: Challenge: 
--You want to rank employees based on their ages.
select concat (fname,'',lname) as fullname ,(year(getdate())-(year(Bdate))) as age ,rank() over(order by (year(getdate())-(year(Bdate)))desc) as age_o
from employee 
----------------------
