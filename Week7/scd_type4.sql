-- SCD Type 4 – History stored in a separate table

DELIMITER $$

CREATE PROCEDURE load_scd4()
BEGIN
    INSERT INTO hist_customer_scd4
            (CustomerID, Name, Address, Phone, ChangeDate)
    SELECT  d.CustomerID, d.Name, d.Address, d.Phone, NOW()
    FROM    dim_customer_scd4 d
    JOIN    stg_customer     s ON d.CustomerID = s.CustomerID
    WHERE   d.Name    <> s.Name
        OR  d.Address <> s.Address
        OR  d.Phone   <> s.Phone;

    INSERT INTO dim_customer_scd4 (CustomerID, Name, Address, Phone)
    SELECT CustomerID, Name, Address, Phone
    FROM   stg_customer
    ON DUPLICATE KEY UPDATE
        Name    = VALUES(Name),
        Address = VALUES(Address),
        Phone   = VALUES(Phone);
END$$

DELIMITER ;
