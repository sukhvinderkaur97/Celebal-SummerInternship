-- Task 19: Samantha miscalculated average by skipping zeros

USE celebal_tasks;

-- creating table
CREATE TABLE Employees (
    Salary INT
);

-- query
SELECT 
    CEILING(AVG(Salary) - AVG(CAST(REPLACE(Salary, '0', '') AS INT))) AS ErrorRoundedUp
FROM Employees;
