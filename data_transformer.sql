-- ============================================================
-- PROJECT: Data Transformer
-- Database: MySQL 8.0+
-- Purpose: Corporate Data Analysis System
-- ============================================================

CREATE DATABASE data_transformer;
USE data_transformer;

-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);

-- ============================================================
-- 2. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, RegistrationDate)
VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
(3, 'Michael', 'Brown', 'michael.brown@email.com', '2023-01-10'),
(4, 'Emily', 'Davis', 'emily.davis@email.com', '2022-08-21'),
(5, 'Robert', 'Wilson', 'robert.wilson@email.com', '2023-05-18'),
(6, 'Sophia', 'Taylor', 'sophia.taylor@email.com', '2024-02-12');

INSERT INTO Orders
(OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 1, '2023-07-10', 750.00),
(104, 3, '2023-08-05', 1200.00),
(105, 4, '2023-08-15', 450.25),
(106, 2, '2023-09-01', 980.00),
(107, 5, '2023-09-12', 1600.00),
(108, 3, '2023-10-02', 625.50),
(109, 5, '2023-10-20', 300.00);

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Department, HireDate, Salary)
VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000.00),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000.00),
(3, 'David', 'Miller', 'IT', '2019-06-10', 72000.00),
(4, 'Linda', 'Wilson', 'Finance', '2022-02-05', 68000.00),
(5, 'James', 'Taylor', 'Sales', '2023-04-18', 48000.00),
(6, 'Emma', 'Anderson', 'IT', '2021-09-12', 85000.00);

-- ============================================================
-- 3. CHECK TABLE DATA
-- ============================================================

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Employees;

-- ============================================================
-- 4. INNER JOIN
-- Retrieve orders and matching customer details.
-- ============================================================

SELECT
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
ORDER BY o.OrderID;

-- ============================================================
-- 5. LEFT JOIN
-- Retrieve all customers and their orders, if any.
-- ============================================================

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderID;

-- ============================================================
-- 6. RIGHT JOIN
-- Retrieve all orders and their corresponding customers.
-- ============================================================

SELECT
    o.OrderID,
    o.OrderDate,
    o.TotalAmount,
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID;

-- ============================================================
-- 7. FULL OUTER JOIN
-- MySQL does not support FULL OUTER JOIN directly.
-- LEFT JOIN + RIGHT JOIN using UNION provides the equivalent.
-- ============================================================

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID

UNION

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers AS c
RIGHT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
ORDER BY CustomerID, OrderID;

-- ============================================================
-- 8. SUBQUERY
-- Find customers who have placed an order above the average
-- order amount.
-- ============================================================

SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
)
ORDER BY c.CustomerID;

-- ============================================================
-- 9. SUBQUERY
-- Find employees whose salary is above the average salary.
-- ============================================================

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Department,
    Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
)
ORDER BY Salary DESC;

-- ============================================================
-- 10. EXTRACT YEAR AND MONTH FROM OrderDate
-- ============================================================

SELECT
    OrderID,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders
ORDER BY OrderDate;

-- ============================================================
-- 11. DIFFERENCE IN DAYS BETWEEN ORDER DATE AND CURRENT DATE
-- ============================================================

SELECT
    OrderID,
    OrderDate,
    DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
FROM Orders
ORDER BY OrderDate;

-- ============================================================
-- 12. FORMAT OrderDate AS DD-MMM-YYYY
-- Example: 01-Jul-2023
-- ============================================================

SELECT
    OrderID,
    OrderDate,
    DATE_FORMAT(OrderDate, '%d-%b-%Y') AS FormattedOrderDate
FROM Orders
ORDER BY OrderDate;

-- ============================================================
-- 13. CONCATENATE FIRST NAME AND LAST NAME
-- ============================================================

SELECT
    CustomerID,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers
ORDER BY CustomerID;

-- ============================================================
-- 14. REPLACE PART OF A STRING
-- Replace John with Jonathan.
-- ============================================================

SELECT
    CustomerID,
    FirstName,
    LastName,
    REPLACE(
        CONCAT(FirstName, ' ', LastName),
        'John',
        'Jonathan'
    ) AS UpdatedFullName
FROM Customers
ORDER BY CustomerID;

-- ============================================================
-- 15. UPPERCASE FIRST NAME AND LOWERCASE LAST NAME
-- ============================================================

SELECT
    CustomerID,
    UPPER(FirstName) AS FirstName_Upper,
    LOWER(LastName) AS LastName_Lower
FROM Customers
ORDER BY CustomerID;

-- ============================================================
-- 16. TRIM EXTRA SPACES FROM EMAIL
-- ============================================================

SELECT
    CustomerID,
    Email,
    TRIM(Email) AS TrimmedEmail
FROM Customers
ORDER BY CustomerID;

-- ============================================================
-- 17. RUNNING TOTAL OF TotalAmount
-- Window Function: SUM() OVER()
-- ============================================================

SELECT
    OrderID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (
        ORDER BY OrderDate, OrderID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Orders
ORDER BY OrderDate, OrderID;

-- ============================================================
-- 18. RANK ORDERS BASED ON TotalAmount
-- Window Function: RANK()
-- ============================================================

SELECT
    OrderID,
    OrderDate,
    TotalAmount,
    RANK() OVER (
        ORDER BY TotalAmount DESC
    ) AS OrderRank
FROM Orders
ORDER BY OrderRank;

-- ============================================================
-- 19. DISCOUNT BASED ON TotalAmount
-- >= 1000 = 10% discount
-- > 500  = 5% discount
-- <= 500 = 0% discount
-- ============================================================

SELECT
    OrderID,
    TotalAmount,
    CASE
        WHEN TotalAmount >= 1000 THEN '10% OFF'
        WHEN TotalAmount > 500 THEN '5% OFF'
        ELSE '0% OFF'
    END AS Discount
FROM Orders
ORDER BY TotalAmount DESC;

-- ============================================================
-- 20. CATEGORIZE EMPLOYEE SALARIES
-- >= 70000 = High
-- >= 50000 = Medium
-- < 50000  = Low
-- ============================================================

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees
ORDER BY Salary DESC;

-- ============================================================
-- 21. OPTIONAL SUMMARY QUERIES FOR REPORTING
-- ============================================================

-- Total sales
SELECT
    SUM(TotalAmount) AS TotalSales
FROM Orders;

-- Average order amount
SELECT
    AVG(TotalAmount) AS AverageOrderAmount
FROM Orders;

-- Number of orders
SELECT
    COUNT(*) AS TotalOrders
FROM Orders;

-- Total orders and sales by customer
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    COUNT(o.OrderID) AS TotalOrders,
    COALESCE(SUM(o.TotalAmount), 0) AS TotalSpent
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- ============================================================
-- END OF PROJECT
-- ============================================================
