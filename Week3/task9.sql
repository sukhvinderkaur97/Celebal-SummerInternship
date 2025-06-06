-- Task 9: Binary Tree Node Types

USE celebal_tasks;

-- creating table
CREATE TABLE BST (
    N INT,
    P INT
);

-- query
SELECT N,
       CASE
           WHEN P IS NULL THEN 'Root'
           WHEN N NOT IN (SELECT DISTINCT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
           ELSE 'Inner'
       END AS NodeType
FROM BST
ORDER BY N;
