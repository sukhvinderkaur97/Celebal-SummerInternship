-- SCD Type 0 – No changes allowed (read-only)

DELIMITER $$

CREATE PROCEDURE load_scd0()
BEGIN
    INSERT IGNORE INTO dim_customer_scd0_1 (CustomerID, Name, Address, Phone)
    SELECT CustomerID, Name, Address, Phone
    FROM   stg_customer;
END$$

DELIMITER ;
