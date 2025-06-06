-- Task 16: Swap value of two columns without using third variable

USE celebal_tasks;

-- query
UPDATE Employees
SET col1 = col1 + col2,
    col2 = col1 - col2,
    col1 = col1 - col2;