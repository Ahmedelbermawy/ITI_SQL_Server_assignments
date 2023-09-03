--1. Display all the data from the Employee table as an XML document “Use XML Raw”. 
--Use company DB A) Elements B) Attributes
USE Company_SD
GO 
SELECT * FROM employee 
FOR XML RAW ('employee'),ELEMENTS,ROOT('employees')


--2. Display Each Department Name with its instructors. 
--“Use ITI DB” A) Use XML Raw B) Use XML Auto C) Use XML Path
USE ITI_new
GO 
SELECT dept_name,Ins_name
FROM Department d JOIN Instructor i
ON d.Dept_Id = i.Dept_Id
--FOR XML RAW 
--FOR XML AUTO 
--FOR XML PATH 
-----------------
USE Company_SD
GO 

/*3. Use the following variable to create a new table “customers” inside the company DB. Use OpenXML
declare @docs xml ='<customers>
<customer FirstName="Bob" Zipcode="91126"> <order ID="12221">Laptop</order>
</customer>
<customer FirstName="Judy" Zipcode="23235"> <order ID="12221">Workstation</order>
</customer>
<customer FirstName="Howard" Zipcode="20009"> <order ID="3331122">Laptop</order>
</customer>
<customer FirstName="Mary" Zipcode="12345"> <order ID="555555">Server</order>
</customer> </customers>'
*/
declare @docs xml =
'<customers>
<customer FirstName="Bob" Zipcode="91126"> 
           <order ID="12221">Laptop</order>
</customer>

<customer FirstName="Judy" Zipcode="23235"> 
           <order ID="12221">Workstation</order>
</customer>
<customer FirstName="Howard" Zipcode="20009"> 
           <order ID="3331122">Laptop</order>
</customer>
<customer FirstName="Mary" Zipcode="12345"> 
           <order ID="555555">Server</order>
</customer> 
</customers>'
declare @hdocs INT
Exec sp_xml_preparedocument @hdocs output, @docs

select * into NewTable
FROM OPENXML (@hdocs, '//customer')  --levels  XPATH Code
WITH (StudentID int '@order ID',
	  [Address] varchar(10) 'Address', 
	  coustomerFirst varchar(10) 'customer firstName/First',
	 customerECOND varchar(10) 'customer firstName/Second'
	  )
SELECT * FROM NewTable nt


--4
declare c1 cursor 
for 
    select i.Salary
    from Instructor i
for update 
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS =0
    begin 
	     if @sal >=3000
		   update Instructor set Salary = @sal+@sal*0.2
		   where current of c1 

		else
		  update Instructor set Salary = @sal+@sal*0.1
		  where current of c1 

    fetch c1 into @sal
	end 
	close c1 
	deallocate c1