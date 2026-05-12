SELECT TOP 10
    Country,
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM dbo.OnlineRetail_Clean
WHERE IsCancelled = 'No'
GROUP BY Country
ORDER BY TotalRevenue DESC;