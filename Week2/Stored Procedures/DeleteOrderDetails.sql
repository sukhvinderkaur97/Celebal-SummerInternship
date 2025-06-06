CREATE PROCEDURE DeleteOrderDetails
    @OrderID INT,
    @ProductID INT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM [Order Details]
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    )
    BEGIN
        DELETE FROM [Order Details]
        WHERE OrderID = @OrderID AND ProductID = @ProductID;
    END
    ELSE
    BEGIN
        PRINT 'Invalid OrderID or ProductID';
        RETURN -1;
    END
END;
