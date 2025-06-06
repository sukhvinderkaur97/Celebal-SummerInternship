-- Task 15: Top 5 employees by salary (without ORDER BY)

USE celebal_tasks;

-- query
SELECT *
FROM Employees E1
WHERE 5 > (
    SELECT COUNT(DISTINCT Salary)
    FROM Employees E2
    WHERE E2.Salary > E1.Salary
);
