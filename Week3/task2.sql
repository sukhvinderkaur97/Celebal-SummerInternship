-- Task 2: Students whose best friend got a higher salary

USE celebal_tasks;

-- creating tables
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(100)
);

CREATE TABLE Friends (
    ID INT,
    Friend_ID INT
);

CREATE TABLE Packages (
    ID INT,
    Salary FLOAT
);

-- query
SELECT 
    s.Name
FROM Students s
JOIN Friends f ON s.ID = f.ID
JOIN Packages p_student ON s.ID = p_student.ID
JOIN Packages p_friend ON f.Friend_ID = p_friend.ID
WHERE p_friend.Salary > p_student.Salary
ORDER BY p_friend.Salary ASC;
