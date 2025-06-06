-- Task 14: Headcounts of sub band and % of total (no JOIN or subquery)

USE celebal_tasks;

-- creating table
CREATE TABLE Employees (
    SubBand VARCHAR(20)
);

-- query
SELECT 
    SubBand,
    COUNT(*) AS Headcount,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM Employees), 2) AS Percentage
FROM Employees
GROUP BY SubBand;
