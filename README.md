# Data Transformer

## Project Objective
Data Transformer is a MySQL 8.0+ SQL project designed to practice advanced SQL operations for reporting and analysis.

## Main Topics Covered
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN equivalent in MySQL
- Subqueries
- Date functions
- String functions
- Window functions
- RANK()
- Running totals
- CASE expressions

## Database
`data_transformer`

## Tables
1. `Customers`
2. `Orders`
3. `Employees`

## Project Files
- `data_transformer.sql` - complete database, tables, sample data, and all required queries
- `README.md` - project documentation

## How to Run
1. Open MySQL Workbench or another MySQL 8.0+ client.
2. Open `data_transformer.sql`.
3. Run the complete script.
4. The script creates the database automatically.
5. Select the `data_transformer` database if required.
6. Run the queries and review the result sets.

## Important MySQL Note
MySQL does not provide `FULL OUTER JOIN` as a direct JOIN keyword. The project therefore implements the required full outer join behavior by combining a `LEFT JOIN` and a `RIGHT JOIN` with `UNION`.

## Assumptions
- MySQL 8.0+ is used because the project contains window functions.
- CustomerID and EmployeeID are unique identifiers.
- Every order references an existing customer.
- The discount rules follow the example in the assignment:
  - TotalAmount >= 1000: 10% off
  - TotalAmount > 500: 5% off
  - Otherwise: 0% off
- Salary categories are defined as:
  - Salary >= 70000: High
  - Salary >= 50000: Medium
  - Salary < 50000: Low
- `CURDATE()` is used for the current-date calculation, so the days-difference result changes over time.

## Assignment Coverage
1. INNER JOIN - included
2. LEFT JOIN - included
3. RIGHT JOIN - included
4. FULL OUTER JOIN - included using MySQL-compatible UNION
5. Customer subquery above average order amount - included
6. Employee subquery above average salary - included
7. Extract year and month - included
8. Difference in days - included
9. Readable OrderDate format - included
10. Full name using CONCAT - included
11. String replacement - included
12. UPPER/LOWER - included
13. TRIM email - included
14. Running total - included
15. RANK() - included
16. CASE-based discount - included
17. CASE-based salary category - included
# project_2_sql-README.md
