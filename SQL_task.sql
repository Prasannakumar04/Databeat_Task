-- 1. Write a SQL query to create these tables in your database with the following characteristics:
-- i. Add the primary key “Emp_ID” to the Employees Table.
-- ii. Add foreign key “EMP_REF_ID” in Variables Details and Designation Table and Salary Updation Table that references “Emp_ID” in Employees Table

CREATE TABLE Employees(
    EMP_ID integer PRIMARY KEY,
    FIRST_NAME varchar,
    LAST_NAME varchar,
    SALARY integer,
    JOINING_DATE date,
    DEPARTMENT char
    )
    
CREATE TABLE Variables_Details(
    EMP_REF_ID integer FORIEGN KEY REFERENCES Employees(EMP_ID),
    VARIABLES_DATE date,
    VARIABLES_AMOUNT int
    )

CREATE TABLE Designation(
    EMP_REF_ID integer FORIEGN KEY REFERENCES Employees(EMP_ID),
    EMP_TITLE varchar,
    AFFECTED_FROM date
    )
    
CREATE TABLE Salary_Updation(
    EMP_REF_ID integer FORIEGN KEY REFERENCES Employees(EMP_ID),
    SALARY INT,
    JOINING_DATE date,
    Project varchar
    )
    
-- 2. Write a query to get the employee details(full name and department) who received the highest and the least variables.
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT FROM Employees,Variables_Details WHERE VARIABLES_AMOUNT=(SELECT MAX(VARIABLES_AMOUNT) FROM Variables_Details)
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT FROM Employees,Variables_Details WHERE VARIABLES_AMOUNT=(SELECT MIN(VARIABLES_AMOUNT) FROM Variables_Details)

-- 3. Create an empty table with the same structure as the Employees table
CREATE TABLE Employee_Clones AS SELECT * FROM Employees WHERE 1=2

-- 4. Write a query to get the designation that has got the highest and second lowest amount (salary + variables) for the whole year of 2019. Get the corresponding amount values.
-- Maximum 
SELECT EMP_TITLE FROM Designation,Variables_Details,Employees WHERE (SELECT MAX(SALARY+VARIABLES_AMOUNT) FROM Salary_Updation, Variables_Details)
-- Second Maximum
SELECT EMP_TITLE FROM Designation,Variables_Details,Employees WHERE (SALARY+VARIABLES_AMOUNT)<(SELECT MAX(SALARY+VARIABLES_AMOUNT) FROM Salary_Updation, Variables_Details )

-- 5. Write a query to fetch the EmpIds that are present in Employees but not in Salary Updation.
SELECT EMP_ID FROM Employees WHERE EMP_ID NOT IN (SELECT EMP_REF_ID FROM Salary_Updation)

-- 6. Write a query to fetch only the odd rows from the Employees table.
SELECT * FROM Employees WHERE EMP_ID%2<>0 --When Employee ID is unique and works as a row number

-- 7. Write a query to get the most recent salary for each employee. The resultant table should contain EmployeeID, RecentSalary, and Date columns.
SELECT EMP_ID,SALARY,JOINING_DATE FROM Employees WHERE JOINING_DATE IN (SELECT MAX(JOINING_DATE) FROM Employees GROUP BY EMP_ID ) GROUP BY EMP_ID;

-- 8. Write a query to fetch the Employee details who are not working on any project.
SELECT * FROM Employees, Salary_Updation WHERE Project IS NULL

-- 9. Write a query to perform a cross join on the Employees table and Designation table.
SELECT * FROM Employees CROSS JOIN Designation

-- 10. Write a query to get the employee details who got their designations updated in the second half of the year 2019(July to December), sorted by the “variables_amount” (highest to lowest) where the department name of the Employee has the letter ‘A’ in it.
SELECT * from Employees,Variables_Details where joining_date between '01-07-2019' and '31-12-2019' AND DEPARTMENT like '%A%' order by VARIABLES_AMOUNT desc
