USE retail_sales;

CREATE TABLE IF NOT EXISTS online_retail (
    InvoiceNo VARCHAR(20) NOT NULL,
    StockCode VARCHAR(20) NOT NULL,
    Description TEXT NULL,
    Quantity INT NOT NULL,
    InvoiceDate DATETIME NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CustomerID INT NULL,
    Country VARCHAR(100) NOT NULL,
    IsCancelled BOOLEAN NOT NULL,
    IsNegativeQuantity BOOLEAN NOT NULL,
    IsZeroPrice BOOLEAN NOT NULL,
    IsNegativePrice BOOLEAN NOT NULL,
    LineTotal DECIMAL(12,2) NOT NULL
);