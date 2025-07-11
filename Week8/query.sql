USE celebal_tasks;

-- Table Structure

CREATE TABLE date_dim (
    date DATE PRIMARY KEY,
    day INT,
    day_name VARCHAR(10),
    day_of_week INT,
    day_of_year INT,
    week_of_month INT,
    week_of_year INT,
    month INT,
    month_name VARCHAR(15),
    quarter INT,
    year INT,
    is_weekend BOOLEAN
);

-- Stored Procedure

DELIMITER //

CREATE PROCEDURE populate_date_dim(IN input_date DATE)
BEGIN
    DECLARE start_date DATE;
    DECLARE end_date DATE;

    SET start_date = DATE_FORMAT(input_date, '%Y-01-01');
    SET end_date = DATE_FORMAT(input_date, '%Y-12-31');

    INSERT INTO date_dim (
        date, day, day_name, day_of_week, day_of_year,
        week_of_month, week_of_year, month, month_name,
        quarter, year, is_weekend
    )
    SELECT
        d.generated_date,
        DAY(d.generated_date),
        DAYNAME(d.generated_date),
        WEEKDAY(d.generated_date) + 1,
        DAYOFYEAR(d.generated_date),
        FLOOR((DAY(d.generated_date) - 1) / 7) + 1,
        WEEK(d.generated_date, 3),
        MONTH(d.generated_date),
        MONTHNAME(d.generated_date),
        QUARTER(d.generated_date),
        YEAR(d.generated_date),
        CASE WHEN WEEKDAY(d.generated_date) IN (5,6) THEN TRUE ELSE FALSE END
    FROM (
        SELECT DATE_ADD(start_date, INTERVAL seq DAY) AS generated_date
        FROM (
            SELECT @row := @row + 1 AS seq
            FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
                  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t1,
                 (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
                  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t2,
                 (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
                  UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) t3,
                 (SELECT @row := -1) init
        ) AS seq_numbers
        WHERE DATE_ADD(start_date, INTERVAL seq DAY) <= end_date
    ) AS d;
END //

DELIMITER ;
