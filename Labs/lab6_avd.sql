--1. Create login and user for iti DB on Student table allow user to make select for St_id, St_Fname 
--prevent user from Update

select st_fname,St_Id
from student 
update student 
set St_Lname='Ahmed'
where st_id=1
-------------------------------
--2. make login and user for Company DB on Schema that Includes ( View , Stored , Function )
select * 
from dbo.emp_num
--3. Return the result of this XML data as table (XML shredding(From XML To Table)) 

declare @mario xml =
'<book genre="VB" publicationdate="2010"> 
<title>Writing VB Code</title>
<author>
<firstname>ITI</firstname>
<lastname>ITI</lastname>
</author> 
<price>44.99</price> 
</book>'
declare @hmario int 
exec sp_xml_preparedocument @hmario output ,@mario
select * into Newtable3
from openxml(@hmario ,'//book')
with (genre varchar(50) '@genre',
      publicationdate date '@publicationdate',
      title varchar(50) 'title',
	  firstname varchar(50) 'author/firstname',
	  lastname varchar(50) 'author/lastname',
	  price float 'price')

--select * from NewTable1
Exec sp_xml_removedocument @hmario


select * from Newtable3

--4.Create a job that make all available types of backup Daily
BACKUP DATABASE iti
TO DISK = 'D:\my_db_backup.bak';