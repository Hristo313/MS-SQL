CREATE DATABASE Minions

USE Minions

--Exercise 2 Create Tables
CREATE TABLE Minions
(Id INT NOT NULL, 
[Name] NVARCHAR(50) NOT NULL,
Age INT NOT NULL,
)

CREATE TABLE Towns
(
Id INT NOT NULL,
[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions
ADD CONSTRAINT PK_Id
PRIMARY KEY(Id)

ALTER TABLE Towns
ADD CONSTRAINT PK_TownId
PRIMARY KEY(Id)

--Exercise 3 Alter Minion Table
ALTER TABLE Minions 
ADD TownId INT

ALTER TABLE Minions
ADD CONSTRAINT FK_MinionTownId
FOREIGN KEY(TownId) REFERENCES Towns(Id)

--Exercise 4 Insert Records in Both Tables
INSERT INTO Towns(Id, [Name]) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions(Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

SELECT [Id] AS MinionId, [Name], [Age], [TownId] FROM Minions

--Exercise 5 Truncate Table Minions
TRUNCATE TABLE Minions --Delete the data in the table

--Exercise 6 Drop All Tables
DROP TABLE Minions --Delete the table 
DROP TABLE Towns

--Exercise 7 Create Table People
USE Minions

CREATE TABLE People(
    Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	CHECK(DATALENGTH(Picture) <= 2 * 1024 * 1024),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

--Exercise 8 Create Table Users
USE Minions

CREATE TABLE Users(
    Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	CHECK(DATALENGTH(ProfilePicture) <= 921600),
	LastLoginTime DATETIME2,
	IsDeleted BIT NOT NULL
)

INSERT INTO Users
(Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
VALUES
('Pesho', '123', NULL, NULL, 0),
('Gosho', '123', NULL, NULL, 0),
('Ivan', '123', NULL, NULL, 0),
('Test', '123', NULL, NULL, 0),
('Test123', '123', NULL, NULL, 0)

--Exercise 9 Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07E2303E6F

ALTER TABLE Users
ADD CONSTRAINT PK_CompositeIdUsername
PRIMARY KEY(Id, Username)

--Exercise 10 Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT [Password] 
CHECK([Password] >= 5)

--Exercise 11 Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users
(Username, [Password], ProfilePicture, IsDeleted)
VALUES
('Testttttt', '123', NULL, 1)

--Exercise 12 Set Unique Field
ALTER TABLE Users
DROP CONSTRAINT UQ__Users__536C85E43D352A2F

ALTER TABLE Users
ADD CONSTRAINT Username
CHECK(LEN(Username) >= 3)

-- Exercise 16 Create SoftUni Database
CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns(
  Id INT PRIMARY KEY IDENTITY,
  [Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Addresses(
    Id INT PRIMARY KEY IDENTITY,
    AddressText NVARCHAR(100) NOT NULL,
    TownId INT FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE Employees(
    Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50), 
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate DATE NOT NULL,
	Salary DECIMAL(8, 2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

--Exercise 18 Basic Insert
INSERT INTO Towns([Name]) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments([Name]) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Quality Assurance')

INSERT INTO Employees
            (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Pesho', 'Peshov', 'Peshov', '.NET Developer', 4, '02/01/2023', 3550.50),
('Gosho', 'Goshov', 'Goshov', 'Senior Engineer', 1, '03/02/2004', 1750.50),
('Tisho', 'Tishov', 'Tishov', 'Intern', 4, '08/28/2016', 2650.50)

--Exercise 19 Select All Fields
SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

--Exercise 20 Basic Select All Fields and Order Them
SELECT * FROM Towns
ORDER BY [Name] ASC

SELECT * FROM Departments
ORDER BY [Name] ASC

SELECT TOP(1) * FROM Employees
ORDER BY Salary DESC

--Exercise 21 Basic Select Some Fields
SELECT [Name] FROM Towns
ORDER BY [Name] ASC

SELECT [Name] FROM Departments
ORDER BY [Name] ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--Exercise 22 Increase Employees Salary
UPDATE Employees
SET Salary += Salary * 0.1

SELECT Salary FROM Employees