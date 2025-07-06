-- SCD Type 1 – Overwrite the existing data

DELIMITER $$

CREATE PROCEDURE load_scd1()
BEGIN
    /* Upsert: new rows are inserted, existing rows are overwritten         */
    INSERT INTO dim_customer_scd0_1 (CustomerID, Name, Address, Phone)
    SELECT CustomerID, Name, Address, Phone
    FROM   stg_customer
    ON DUPLICATE KEY UPDATE
        Name    = VALUES(Name),
        Address = VALUES(Address),
        Phone   = VALUES(Phone);
END$$

DELIMITER ;
