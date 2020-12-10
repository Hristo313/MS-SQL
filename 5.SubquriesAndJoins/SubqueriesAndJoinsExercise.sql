USE SoftUni

--Exercise 1 Employee Address
SELECT e.Id, e.JobTitle, e.AddressId, a.AddressText
FROM Employees AS e
JOIN Addresses AS a 
ON e.AddressId = a.Id
ORDER BY e.AddressId ASC

--Exercise 2 Addresses with Towns
SELECT TOP(50) e.FirstName, e.LastName, t.[Name], a.AddressText 
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressId = a.Id
JOIN Towns AS t
ON a.TownId = t.Id
ORDER BY e.FirstName, e.LastName

--Exercise 5 Employees Without Project
SELECT TOP(3) e.Id, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.Id = ep.EmployeeId
WHERE ep.ProjectId IS NULL
ORDER BY e.Id 

--Exercise 7 Employees with Project
SELECT TOP(5) e.Id, e.FirstName, p.[Name]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.Id = ep.EmployeeId
JOIN Projects AS p
ON ep.ProjectIs = p.ProjectId
WHERE p.StartDate > '08.13.2002' AND p.EndDate IS NULL
ORDER BY e.Id

--Exercise 8 Employee 24
SELECT e.Id, e.FirstName, 
   CASE
       WHEN YEAR(StartDate) >= 2005 THEN NULL
	   ELSE p.[Name]
   END AS [ProjectName]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.Id = ep.EmployeeId
JOIN Projects AS p
ON ep.ProjectIs = p.ProjectId
WHERE e.Id = 24
ORDER BY e.Id

--Exercise 10 Employee Summary
SELECT TOP(50) e1.Id, 
       CONCAT(e1.FirstName, ' ', e1.LastName) AS [EmployeeName],
	   CONCAT(e2.FirstName, ' ', e2.LastName) AS [ManagerName],
	   d.[Name] AS [DepartmentName]
FROM Employees AS e1
LEFT JOIN Employees AS e2
ON e1.ManagerId = e2.Id
JOIN Departments AS d
ON e1.DepartmentId = d.Id
ORDER BY e1.Id

--Exercise 11 Min Avarage Salary
SELECT MIN([Average Salary]) AS [MinAverageSalary]
FROM (SELECT DepartmentId, AVG(Salary) AS [Average Salary]
      FROM Employees
      GROUP BY DepartmentId) AS [AverageSalaryQuery]