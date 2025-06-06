-- Task 4: Exclude contests where all four sums are zero.

USE celebal_tasks;

-- creating tables
CREATE TABLE Contests (
    contest_id INT,
    hacker_id INT,
    name VARCHAR(100)
);

CREATE TABLE Colleges (
    college_id INT,
    contest_id INT
);

CREATE TABLE Challenges (
    challenge_id INT,
    college_id INT
);

CREATE TABLE View_Stats (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
);

CREATE TABLE Submission_Stats (
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

-- query
SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    COALESCE(SUM(s.total_submissions), 0) AS total_submissions,
    COALESCE(SUM(s.total_accepted_submissions), 0) AS total_accepted_submissions,
    COALESCE(SUM(v.total_views), 0) AS total_views,
    COALESCE(SUM(v.total_unique_views), 0) AS total_unique_views
FROM Contests c
JOIN Colleges col ON c.contest_id = col.contest_id
JOIN Challenges ch ON col.college_id = ch.college_id
LEFT JOIN View_Stats v ON ch.challenge_id = v.challenge_id
LEFT JOIN Submission_Stats s ON ch.challenge_id = s.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
    (total_submissions + total_accepted_submissions + total_views + total_unique_views) > 0
ORDER BY c.contest_id;
