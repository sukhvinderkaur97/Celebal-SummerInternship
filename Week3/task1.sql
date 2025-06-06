-- Task 1: Group consecutive dates into projects

CREATE DATABASE celebal_tasks;
USE celebal_tasks;

-- creating table
CREATE TABLE Projects (
    Task_ID INT,
    Start_Date DATE,
    End_Date DATE
);

-- query

WITH project_groups AS (
    SELECT 
        Start_Date,
        End_Date,
        Start_Date - INTERVAL (ROW_NUMBER() OVER (ORDER BY Start_Date)) DAY AS grp
    FROM Projects
),
grouped_projects AS (
    SELECT
        MIN(Start_Date) AS project_start,
        MAX(End_Date) AS project_end,
        grp
    FROM project_groups
    GROUP BY grp
)
SELECT 
    project_start,
    project_end
FROM grouped_projects
ORDER BY 
    DATEDIFF(project_end, project_start) ASC,
    project_start ASC;
