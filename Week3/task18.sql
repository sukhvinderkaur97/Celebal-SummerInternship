-- Task 18: Weighted average cost (month-wise)

USE celebal_tasks;

-- creating table
CREATE TABLE EmployeeCost (
    Month VARCHAR(20),
    Cost FLOAT,
    Weight INT
);

-- query
SELECT 
    Month,
    ROUND(SUM(Cost * Weight) / SUM(Weight), 2) AS WeightedAvgCost
FROM EmployeeCost
GROUP BY Month;
