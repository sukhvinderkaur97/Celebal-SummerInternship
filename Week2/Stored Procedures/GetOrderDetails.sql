CREATE PROCEDURE GetOrderDetails
    @OrderID INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [Order Details] WHERE OrderID = @OrderID)
    BEGIN
        SELECT * FROM [Order Details] WHERE OrderID = @OrderID;
    END
    ELSE
    BEGIN
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR) + ' does not exist';
        RETURN 1;
    END
END;
