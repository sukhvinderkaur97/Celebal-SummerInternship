-- Task5: Count of Unique Hackers and Top Hacker Per Day 

USE celebal_tasks;

-- creating tables
CREATE TABLE Hackers (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT,
    hacker_id INT,
    score INT
);

-- query
SELECT s.submission_date,
       COUNT(DISTINCT s.hacker_id) AS unique_hackers,
       h.hacker_id,
       h.name
FROM Submissions s
JOIN Hackers h ON s.hacker_id = h.hacker_id
WHERE s.submission_date BETWEEN '2016-03-01' AND '2016-03-15'
GROUP BY s.submission_date, h.hacker_id, h.name
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Submissions
        WHERE submission_date = s.submission_date
        GROUP BY hacker_id
    ) AS sub
)
ORDER BY s.submission_date;
