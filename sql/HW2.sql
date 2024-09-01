/*** SQL 2 Homework ***/


/** Part 1 Answer following questions **/

-- What is a result set?
--A result set is the collection of data returned by a SQL query. When you run a query, 
--the database processes it and gives you back the matching rows and columns. 

-- What is the difference between Union and Union All?
--The difference between UNION and UNION ALL lies in how they handle duplicate rows:

--UNION: Combines the result sets of two or more SELECT queries and removes any duplicate rows. 
--The result will include only unique rows

--UNION ALL: Combines the result sets of two or more SELECT queries without removing duplicates. 
--The result will include all rows, even if they are duplicates.

-- What are the other Set Operators SQL Server has?
--INTERSECT: Returns common rows between result sets.
--EXCEPT: Returns rows from the first set that aren't in the second set.

-- What is the difference between Union and Join?
-- UNION: Combines entire rows from two queries, used for combining similar data from different sources.
-- JOIN: Combines columns from two tables based on a relationship, used for linking related data across different tables.

-- What is the difference between INNER JOIN and FULL JOIN?
-- Key Differences:
-- INNER JOIN: Returns only matching rows from both tables.
-- FULL JOIN: Returns all rows from both tables, with NULLs where there is no match.


-- What is difference between left join and outer join
-- 1. LEFT JOIN (LEFT OUTER JOIN):
-- Combines rows from two tables, returning all rows from the left table.
-- Rows from the right table are included only where there is a match.
-- If there is no match, NULL values are used for columns from the right table.
-- 2. OUTER JOIN:
-- This term generally refers to a group of joins that include LEFT JOIN, RIGHT JOIN, and FULL JOIN.
-- Each of these joins returns all rows from one or both tables, with NULLs where there is no match.
-- OUTER JOIN can be LEFT (as in LEFT JOIN), RIGHT (as in RIGHT JOIN), or FULL (as in FULL JOIN).
-- Key Differences:
-- LEFT JOIN: Specifically returns all rows from the left table and matching rows from the right table.
-- OUTER JOIN: A broader term that includes LEFT JOIN, RIGHT JOIN, and FULL JOIN, each with its own behavior regarding which table's rows are fully included.


-- What is cross join?
-- Combines every row from the first table with every row from the second table.
-- Also known as a Cartesian join.
-- The result is a Cartesian product of the two tables, meaning if the first table has 'A' rows and the second table has 'B' rows,
-- the result will have 'A * B' rows.

-- What is the difference between WHERE clause and HAVING clause?
-- 1. WHERE Clause:
-- Used to filter rows before any groupings are made.
-- Applies conditions to individual rows in a table.
-- Cannot be used with aggregate functions (like COUNT, SUM) directly.
-- 2. HAVING Clause:
-- Used to filter groups of rows after the GROUP BY clause has been applied.
-- Applies conditions to groups created by GROUP BY, often involving aggregate functions.
-- Can be used with aggregate functions to filter the results of aggregation.
-- Key Differences:
-- WHERE: Filters rows before aggregation, cannot use aggregate functions directly.
-- HAVING: Filters groups after aggregation, can use aggregate functions.

-- [?]Can there be multiple group by columns?
-- Yes, you can have multiple columns in a GROUP BY clause.
-- When you specify more than one column, SQL groups the result set by each combination of the specified columns.
-- This allows you to perform aggregation on subsets of data defined by the unique combinations of these columns.


/** Part 2 Write queries for following scenarios **/

/* Select master Database */
USE Northwind
GO

/* Query 1
How many products can you find in the Products table?
*/
SELECT COUNT(ProductId)
From Products


/* Query 2
Write a query that retrieves the number of products in the Products table that are out of stock. 
The rows that have 0 in column UnitsInStock are considered to be out of stock. 
*/
SELECT COUNT(*) AS  NumberOfOutOfStockProducts
From Products
Where UnitsInStock=0;



/* Query 3
How many Products reside in each Category? Write a query to display the results with the following titles.
CategoryID CountedProducts
---------- ---------------
*/
SELECT CategoryID, Count(ProductID) as CountedProducts
FROM Products
GROUP BY CategoryID;



/* Query 4
How many products that are not in category 6. 
*/SELECT CategoryID, Count(ProductID) as CountedProducts
FROM Products
--not: <>
Where CategoryID <> 6
GROUP BY CategoryID;

/* Query 5
Write a query to list the sum of products UnitsInStock in Products table.
*/
SELECT SUM(UnitsInStock)
From Products


