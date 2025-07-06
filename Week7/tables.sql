USE celebal_tasks;

-- Staging Table (Source)
CREATE TABLE stg_customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Dimension Table for SCD Type 0 and Type 1
CREATE TABLE dim_customer_scd0_1 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Dimension Table for SCD Type 2
CREATE TABLE dim_customer_scd2 (
    SurrogateKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20),
    EffectiveDate DATE,
    ExpiryDate DATE,
    CurrentFlag BIT
);

-- Dimension Table for SCD Type 3
CREATE TABLE dim_customer_scd3 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    PreviousAddress VARCHAR(200),
    Phone VARCHAR(20)
);

-- Dimension + History Tables for SCD Type 4
-- Current Dimension Table
CREATE TABLE dim_customer_scd4 (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Historical Table
CREATE TABLE hist_customer_scd4 (
    HistID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Phone VARCHAR(20),
    ChangeDate DATETIME DEFAULT GETDATE()
);

-- Dimension Table for SCD Type 6
CREATE TABLE dim_customer_scd6 (
    SurrogateKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    Name VARCHAR(100),
    Address VARCHAR(200),
    PreviousAddress VARCHAR(200),
    Phone VARCHAR(20),
    EffectiveDate DATE,
    ExpiryDate DATE,
    CurrentFlag BIT
);
