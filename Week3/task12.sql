-- Task 12: Display ratio of cost of job family by India vs International

USE celebal_tasks;

-- creating table
CREATE TABLE JobFamilyCost (
    Country VARCHAR(20),
    Cost FLOAT
);

-- query
SELECT 
    ROUND(
        SUM(CASE WHEN Country = 'India' THEN Cost ELSE 0 END) /
        SUM(CASE WHEN Country != 'India' THEN Cost ELSE 0 END), 2
    ) AS IndiaToInternationalRatio;
