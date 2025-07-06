-- SCD Type 2 – Track full history (rows versioned)

DELIMITER $$

CREATE PROCEDURE load_scd2()
BEGIN
    UPDATE dim_customer_scd2 AS d
    JOIN   stg_customer       AS s
           ON d.CustomerID = s.CustomerID
          AND d.CurrentFlag = 1
    SET    d.ExpiryDate  = CURDATE(),
           d.CurrentFlag = 0
    WHERE  d.Name    <> s.Name
        OR d.Address <> s.Address
        OR d.Phone   <> s.Phone;

    INSERT INTO dim_customer_scd2
            (CustomerID, Name, Address, Phone,
             EffectiveDate, ExpiryDate, CurrentFlag)
    SELECT  s.CustomerID, s.Name, s.Address, s.Phone,
            CURDATE(), NULL, 1
    FROM    stg_customer s
    LEFT JOIN dim_customer_scd2 d
           ON  s.CustomerID = d.CustomerID
           AND d.CurrentFlag = 1
    WHERE   d.CustomerID IS NULL
        OR  d.Name    <> s.Name
        OR  d.Address <> s.Address
        OR  d.Phone   <> s.Phone;
END$$

DELIMITER ;
