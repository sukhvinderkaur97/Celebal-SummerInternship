CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    QuantityPerUnit VARCHAR(50),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT,
    Discontinued BIT,
    SupplierID INT,
    CategoryID INT
);

INSERT INTO Products VALUES
(101, 'Apple iPhone', '1 unit', 999.99, 10, 0, 1, 1),
(102, 'Samsung Galaxy', '1 unit', 899.99, 0, 0, 2, 2);