/* Query 6 
Write a query to list the sum of products by category in the Products table 
and UnitPrice over 25 and limit the result to include just summarized quantities larger than 10.
CategoryID			TheSum
-----------        ----------
*/
--sum of product, category>product>unitsinstick

SELECT CategoryID, SUM(UnitsInStock) AS Thesum
FROM Products
WHERE UnitPrice>25
GROUP BY CategoryID
HAVING SUM(UnitsInStock) > 10;


/* Query 7
Write a query to list the sum of products with productID by category in the Products table 
and UnitPrice over 25 and limit the result to include just summarized quantities larger than 10.
ProductID  CategoryID	  TheSum
---------- -----------    -----------
*/

SELECT ProductID, CategoryID, SUM(UnitsInStock) AS Thesum
FROM Products
WHERE UnitPrice>25
GROUP BY ProductID, CategoryID
HAVING SUM(UnitsInStock) > 10;


/* Query 8
Write the query to list the average UnitsInStock for products 
where column CategoryID has the value of 2 from the table Products.
*/
SELECT CategoryID, AVG(UnitsInStock) AS AverageUnitsInStock
FROM Products
WHERE CategoryID = 2
GROUP BY CategoryID;


/* Query 9
Write query to see the average quantity of products by Category from the table Products.
CategoryID      TheAvg
----------    -----------
*/
SELECT CategoryID, AVG(UnitsInStock) AS TheAvg
FROM Products
GROUP BY CategoryID



/* Query 10
Write query  to see the average quantity  of  products by Category and product id
excluding rows that has the value of 1 in the column Discontinued from the table Products
ProductID   CategoryID   TheAvg
----------- ----------   -----------
*/
SELECT ProductID, CategoryID, AVG(UnitsInStock) AS TheAvg
FROM Products
WHERE Discontinued <> 1  -- Exclude rows where Discontinued is 1
GROUP BY ProductID, CategoryID;


/* Query 11
List the number of members (rows) and average UnitPrice in the Products table. 
This should be grouped independently over the SupplierID and the CategoryID column. Exclude the discountinued products (discountinue = 1)
SupplierID      CategoryID		TheCount   		AvgPrice
--------------	------------ 	----------- 	---------------------
*/
-- number of rows, count(*)
SELECT 
    SupplierID, 
    NULL AS CategoryID, 
    COUNT(*) AS TheCount, 
    AVG(UnitPrice) AS AvgPrice
FROM 
    Products
WHERE 
    Discontinued <> 1
GROUP BY 
    SupplierID

UNION ALL

SELECT 
    NULL AS SupplierID, 
    CategoryID, 
    COUNT(*) AS TheCount, 
    AVG(UnitPrice) AS AvgPrice
FROM 
    Products
WHERE 
    Discontinued <> 1
GROUP BY 
    CategoryID;


-- Joins
-- Using Northwnd Database: (Use aliases for all the Joins)

/* Query 12
Write a query that lists the Territories and Regions names from Territories and Region tables. 
Join them and produce a result set similar to the following. 
Territory           Region
---------         ----------------------
*/
--1. territories and rigon  both have region id column
SELECT * 
FROM Territories t 
JOIN Region r ON t.RegionID=r.RegionID



/* Query 13
Write a query that lists the Territories and Regions names from Territories and Region tables. 
and list the Territories filter them by Eastern and Northern. Join them and produce a result set similar to the following.
Territory           Region
---------     ----------------------
*/
-- each terrotory have a region id, a region id have either north or eastern
SELECT 
    t.TerritoryDescription AS Territory, 
    r.RegionDescription AS Region
FROM 
    Territories t
JOIN 
    Region r ON t.RegionID = r.RegionID
WHERE 
    r.RegionDescription LIKE '%Eastern%' 
    OR r.RegionDescription LIKE '%Northern%';



/* Query 14
List all Products that has been sold at least once in last 25 years.
*/
-- order details connect with product with productid, connect with orders with orderid
SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) >= (YEAR( GETDATE()) - 25);



/* Query 15
List top 5 locations (Zip Code) where the products sold most.
*/
--Products[id,name]ProductID, ProductName, Suppliers:PostalCodes , [Order Details]:Quantity
SELECT TOP(5) s.PostalCode, SUM(od.Quantity) AS TotalQuantity
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY s.PostalCode
ORDER BY TotalQuantity DESC;



