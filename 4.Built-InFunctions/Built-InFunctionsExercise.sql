USE SoftUni

--Exercise 1 Find Names of All Employees by First Name
SELECT FirstName, LastName 
FROM Employees
WHERE FirstName LiKE 'Ti%'

--Exercise 2 Find Names of All Employees by Last Name
SELECT FirstName, LastName 
FROM Employees
WHERE LastName LIKE '%ov'

--Exercise 3 Find First Names of All Employees
SELECT FirstName
FROM Employees
WHERE DepartmentID IN (1,4) 
      AND
      YEAR(HireDate) BETWEEN 1995 AND 2005

--Exercise 4 Find All Employees Except Engeneers
SELECT FirstName, LastName 
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--Exercise 5 Find Towns with Name Length
SELECT [Name]
FROM Towns
WHERE LEN([Name]) IN (5,6)
ORDER BY [Name] ASC

--Exercise 6 Find Towns Starting With
SELECT *
FROM Towns
WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'P')
ORDER BY [Name] ASC

--Exercise 7 Find Towns Not Starting With
SELECT *
FROM Towns
WHERE [Name] LIKE '[^RBD]%'
ORDER BY [Name] ASC

--Exercise 10 Rank Employees by Salary
SELECT Id, FirstName, Salary , DENSE_RANK() OVER (PARTITION BY Salary ORDER BY Id) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 1000 AND 5000
ORDER BY Salary DESC

--Exercise 11 Find All Employees with Rank 1*
SELECT * 
       FROM
      (SELECT Id, FirstName, Salary , DENSE_RANK() OVER (PARTITION BY Salary ORDER BY Id) AS [Rank]
       FROM Employees
       WHERE Salary BETWEEN 1000 AND 5000) AS Rank_Table
WHERE [Rank] = 1
ORDER BY Salary DESC

--Exercise 12 Towns Holding 'A' 3 or More Times
SELECT [Name]
FROM Towns
WHERE [Name] LIKE '%a%a%a%'
ORDER BY [Name] ASC

--Exercise 13 Mix of Students and Exams Names
USE EntityRelations

SELECT s.[Name], e.[Name], LOWER(CONCAT(s.[Name],SUBSTRING(e.[Name], 2, LEN(e.[Name])))) AS [Mix]
FROM Students AS s, Exams AS e
WHERE RIGHT(s.[Name],1) = LEFT(e.[Name],1)
ORDER BY [Mix]

--Exercise 14 Games from 2011 and 2012 year
SELECT TOP(50) [Name],FORMAT(EstablishedOn, 'yyyy-MM-dd') AS EstablishedOn
FROM Manufacturers
WHERE YEAR(EstablishedOn) IN (1966,2003)
ORDER BY EstablishedOn, [Name]