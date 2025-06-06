-- Task 7: Print Prime Numbers ≤ 1000 (Delimited by '&')

USE celebal_tasks;

-- query
WITH RECURSIVE numbers AS (
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1 FROM numbers WHERE num < 1000
),
primes AS (
    SELECT num FROM numbers n
    WHERE NOT EXISTS (
        SELECT 1 FROM numbers d
        WHERE d.num < n.num AND n.num % d.num = 0 AND d.num > 1
    )
)
SELECT GROUP_CONCAT(num SEPARATOR '&') FROM primes;
