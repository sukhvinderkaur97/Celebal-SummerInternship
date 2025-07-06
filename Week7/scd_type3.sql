-- SCD Type 3 – Store previous value in separate column

DELIMITER $$

CREATE PROCEDURE load_scd3()
BEGIN
    UPDATE dim_customer_scd3 AS d
    JOIN   stg_customer       AS s
           ON d.CustomerID = s.CustomerID
    SET    d.PreviousAddress = CASE
                                   WHEN d.Address <> s.Address
                                   THEN d.Address
                                   ELSE d.PreviousAddress
                               END,
           d.Address = s.Address,
           d.Name    = s.Name,
           d.Phone   = s.Phone;

    INSERT INTO dim_customer_scd3
            (CustomerID, Name, Address, PreviousAddress, Phone)
    SELECT  s.CustomerID, s.Name, s.Address, NULL, s.Phone
    FROM    stg_customer s
    LEFT JOIN dim_customer_scd3 d
           ON s.CustomerID = d.CustomerID
    WHERE   d.CustomerID IS NULL;
END$$

DELIMITER ;
