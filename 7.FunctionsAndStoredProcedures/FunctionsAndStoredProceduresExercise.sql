USE SoftUni

--Exercise 1 Employees with Salary Above 35000
GO

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
    SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
GO

EXECUTE usp_GetEmployeesSalaryAbove35000

--Exercise 2 Employees with Salary Above Number
GO

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber(@minSalary DECIMAL(18,4))
AS
    SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @minSalary
GO

EXECUTE usp_GetEmployeesSalaryAboveNumber 3000

--Exercise 4 Employees from Town
GO

CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown(@townName VARCHAR(50))
AS
   SELECT * FROM Employees AS e
   JOIN Addresses AS a
   ON e.AddressId = a.Id
   JOIN Towns AS t
   ON a.TownId = t.Id
   WHERE t.[Name] = @townName
GO

EXECUTE usp_GetEmployeesFromTown 'Plovdiv'

--Exercise 5 Salary Level Function
GO

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(7)
AS
BEGIN
    DECLARE @salaryLevel VARCHAR(7);

	IF (@salary < 30000)
	BEGIN
	    SET @salaryLevel = 'Low';
	END
	ELSE IF (@salary >= 30000 AND @salary <= 50000)
	BEGIN
	     SET @salaryLevel = 'Average';
	END
	ELSE 
	BEGIN
	     SET @salaryLevel = 'High';
	END

	RETURN @salaryLevel;
END

GO

SELECT FirstName,
       LastName, 
       dbo.ufn_GetSalaryLevel(Salary) AS [SalaryLevel]
FROM Employees

--Exercise 6 Employees by Salary Level
GO

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel(@salaryLevel VARCHAR(7))
AS
   SELECT FirstName, LastName
   FROM Employees
   WHERE dbo.ufn_GetSalaryLevel(Salary) = @salaryLevel;
GO

EXECUTE usp_EmployeesBySalaryLevel 'High'

--Exercise 7 Define Function
GO

CREATE OR ALTER FUNCTION ufn_IsWorldComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
    DECLARE @i INT = 1;
	
	WHILE (@i <= LEN(@word))
	BEGIN
	    DECLARE @currChar CHAR = SUBSTRING(@word, @i, 1);
		DECLARE @charIndex INT = CHARINDEX (@currChar, @setOfLetters);

		IF (@charIndex = 0)
		BEGIN
		    RETURN 0;
		END
		
		SET @i += 1;
	END

	RETURN 1;
END

GO

SELECT dbo.ufn_IsWorldComprised('oistmiahf', 'Sofia')

--Exercise 8 Delete Employees and Departments*
GO

CREATE OR ALTER PROCEDURE usp_DeleteEmployeesFromDepartment(@departmentId INT)
AS
   --First delete all records from EmployeesProjects where EmployeeId is in to-be-deleted Id's
   DELETE FROM EmployeesProjects
   WHERE EmployeeId IN (
                        SELECT Id FROM Employees
			            WHERE DepartmentId = @departmentId
                        )
   --Set ManagerId to NULL where Manager is an Employee who is going to be deleted (for Employees)
   UPDATE Employees
   SET ManagerId IN (
                      SELECT Id FROM Employees
			          WHERE DepartmentId = @departmentId
                      )
   --Alter column ManagerId in Department Table and make it nullable
   ALTER TABLE Departments
   ALTER COLUMN ManagerId INT

   --Set ManagerId to NULL where Manager is an Employee who is going to e deleted (for departments)
   UPDATE Departments
   SET ManagerId = NULL
   WHERE ManagerId IN (
                      SELECT Id FROM Employees
			          WHERE DepartmentId = @departmentId
                      )
   DELETE FROM Departments
   WHERE Id = @departmentId

   SELECT COUNT(*)
   FROM Employees
   WHERE DepartmentId = @departmentId
GO

EXECUTE usp_DeleteEmployeesFromDepartment 2