-- Task 3: Symmetric Pairs

USE celebal_tasks;

-- creating table
CREATE TABLE Functions (
    X INT,
    Y INT
);

-- query
SELECT 
    f1.X, f1.Y
FROM Functions f1
JOIN Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
GROUP BY f1.X, f1.Y
ORDER BY f1.X ASC;
