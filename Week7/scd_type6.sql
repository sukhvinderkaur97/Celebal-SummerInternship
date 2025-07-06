-- SCD Type 6 – Hybrid: Type 1 + Type 2 + Type 3

DELIMITER $$

CREATE PROCEDURE load_scd6()
BEGIN
    UPDATE dim_customer_scd6 AS d
    JOIN   stg_customer       AS s
           ON d.CustomerID = s.CustomerID
          AND d.CurrentFlag = 1
          AND d.Address     = s.Address
    SET    d.Name  = s.Name,
           d.Phone = s.Phone;

    UPDATE dim_customer_scd6 AS d
    JOIN   stg_customer       AS s
           ON d.CustomerID = s.CustomerID
          AND d.CurrentFlag = 1
    SET    d.ExpiryDate  = CURDATE(),
           d.CurrentFlag = 0
    WHERE  d.Address <> s.Address;

    INSERT INTO dim_customer_scd6
            (CustomerID, Name, Address, PreviousAddress, Phone,
             EffectiveDate, ExpiryDate, CurrentFlag)
    SELECT  s.CustomerID,
            s.Name,
            s.Address,
            d.Address           AS PreviousAddress,
            s.Phone,
            CURDATE(),
            NULL,
            1
    FROM    stg_customer       s
    JOIN    dim_customer_scd6  d
           ON d.CustomerID  = s.CustomerID
          AND d.CurrentFlag = 0
    WHERE   d.ExpiryDate = CURDATE();

    INSERT INTO dim_customer_scd6
            (CustomerID, Name, Address, PreviousAddress, Phone,
             EffectiveDate, ExpiryDate, CurrentFlag)
    SELECT  s.CustomerID, s.Name, s.Address, NULL, s.Phone,
            CURDATE(), NULL, 1
    FROM    stg_customer s
    LEFT JOIN dim_customer_scd6 d
           ON s.CustomerID = d.CustomerID
    WHERE   d.CustomerID IS NULL;
END$$

DELIMITER ;
