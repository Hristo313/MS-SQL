CREATE DATABASE Service

USE Service

--Exercise 1 DDL
CREATE TABLE Users(
   Id INT PRIMARY KEY IDENTITY,
   Username NVARCHAR(30) UNIQUE NOT NULL,
   [Name] NVARCHAR(50),
   [Password] NVARCHAR(50) NOT NULL,  
   Birthdate DATETIME,
   Age INT CHECK(Age BETWEEN 14 AND 110),
   Email NVARCHAR(50) NOT NULL
)

CREATE TABLE Departments(
   Id INT PRIMARY KEY IDENTITY,
   [Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees(
   Id INT PRIMARY KEY IDENTITY,
   FirstName NVARCHAR(25),
   LastName NVARCHAR(25),
   Age INT CHECK(Age BETWEEN 18 AND 110),
   Birthdate DATETIME,  
   DepartmentId INT REFERENCES Departments(Id)
)

CREATE TABLE Categories(
   Id INT PRIMARY KEY IDENTITY,
   [Name] NVARCHAR(50) NOT NULL,
   DepartmentId INT NOT NULL REFERENCES Departments(Id)
)

CREATE TABLE Status(
   Id INT PRIMARY KEY IDENTITY,
   [Label] NVARCHAR(30) NOT NULL
)

CREATE TABLE Reports(
   Id INT PRIMARY KEY IDENTITY,
   CategoryId INT NOT NULL REFERENCES Categories(Id),
   StatusId INT NOT NULL REFERENCES Status(Id),
   OpenDate DATETIME NOT NULL,
   CloseDate DATETIME,
   [Description] NVARCHAR(200) NOT NULL,
   UserId INT NOT NULL REFERENCES Users(Id),
   EmployeeId INT REFERENCES Employees(Id)
)

GO

-- Disable referential integrity
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO

EXEC sp_MSForEachTable 'DELETE FROM ?'
GO

EXEC sp_MSForEachTable 'DBCC CHECKIDENT(''?'', RESEED, 0)'
GO

-- Enable referential integrity 
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
GO

--INSERT Departments
SET IDENTITY_INSERT Departments ON;

INSERT INTO Departments(Id, Name)
VALUES(1, 'Infrastructure'), (2, 'Aged Care'), (3, 'Legal'), (4, 'Emergency'), (5, 'Roads Maintenance'), (6, 'Animals Care'), (7, 'Forestry Office'), (8, 'Property Management'), (9, 'Event Management'), (10, 'Environment');

SET IDENTITY_INSERT Departments OFF;


--INSERT Categories
SET IDENTITY_INSERT Categories ON;

INSERT INTO Categories(Id,
                       Name,
                       Departmentid)
VALUES(1, 'Snow Removal', 5), (2, 'Recycling', 10), (3, 'Water/Air Pollution', 10), (4, 'Streetlight', 1), (5, 'Illegal Construction', 8), (6, 'Sports Events', 9), (7, 'Homeless Elders', 2), (8, 'Disabled People', 2), (9, 'Art Events', 9), (10, 'Animal in Danger', 6), (11, 'Destroyed Home', 4), (12, 'Street animal', 6), (13, 'Music Events', 9), (14, 'Dangerous Building', 8), (15, 'Traffic Lights', 5), (16, 'Potholes', 5), (17, 'Green Areas', 7), (18, 'Dangerous Trees', 7);

SET IDENTITY_INSERT Categories OFF;

--INSERT Status
SET IDENTITY_INSERT [Status] ON;

INSERT INTO Status(Id,
                   Label)
VALUES(1, 'waiting'), (2, 'in progress'), (3, 'completed'), (4, 'blocked');

SET IDENTITY_INSERT [Status] OFF;

--INSERT Employees
SET IDENTITY_INSERT Employees ON;

INSERT INTO Employees(Id,
                      Firstname,
                      Lastname,
                      Age,
                      Birthdate,
                      DepartmentId)
VALUES(1, 'Marlo', 'O''Malley', 20, '9/21/1958', 1), (2, 'Nolan', 'Meneyer', 19, '4/29/1961', 6), (3, 'Tarah', 'McWaters', 18, '5/22/1954', 9), (4, 'Bernetta', 'Bigley', 25, '10/18/1979', 2), (5, 'Gregory', 'Stithe', 45, '6/25/1952', 5), (6, 'Bord', 'Hambleton', 33, NULL, 8), (7, 'Humphrey', 'Tamblyn', 18, '3/26/1941', 6), (8, 'Dinah', 'Zini', 26, '9/8/1950', 10), (9, 'Eustace', 'Sharpling', 26, '10/29/1956', 1), (10, 'Shannon', 'Partridge', 27, '2/14/1952', 1), (11, 'Nancey', 'Heintsch', 24, '8/20/1967', 3), (12, 'Niki', 'Stranaghan', 36, '11/26/1969', 9), (13, 'Dick', 'Wentworth', 35, '4/29/1983', 4), (14, 'Ives', 'McNeigh', 46, '11/15/1952', 1), (15, 'Leonardo', 'Shopcott', 56, '1/15/1939', 6), (16, 'Howard', 'Lovelady', 67, '6/6/1969', 5), (17, 'Bron', 'Ledur', 76, '11/26/1996', 10), (18, 'Adelind', 'Benns', 56, '11/23/1935', 10), (19, 'Imogen', 'Burnup', 33, '5/8/1952', 3), (20, 'Eldon', 'Gaze', 43, '8/24/1947', 5), (21, 'Patsy', 'McLenahan', 44, NULL, 10), (22, 'Jeane', 'Salisbury', 47, '9/13/1967', 5), (23, 'Tiena', 'Ritchard', 54, '4/18/1985', 3), (24, 'Hakim', 'Guilaem', 28, '4/9/1963', 9), (25, 'Corny', 'Pickthall', 19, '12/18/1979', 2), (26, 'Tam', 'Kornel', 20, '10/3/1995', 9), (27, 'Abby', 'Brettoner', 30, '4/16/1992', 9), (28, 'Galven', 'Moston', 40, '3/20/1945', 5), (29, 'Stefa', 'Jakubovski', 50, '1/10/1947', 2), (30, 'Hewet', 'Juschke', 20, '12/26/1997', 7);

SET IDENTITY_INSERT Employees OFF;

--INSERT Users
SET IDENTITY_INSERT Users ON;

INSERT INTO Users(Id,
                  Username,
                  Name,
			   Password,
                  BirthDate,
		        Age,
                  Email)
VALUES
(1, 'ealpine0', 'Erhart Alpine', 'b8eYD1a7R44', '07/07/1949', 68, 'ealpine0@squarespace.com'),
(2, 'awight1', 'Anitra Wight', 'hbHhuwBSxqeo', '05/31/1943', 74, 'awight1@artisteer.com'),
(3, 'fmacane2', 'Faustine MacAne', 'nhpbS3h2rfR', '11/19/1944', 73, 'fmacane2@is.gd'),
(4, 'fdenrico3', 'Florette D''Enrico', '0iMw1JpVk4', '10/26/1977', 40, 'fdenrico3@va.gov'),
(5, 'lrow4', 'Lindsey Row', 'neGBinke', '01/16/1934', 83, 'lrow4@netscape.com'),
(6, 'dfinicj5', 'NULL', '2GDReU', '05/20/1993', 24, 'shynson5@ihg.com'),
(7, 'llankham6', 'Lishe Lankham', 'ygNzd2f',  '11/05/1951', 66, 'llankham6@histats.com'),
(8, 'tmartensen7', 'Tawnya Martensen', 'KyFw9oA',  '11/21/1980', 37, 'tmartensen7@cornell.edu'),
(9, 'mgobbett8', 'Maud Gobbett', 'anv5ba2pvM',  '10/29/1958', 59, 'mgobbett8@dmoz.org'),
(10, 'vinglese9', 'Veronique Inglese', 'ZCJp511W',  '02/16/1962', 55, 'vinglese9@g.co'),
(11, 'mburdikina', 'Maggi Burdikin', 'MjXufd',  '04/23/1986', 31, 'mburdikina@boston.com'),
(12, 'varkwrightb', 'Vanni Arkwright', 'sWKjjlWE',  '02/29/1964', 53, '6varkwrightb@ucoz.com'),
(13, '5omarkwelleyc', 'Odette Markwelley', 'UfUE4pE', '05/23/1998', 19, 'omarkwelleyc@alibaba.com'),
(14, 'dpennid', 'Dorene Penni', 'rIBnJ77b', '09/07/1959', 58, 'dpennid@arizona.edu'),
(15, 'wkicke', 'Wileen Kick', '7bZQ3gntC',  '09/20/1962', 55, 'wkicke@disqus.com'),
(16, '1qiskowf', 'Quent Iskow', 'DCDiR6YTf8',  '12/18/1958', 59, 'qiskowf@opensource.org'),
(17, 'bkaasg', 'Brig Kaas', 'D1oonIJDX3G',  '07/13/1996', 21, 'bkaasg@g.co'),
(18, 'gdiaperh', 'Germaine Diaper', 'YM05Ya6Xpo7', '05/26/1939', 78, 'gdiaperh@nsw.gov.au'),
(19, '1eallibertoni', 'Emlynn Alliberton', 's8XQ0d7iv', '07/29/1972', 45, 'eallibertoni@slashdot.org'),
(20, 'jgreggorj', 'Jocko Greggor', 'H1J1AbJW4BEB',  '04/22/1981', 36, 'jgreggorj@whitehouse.gov');

SET IDENTITY_INSERT Users OFF;

--INSERT Reports
SET IDENTITY_INSERT Reports ON;

INSERT INTO Reports(Id,
                    CategoryId,
                    StatusId,
                    OpenDate,
                    CloseDate,
                    Description,
                    UserId,
                    EmployeeId)
VALUES
(1, 1, 4, '04/13/2017', NULL, 'Stuck Road on Str.14', 14, 5),
(2, 2, 3, '09/05/2015', '09/17/2015', '366 kg plastic for recycling.', 10, NULL),
(3, 1, 2, '01/03/2015', NULL, 'Stuck Road on Str.29', 4, 22),
(4, 11, 4, '12/06/2015', NULL, 'Burned facade on Str.183', 7, NULL),
(5, 4, 4, '11/17/2015', NULL, 'Fallen streetlight columns on Str.40', 3, NULL),
(6, 18, 1, '09/07/2015', NULL, 'Fallen Tree on the road on Str.26', 14, 30),
(7, 2, 2, '09/07/2017', NULL, 'High grass in Park Riversqaure', 10, 8),
(8, 18, 3, '04/23/2016', '05/01/2016', 'Fallen Tree on the road on Str.26', 11, NULL),
(9, 10, 4, '12/17/2014', NULL, 'Stuck Road on Str.65', 1, 15),
(10, 2, 4, '08/23/2015', NULL, '399 kg plastic for recycling.', 12, 17),
(11, 4, 3, '07/03/2017', '07/06/2017', 'Fallen streetlight columns on Str.41', 19, 14),
(12, 10, 3, '07/20/2016', '08/13/2016', 'Burned facade on Str.793', 7, 7),
(13, 1, 2, '01/26/2016', NULL, '246 kg plastic for recycling.', 16, 20),
(14, 12, 1, '06/09/2016', NULL, 'Aggressive monkey corner of Str.36 and Str.92', 20, NULL),
(15, 1, 4, '06/20/2015', NULL, 'Stuck Road on Str.133', 17, NULL),
(16, 6, 1, '10/09/2015', NULL, 'Stuck Road on Str.66', 18, 24),
(17, 11, 4, '08/26/2015', NULL, 'Burned facade on Str.560', 14, NULL),
(18, 6, 4, '10/24/2014', NULL, '86 kg plastic for recycling.', 10, 24),
(19, 11, 4, '01/14/2016', NULL, '39 kg plastic for recycling.', 6, 13),
(20, 16, 1, '07/02/2016', NULL, 'Gigantic crater ?n Str.48', 3, NULL),
(21, 2, 4, '03/31/2015', NULL, 'High grass in Park Riversqaure', 14, 17),
(22, 14, 1, '05/15/2016', NULL, 'Falling bricks on Str.17', 14, NULL),
(23, 2, 3, '07/24/2017', '07/27/2017', 'Stuck Road on Str.8', 16, 18),
(24, 1, 3, '05/23/2015', '05/19/2016', 'Stuck Road on Str.123', 13, 16),
(25, 17, 1, '01/11/2016', NULL, '162 kg plastic for recycling.', 19, 30),
(26, 10, 2, '11/10/2016', '11/20/2016', 'Parked car on green area on the sidewalk of Str.74', 20, 15),
(27, 9, 2, '12/17/2014', NULL, 'Art exhibition on July 24', 8, NULL),
(28, 2, 4, '07/12/2017', NULL, 'Stuck Road on Str.13', 2, 18),
(29, 14, 3, '09/25/2015', '10/12/2016', 'Falling bricks on Str.38', 12, 13),
(30, 3, 4, '08/02/2016', NULL, 'Extreme increase in nitrogen dioxide at Litchfield', 4, NULL),
(31, 4, 4, '09/12/2017', NULL, 'Fallen streetlight columns on Str.14', 1, 1),
(32, 6, 3, '06/08/2015', '06/13/2015', 'Sky Run competition on September 8', 19, 12),
(33, 16, 2, '11/17/2015', NULL, 'Gigantic crater ?n Str.19', 1, NULL),
(34, 2, 4, '07/10/2017', NULL, 'Glass Bottles for recycling on Str.105', 5, NULL),
(35, 2, 1, '02/06/2017', NULL, 'Glass Bottles for recycling on Str.28', 5, NULL),
(36, 4, 2, '01/01/2016', NULL, 'Fallen streetlight columns on Str.15', 18, NULL),
(37, 5, 1, '08/28/2017', NULL, 'Glass Bottles for recycling on Str.150', 13, 17),
(38, 7, 2, '02/27/2016', NULL, 'Lonely child on corner of Str.3 and Str.30', 16, NULL),
(39, 9, 1, '02/11/2016', NULL, 'Glass Bottles for recycling on Str.116', 10, NULL),
(40, 7, 1, '11/05/2015', NULL, 'Lonely child on corner of Str.1 and Str.19', 7, 25);

SET IDENTITY_INSERT Reports OFF;

--Exercise 2 Insert
INSERT INTO Employees(FirstName, LastName, Birthdate, DepartmentId)
VALUES
('Marlo', 'O''Malley', '09-21-1958', 1),
('Niki', 'Stranaghan', '11-26-1969', 4),
('Ayrton', 'Senna', '03-21-1960', 9),
('Ronnie', 'Peterson', '02-14-1944', 9),
('Giovanna', 'Amati', '07-20-1959', 5)

INSERT INTO Reports(CategoryId, StatusId, OpenDate, CloseDate, [Description], UserId, EmployeeId)
VALUES
(1, 1, '04-13-2017', NULL, 'Stuck Road on Str.133', 6, 2),
(6, 3, '09-05-2015', '12-06-2015', 'Charity trail running', 3, 5),
(14, 2, '09-07-2015', NULL, 'Falling bricks on Str.58', 5, 2),
(4, 3, '07-03-2017', '07-06-2017', 'Cut off streetlight on Str.11', 1, 1)

--Exercise 3 Update
UPDATE Reports SET CloseDate = GETDATE()
WHERE CloseDate IS NULL

--Exercise 4 Delete
DELETE FROM Reports
WHERE StatusId = 4

--Exercise 5 Unassigned Reports
SELECT [Description], FORMAT(OpenDate, 'dd-MM-yyyy') AS OpenDate
FROM Reports AS r
WHERE EmployeeId IS NULL
ORDER BY r.OpenDate, [Description]

--Exercise 6 Reports & Categories
SELECT r.[Description], c.[Name] AS CategoryName
FROM Reports AS r
JOIN Categories AS c 
ON c.Id = r.CategoryId
ORDER BY [Description], CategoryName

--Exercise 7 Most Reported Category
SELECT TOP(5) c.[Name] AS CategoryName, COUNT(*) AS ReportsNumber
FROM Reports AS r
JOIN Categories AS c 
ON c.Id = r.CategoryId
GROUP BY CategoryId, c.[Name]
ORDER BY ReportsNumber DESC, [Name] 

--Exercise 8 Birthday Report
SELECT Username, c.[Name] AS CategoryName
FROM Reports AS r
JOIN Users AS u 
ON u.Id = r.UserId
JOIN Categories AS c 
ON C.Id = r.CategoryId
WHERE 
      DATEPART(month, r.OpenDate) = DATEPART(month, u.Birthdate) 
	  AND 
	  DATEPART(day, r.OpenDate) = DATEPART(day, u.Birthdate) 
ORDER BY Username, CategoryName

--Exercise 9 Users per Employee
SELECT 
       CONCAT(FirstName, ' ', LastName) AS FullName,
       COUNT(DISTINCT UserId) AS UsersCount
FROM Reports AS r
RIGHT JOIN Employees AS e 
ON e.Id = r.EmployeeId
GROUP BY EmployeeId, FirstName, LastName
ORDER BY UsersCount DESC, FullName

-- Exercise 10 Full Info
SELECT ISNULL(e.FirstName + ' ' + e.LastName, 'None') AS Employee,
       ISNULL(d.[Name], 'None') AS Department,
	   ISNULL(c.[Name], 'None') AS Category,
	   r.[Description],
	   FORMAT(r.OpenDate, 'dd.MM.yyyy') AS OpenDate,
	   r.Opendate,
	   s.[Label] AS [Status],
	   ISNULL(u.[Name], 'None') AS [User]
FROM Reports AS r
LEFT JOIN Employees AS e ON e.Id = r.EmployeeId
LEFT JOIN Categories AS c ON c.Id = r.CategoryId
LEFT JOIN Departments AS d ON d.Id = e.DepartmentId
LEFT JOIN Status AS s ON s.Id = r.StatusId
LEFT JOIN Users AS u ON u.Id = r.UserId
ORDER BY FirstName DESC,
         LastName DESC,
         d.[Name], 
		 c.[Name],
         r.[Description],
		 r.OpenDate,
		 s.[Label],
		 u.Username

--Exercise 11 Hours to Complete
GO

CREATE OR ALTER FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
    IF(@StartDate IS NULL) RETURN 0;
	IF(@EndDate IS NULL) RETURN 0;
    RETURN DATEDIFF(hour, @Startdate, @EndDate)
END

--Exercise 12 Assign Employee
GO

CREATE OR ALTER PROCEDURE usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
AS
    DECLARE @EmployeeDepartmentId INT = 
	                                    (SELECT DepartmentId
	                                     FROM Employees
										 WHERE Id = @EmployeeId);
    DECLARE @ReportDepartmentId INT = 
	                                    (SELECT c.DepartmentId
	                                     FROM Reports AS r
										 JOIN Categories AS c 
										 ON c.Id = r.CategoryId
										 WHERE r.Id = @ReportId);

    IF(@EmployeeDepartmentId != @ReportDepartmentId)	
	  THROW 50000, 'Employee doesn''t belong to the appropriate department!', 1

    UPDATE Reports 
	    SET EmployeeId = @EmployeeId
		WHERE Id = @ReportId
GO

EXECUTE usp_AssignEmployeeToReport 30, 1
EXECUTE usp_AssignEmployeeToReport 17, 2