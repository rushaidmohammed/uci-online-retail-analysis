
-- Step 1: Create clean table from raw import

SELECT *
INTO dbo.OnlineRetail
FROM dbo.OnlineRetail_Raw
WHERE CustomerID IS NOT NULL 
  AND UnitPrice > 0;

GO

-- Step 2: Adding columns

ALTER TABLE dbo.OnlineRetail ADD IsCancelled VARCHAR(3);
ALTER TABLE dbo.OnlineRetail ADD Revenue DECIMAL(10,2);
ALTER TABLE dbo.OnlineRetail ADD InvoiceYear INT;
ALTER TABLE dbo.OnlineRetail ADD InvoiceMonth INT;

GO

-- Step 3: Populating columns

UPDATE dbo.OnlineRetail
SET
    IsCancelled = CASE WHEN LEFT(InvoiceNo, 1) = 'C' THEN 'Yes' ELSE 'No' END,
    Revenue     = Quantity * UnitPrice,
    InvoiceYear = YEAR(InvoiceDate),
    InvoiceMonth = MONTH(InvoiceDate);

GO

-- Step 4: Remove duplicates into final clean table

SELECT DISTINCT *
INTO dbo.OnlineRetail_Clean
FROM dbo.OnlineRetail;

GO