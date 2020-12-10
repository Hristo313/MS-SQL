USE SoftUni

--Exercise 4 Find Salary of Each Employee
SELECT FirstName, LastName, Salary 
FROM Employees

--Exercise 6 Find Email Address of Each Employee
SELECT CONCAT(FirstName, '.', LastName, '@', 'softuni.bg') AS [EmailAdrees]
FROM Employees

--Exercise 7 Find All Different Employee's Salaries
SELECT DISTINCT Salary 
FROM Employees

--Exercise 8 Find All Information About Employees
SELECT * 
FROM Employees
WHERE JobTitle = '.NET Developer'

--Exercise 9 Find Names of All Employees by Salary Range
SELECT FirstName, LastName, JobTitle 
FROM Employees 
WHERE Salary BETWEEN 2000 AND 3000

--Exercise 10 Find Names of All Employees
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name]
FROM Employees
WHERE Salary IN (2915.55, 1925.55)

--Exercise 11 Find All Emplyees Without Address
SELECT FirstName, LastName 
FROM Employees
WHERE AddressId IS NULL

--Exercise 12 Find All Employees Salary More Than 500
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 500
ORDER BY Salary DESC

--Exercise 13 Find 5 Best Paid Employees
SELECT TOP(5) FirstName, LastName 
FROM Employees
ORDER BY Salary DESC
--OFFSET 2 ROWS -- skip ? rows
--FETCH NEXT 1 ROWS ONLY -- gives next ? rows after skip

--Exercise 15 Sort Employees Table
SELECT * 
FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC

--Exercise 17 Create View Employees with Job Titles
CREATE VIEW V_EmployeeNameJobTitle
AS
(SELECT 
      CONCAT(FirstName, ' ', ISNULL(MiddleName, ''), ' ', LastName) AS [Full Name],
	  JobTitle
FROM Employees)

--Exercise 19 Find First 10 Hire Employees
SELECT TOP(10) * FROM Employees
ORDER BY HireDate ASC

--Exercise 20 Increase Salaries
UPDATE Employees
SET Salary += Salary * 0.12
WHERE DepartmentID IN (1, 4)

--Exercise 24* Case
SELECT *,
   CASE
       WHEN JobTitle = '.NET Developer' THEN 'DEV'
	   ELSE 'Not DEV'
   END AS [Currency]
FROM Employees
ORDER BY FirstName ASC