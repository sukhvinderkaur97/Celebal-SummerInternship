CREATE TRIGGER trg_CheckStock_BeforeInsert
ON [Order Details]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ProductID INT, @Quantity INT, @UnitsInStock INT;

    SELECT @ProductID = i.ProductID, @Quantity = i.Quantity
    FROM inserted i;

    SELECT @UnitsInStock = UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID;

    IF @UnitsInStock >= @Quantity
    BEGIN
        INSERT INTO [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
        SELECT OrderID, ProductID, UnitPrice, Quantity, Discount
        FROM inserted;

        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        RAISERROR ('Order could not be placed due to insufficient stock.', 16, 1);
    END
END;
