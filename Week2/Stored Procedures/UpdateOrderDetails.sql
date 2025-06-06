CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice MONEY = NULL,
    @Quantity INT = NULL,
    @Discount REAL = NULL
AS
BEGIN

    DECLARE @CurrentUnitPrice MONEY,
            @CurrentQuantity INT,
            @CurrentDiscount REAL;

    SELECT @CurrentUnitPrice = UnitPrice,
           @CurrentQuantity = Quantity,
           @CurrentDiscount = Discount
    FROM [Order Details]
    WHERE OrderID = @OrderID AND ProductID = @ProductID;

    UPDATE [Order Details]
    SET UnitPrice = ISNULL(@UnitPrice, @CurrentUnitPrice),
        Quantity = ISNULL(@Quantity, @CurrentQuantity),
        Discount = ISNULL(@Discount, @CurrentDiscount)
    WHERE OrderID = @OrderID AND ProductID = @ProductID;

    IF @Quantity IS NOT NULL
    BEGIN
        UPDATE Products
        SET UnitsInStock = UnitsInStock - (@Quantity - @CurrentQuantity)
        WHERE ProductID = @ProductID;
    END
END;
