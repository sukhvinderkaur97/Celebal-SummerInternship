CREATE PROCEDURE InsertOrderDetails
    @OrderID INT,
    @ProductID INT,
    @Quantity INT,
    @UnitPrice MONEY = NULL,
    @Discount FLOAT = 0
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ActualUnitPrice MONEY;
    DECLARE @UnitsInStock INT;
    DECLARE @ReorderLevel INT;
    BEGIN TRY

        IF @UnitPrice IS NULL
        BEGIN
            SELECT @ActualUnitPrice = UnitPrice
            FROM Products
            WHERE ProductID = @ProductID;
            IF @ActualUnitPrice IS NULL
            BEGIN
                PRINT 'Product not found.';
                RETURN;
            END
        END
        ELSE
        BEGIN
            SET @ActualUnitPrice = @UnitPrice;
        END

        SELECT @UnitsInStock = UnitsInStock, @ReorderLevel = ReorderLevel
        FROM Products
        WHERE ProductID = @ProductID;

        IF @UnitsInStock IS NULL
        BEGIN
            PRINT 'Product not found.';
            RETURN;
        END

        IF @UnitsInStock < @Quantity
        BEGIN
            PRINT 'Not enough stock available. Order aborted.';
            RETURN;
        END

        INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
        VALUES (@OrderID, @ProductID, @ActualUnitPrice, @Quantity, @Discount);
        IF @@ROWCOUNT = 0
        BEGIN
            PRINT 'Failed to place the order. Please try again.';
            RETURN;
        END

        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Quantity
        WHERE ProductID = @ProductID;

        SELECT @UnitsInStock = UnitsInStock
        FROM Products
        WHERE ProductID = @ProductID;

        IF @UnitsInStock < @ReorderLevel
        BEGIN
            PRINT 'Warning: Product stock has dropped below the Reorder Level.';
        END

    END TRY
    BEGIN CATCH
        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