/* Query 16
List top 5 locations (Zip Code) where the products sold most in last 25 years.
*/
--zipcode(suppliers),  sold quantity(order details)
--connect: Suppliers:SupplierID, Products: ProductID, SupplierID, Order Details: ProductID
--就是先把这三个表连接起来，然后根据postalcode计算quantity的数量
SELECT TOP(25) s.PostalCode, SUM(od. Quantity) AS TotalQuantity
FROM Suppliers s
JOIN Products p ON s.SupplierID=p.SupplierID
JOIN[Order Details] od ON od.ProductID=p.ProductID
GROUP BY s.PostalCode
ORDER BY  TotalQuantity DESC;


/* Query 17
List all city names and number of customers in that city. 
*/
-- Customers: City, CustomerID
SELECT c.City, COUNT(c.CustomerID)
FROM Customers c
GROUP BY c.City

/* Query 18
List city names which have more than 2 customers, and number of customers in that city 
*/
SELECT c.City, COUNT(c.CustomerID)
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID)>2;

/* Query 19
List the names of customers who placed orders after 1/1/98 with order date.
*/

--Customer:ContactName, Order: OrderDate
--Connect by CustomerID
-- 
SELECT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

/* Query 20
List the names of all customers with most recent order dates 
*/
SELECT c.ContactName, MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName;

/* Query 21
Display the names of all customers along with the count of products they bought
*/
--customers name, count of product they bought
--ContactName, Customers [ CustomerID]       Order Details, Quantity[OrderID ProductID]
-- Connect by Orders[OrderID CustomerID]
--COUNT(od.Quantity) 只会统计每个订单明细的行数，而不是计算产品的数量总和。
SELECT c.ContactName, SUM(od.Quantity) AS TotalProductsBought
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.ContactName;


/* Query 22
Display the customer ids who bought more than 100 Products with count of products.
*/
SELECT c.CustomerID, SUM(od.Quantity) AS TotalProductsBought
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100;



/* Query 23
List all of the possible ways that suppliers can ship their products. Display the results as below
Supplier Company Name   	Shipping Company Name
----------------------      ----------------------------------
*/
--Suppliers:SupplierID  Shippers:ShipperID,CompanyName
SELECT s.CompanyName AS SupplierCompanyName, 
       sh.CompanyName AS ShippingCompanyName
FROM Suppliers s
--CROSS JOIN 用于生成两个表的笛卡尔积（即，每个供应商与每个运输公司组合），从而列出所有可能的组合。
CROSS JOIN Shippers sh;



/* Query 24
Display the products order each day. Show Order date and Product Name.
*/
-- orderdate, product name
--Orderdate FROM Orders:OrderID,CustomerID; ProductName FROM Products:ProductID,SupploerID
--Connectby  [Order Details] od:OrderID,ProductID
SELECT o.OrderDate, p.ProductName
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
ORDER BY o.OrderDate;


/* Query 25
Displays pairs of employees who have the same job title.
*/
--？
SELECT e1.FirstName + ' ' + e1.LastName + '/' + e2.FirstName + ' ' + e2.LastName AS EmployeePair
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title 
                 AND e1.EmployeeID < e2.EmployeeID;



/* Query 26
Display all the Managers who have more than 2 employees reporting to them.
*/
--more than 2, means 
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS ManagerName, COUNT(emp.EmployeeID) AS NumberOfReports
FROM Employees e
JOIN Employees emp ON e.EmployeeID = emp.ReportsTo
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(emp.EmployeeID) > 2;

/* Query 27
Display the customers and suppliers by city. The results should have the following columns
City 
Name 
Contact Name,
Type (Customer or Supplier)
*/

SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM Customers

UNION ALL

SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM Suppliers
ORDER BY City, Type;






/* Query 28
For example, you have two exactly the same tables T1 and T2 with two columns F1 and F2
	F1	F2
	--- ---
	1	2
	2	3
	3	4
Please write a query to inner join these two tables and write down the result of this query.
*/
SELECT T1.F1, T1.F2, T2.F1, T2.F2
FROM T1
INNER JOIN T2 ON T1.F1 = T2.F1;

T1.F1	T1.F2	T2.F1	T2.F2
1	2	1	2
2	3	2	3
3	4	3	4


/* Query 29
Based on above two table, Please write a query to left outer join these two tables and write down the result of this query.
*/
SELECT T1.F1, T1.F2, T2.F1, T2.F2
FROM T1
LEFT OUTER JOIN T2 ON T1.F1 = T2.F1;

T1.F1	T1.F2	T2.F1	T2.F2
1	2	1	2
2	3	2	3
3	4	3	4