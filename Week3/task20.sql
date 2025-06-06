-- Task 20: Copy new data (no indicator for new data)

USE celebal_tasks;

-- creating table
CREATE TABLE OldTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

CREATE TABLE NewTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

-- query
INSERT INTO OldTable
SELECT * FROM NewTable
WHERE NOT EXISTS (
    SELECT 1 FROM OldTable 
    WHERE OldTable.ID = NewTable.ID
);