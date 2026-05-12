SELECT TOP 10
    StockCode,
    Description,
    SUM(Quantity) AS TotalUnitsSold,
    ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM dbo.OnlineRetail
WHERE IsCancelled = 'No'
GROUP BY StockCode, Description
ORDER BY TotalRevenue DESC;