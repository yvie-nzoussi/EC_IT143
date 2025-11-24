/*
EC_IT143_W3.4_yg.sql
Author: Yvie Grace
Date: 24-Nov-2025
Purpose: AdventureWorks W3.4 - Create Answers
Estimated runtime: < 1 min
*/

-- Q1 (Business User - Marginal Complexity) by Yvie Grace
-- How many departments are in the company?
SELECT COUNT(*) AS DepartmentCount
FROM HumanResources.Department;

-- Q2 (Business User - Marginal Complexity) by Yvie Grace
-- What are the names of all departments?
SELECT Name
FROM HumanResources.Department;

-- Q3 (Business User - Moderate Complexity) by Mylor Humphreys
-- Show me all employees and their job titles in the Engineering department.
SELECT e.BusinessEntityID, p.FirstName, p.LastName, e.JobTitle
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d
    ON edh.DepartmentID = d.DepartmentID
JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE d.Name = 'Engineering';

-- Q4 (Business User - Moderate Complexity) by Mylor Humphreys
-- List the different job titles and how many employees have each title.
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY JobTitle
ORDER BY EmployeeCount DESC;

-- Q5 (Business User - Increased Complexity) by Yvie Grace
-- Report on mountain bike sales during 2012: quantity sold, avg selling price, total revenue by quarter.
SELECT 
    DATEPART(QUARTER, soh.OrderDate) AS Quarter,
    SUM(sod.OrderQty) AS TotalQuantity,
    AVG(sod.UnitPrice) AS AvgPrice,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
WHERE p.Name LIKE '%Mountain Bike%'
    AND YEAR(soh.OrderDate) = 2012
GROUP BY DATEPART(QUARTER, soh.OrderDate)
ORDER BY Quarter;

-- Q6 (Business User - Increased Complexity) by Yvie Grace
-- Sales Dept employee trends 2010-2014, count each year and department name
SELECT d.Name AS DepartmentName, YEAR(edh.StartDate) AS Year, COUNT(DISTINCT e.BusinessEntityID) AS EmployeeCount
FROM HumanResources.EmployeeDepartmentHistory edh
JOIN HumanResources.Employee e
    ON edh.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.Department d
    ON edh.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales' AND YEAR(edh.StartDate) BETWEEN 2010 AND 2014
GROUP BY d.Name, YEAR(edh.StartDate)
ORDER BY Year;

-- Q7 (Metadata) by Yvie Grace
-- Which tables contain a column named ProductID?
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductID';

-- Q8 (Metadata) by Yvie Grace
-- List all columns in the database that use the data type 'money'
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'money';
