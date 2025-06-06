-- Task 10: Company Hierarchy Count

USE celebal_tasks;

-- creating tables
CREATE TABLE Company (
    company_code VARCHAR(10),
    founder VARCHAR(100)
);

CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

CREATE TABLE Manager (
    manager_code VARCHAR(10),
    company_code VARCHAR(10)
);

CREATE TABLE Employee (
    employee_code VARCHAR(10),
    company_code VARCHAR(10)
);

-- query
SELECT c.company_code, c.founder,
       COUNT(DISTINCT lm.lead_manager_code),
       COUNT(DISTINCT sm.senior_manager_code),
       COUNT(DISTINCT m.manager_code) + COUNT(DISTINCT e.employee_code)
FROM Company c
LEFT JOIN Lead_Manager lm ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm ON c.company_code = sm.company_code
LEFT JOIN Manager m ON c.company_code = m.company_code
LEFT JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;
