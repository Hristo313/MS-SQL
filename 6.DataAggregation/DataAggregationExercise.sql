USE Gringotts

--Exercise 3 Longest Magic Wand Per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits
GROUP BY DepositGroup

--Exercise 4 Smallest Deposit Group Per Magic Wand Size*
SELECT TOP(2) DepositGroup FROM (
               SELECT DepositGroup, AVG(MagicWandSize) AS [AverageWandSize]
               FROM WizzardDeposits
               GROUP BY DepositGroup) AS [AverageWandSizeQuery]
ORDER BY [AverageWandSize]

--Exercise 5 Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY DepositGroup

--Exercise 6 Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander Family'
GROUP BY DepositGroup

--Exercise 7 Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander Family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY [TotalSum] DESC

--Exercise 9 Age Groups
SELECT AgeGroup, COUNT(*) AS [WizzardsCount]
FROM (SELECT 
     CASE
	      WHEN Age <= 10 THEN '[0-10]'
		  WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
		  WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
		  WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
		  WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
		  WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
		  ELSE '[61+]'
	 END AS [AgeGroup]
FROM WizzardDeposits) AS [AgeGroupQuary]
GROUP BY [AgeGroup]

--Exercise 11 Average Interest
SELECT DepositGroup, 
       IsDepositExpired,
	   AVG(DepositInterest) AS [AverageInterest]
FROM WizzardDeposits
WHERE DepositStartDate > '01/01/1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

--Exercise 12 Rich Wizard, Poor Wizard*
SELECT SUM([Difference]) AS [SumDifference] 
FROM (SELECT FirstName AS [Host Wizzard],
       DepositAmount AS [Host Wizzard Deposit],
	   LEAD(FirstName) OVER(ORDER BY Id ASC) AS [Guest Wizzard], -- LEAD returns the value of the next line
	   LEAD(DepositAmount) OVER(ORDER BY Id ASC) AS [Guest Wizzard Deposit],
	   DepositAmount -  LEAD(DepositAmount) OVER(ORDER BY Id ASC) AS [Difference]
FROM WizzardDeposits) AS [LeadQuery]

--Exercise 15 Employees Average Salaries
USE SoftUni

SELECT * INTO EmployeesWithHightSalaries
FROM Employees
WHERE Salary > 3000

DELETE FROM EmployeesWithHightSalaries
WHERE DepartmentId = 2

UPDATE EmployeesWithHightSalaries
SET Salary += 5000
WHERE DepartmentId = 4

SELECT DepartmentId, AVG(Salary) AS [AverageSalary] 
FROM EmployeesWithHightSalaries
GROUP BY DepartmentId

--Exercise 18 1st Highest Salary*
SELECT DepartmentId,
       Salary AS [HighestSalary]
FROM (SELECT DISTINCT DepartmentId,
             Salary,
             DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) AS [SalaryRank]
      FROM Employees) AS [SalaryRankingsQuery]	 
WHERE SalaryRank = 1

--Exercise 19 Salary Challenge**
SELECT TOP(10) e1.FirstName,
       e1.LastName,
	   e1.DepartmentId
FROM Employees AS e1
WHERE e1.Salary > (SELECT AVG(Salary) AS [AverageSalary]
                   FROM Employees AS e2
				   WHERE e2.DepartmentId = e1.DepartmentId
                   GROUP BY DepartmentId)
ORDER BY DepartmentId