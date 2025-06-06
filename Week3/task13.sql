-- Task 13: Ratio of Cost to Revenue of a BU month on month

USE celebal_tasks;

-- creating table
CREATE TABLE BU_Monthly (
    Month VARCHAR(20),
    Cost FLOAT,
    Revenue FLOAT
);

-- query
SELECT 
    Month,
    ROUND(Cost / Revenue, 2) AS CostToRevenueRatio
FROM BU_Monthly;