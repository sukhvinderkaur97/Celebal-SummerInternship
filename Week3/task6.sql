-- Task 6: Manhattan Distance Between 2 Points

USE celebal_tasks;

-- creating table
CREATE TABLE STATION (
    ID INT,
    CITY VARCHAR(21),
    STATE VARCHAR(2),
    LAT_N INT,
    LONG_W INT
);

-- query
SELECT ROUND(
    ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)),
    4
) AS manhattan_distance
FROM STATION;
