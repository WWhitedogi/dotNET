USE Northwind
GO 

-- SELECT statement: identify which columns we want to retrieve
-- 1. SELECT all columns and rows 
SELECT * FROM Employees

-- 2. SELECT a list of columns
SELECT EmployeeId, LastName, FirstName, Title, ReportsTo
FROM Employees

-- IMPORTANT: 
-- Avoid using *
-- 1) unecessary data 
-- 2) naming conflicts 
-- 3) performance issue

-- JOIN
-- INNER JOIN: Tselects records that have matching values in both tables.
-- OUTER JOIN -> LEFT JOIN , RIGHT JOIN, FULL JOIN
-- LEFT JOIN: returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
-- RIGHT JOIN: returns all records from the right table (table1), and the matching records from the left table (table2). The result is 0 records from the left side, if there is no match.
-- FULL (OUTER) JOIN : returns all records when there is a match in left (table1) or right (table2) table records.
SELECT *
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers s ON o.CustomerID = s.CustomerID

-- SELECT DISTINCT Value: list all the cities that employees located at
SELECT DISTINCT City
FROM Customers

-- SELECT COMBINED VALUES with plain text: retrieve the full name of employees
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName
FROM Employees

-- Identifier: name database, tables, columns, view, stored procedures...
-- 1) regular identifier: comply with rules -> formatting, concatination
-- a) 1st character : a-z, A-Z, @, #
-- IMPORTANT
-- @ -> define local variable 
DECLARE @today DATETIME
SELECT @today = GETDATE()
PRINT @today

-- #: local temp table
-- ##: global

-- b) subsequent characters: a-z, A-Z, 0-9, @, #, $..
-- c) Cannot be reserved keyword, both upper/lower case
SELECT AVG, SUM
FROM TABLE

-- d) Embedded space is not allowed
SELECT EmployeeID, FirstName + ' ' + LastName AS Full Name -- NOT ALLOWED
FROM Employees
GO

-- 2) delimited identifier: '', []
SELECT EmployeeID, FirstName + ' ' + LastName AS 'Full Name'
FROM Employees

SELECT EmployeeID, FirstName + ' ' + LastName AS [Full Name]
FROM Employees

SELECT * FROM [Order Details]

-- WHERE CLAUSE: filter records
-- 1. equal
-- Customers from Germany
SELECT ContactName, Country
FROM Customers
WHERE Country = 'Germany'

-- Product price is 18
SELECT ProductName, ProductID, UnitPrice
FROM Products
WHERE UnitPrice = 18

-- 2. > < !=
--Customers who are not from UK
SELECT ContactName, Country
FROM Customers
WHERE Country != 'UK'

-- Product price > 18
SELECT ProductName, ProductID, UnitPrice
FROM Products
WHERE UnitPrice < 18

-- Customers not from Germany
SELECT ContactName, Country
FROM Customers
WHERE Country != 'Germany'

SELECT ContactName, Country
FROM Customers
WHERE Country <> 'Germany'

-- IN operator: a list of dicrete values
-- Order ship to USA / CANADA
SELECT OrderId, CustomerId, ShipCountry
FROM Orders
WHERE ShipCountry = 'USA' OR ShipCountry = 'CANADA'

SELECT OrderId, CustomerId, ShipCountry
FROM Orders
WHERE ShipCountry IN ('USA', 'CANADA')

-- BETWEEN Operator: in a consecutive range; INCLUSIVE
-- Product price between 18 and 20 
SELECT ProductName, ProductID, UnitPrice
FROM Products
WHERE UnitPrice >= 18 AND UnitPrice <= 20

-- INCLUDING BOTH UPPER AND LOWER BOUND
SELECT ProductName, ProductID, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 18 AND 20

-- NOT Operator: display a record if condition is NOT TRUE
--  list orders that does not ship to USA or Canada
SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE ShipCountry NOT IN ('USA', 'Canada')

SELECT OrderId, CustomerID, ShipCountry
FROM Orders
WHERE NOT ShipCountry IN ('USA', 'Canada')

SELECT ContactName, Country
FROM Customers
WHERE Country != 'Germany'

SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice NOT BETWEEN 20 AND 30

SELECT ProductName, UnitPrice
FROM Products
WHERE NOT UnitPrice BETWEEN 20 AND 30

-- NULL Value: no value / empty
-- check which employees' region information is empty
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees 
WHERE Region IS NULL

-- check which employee has no manager
SELECT EmployeeID, FirstName, LastName, ReportsTo
FROM Employees
WHERE ReportsTo IS NULL

-- exclude the employees whose region is null
SELECT EmployeeID, FirstName, LastName, Region
FROM Employees 
WHERE Region IS NOT NULL

-- NULL in numerical operation
CREATE TABLE TestSalary(EId int primary key identity(1,1), Salary money, Comm money)
INSERT INTO TestSalary VALUES(2000, 500), (2000, NULL),(1500, 500),(2000, 0),(NULL, 500),(NULL,NULL)
SELECT * FROM TestSalary

-- ISNULL (make the null value to a specific one)
SELECT EmployeeID, FirstName, LastName, ISNULL(ReportsTo,0) AS report
FROM Employees

SELECT EId, Salary, Comm, ISNULL(Salary,0) + ISNULL(Comm,0) as total
FROM TestSalary


-- LIKE Operator: create search expression, usually using wildcard character 
-- 1. Work with wildcard character % : substitute 1 or more characters
SELECT EmployeeId, LastName, FirstName, Title, ReportsTo
FROM Employees
-- first name starts as D
WHERE LastName LIKE 'D%'

-- 2. Work with [] and % to search in ranges: 
SELECT ContactName, PostalCode
FROM Customers
-- '[0-3]%', 0,1,2,3
WHERE PostalCode LIKE '[0-3]%'

-- 3. Work with NOT
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[0-3]%' AND PostalCode NOT LIKE '[l-n]%'

-- 4. Work with ^ (=> not)
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'

SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode NOT LIKE '[0-3]%' 

SELECT ContactName
FROM Customers
WHERE ContactName LIKE 'A[^l-n]%'

-- ORDER BY statement: sort the result asc/desc
SELECT ContactName, PostalCode
FROM Customers
WHERE PostalCode LIKE '[^0-3]%'
ORDER BY PostalCode DESC

-- retrieve all customers except those in Boston and sort by Name
SELECT ContactName, City
FROM Customers
WHERE City != 'Boston'
ORDER BY ContactName DESC

-- retrieve product name and unit price, and sort by unit price in descending order
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

SELECT ProductName, UnitPrice
FROM Products
--按结果集的第二列进行排序，按降序排列
ORDER BY 2 DESC

-- Order by UnitPrice first, then ProductName
SELECT ProductName, ProductID, UnitPrice
FROM Products
ORDER BY UnitPrice, ProductName

SELECT ProductName, ProductID, UnitPrice
FROM Products
ORDER BY 3 desc, 1

-- Batch Directives
-- GO
CREATE DATABASE AugustBatch
GO

USE AugustBatch
GO

CREATE TABLE Employee(Id int, Name varchar(20), Salary money)

SELECT * FROM Employee
