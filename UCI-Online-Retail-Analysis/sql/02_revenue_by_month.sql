SELECT 
    InvoiceYear,
    InvoiceMonth,
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM dbo.OnlineRetail_Clean
WHERE IsCancelled = 'No'
GROUP BY InvoiceYear, InvoiceMonth
ORDER BY InvoiceYear, InvoiceMonth;