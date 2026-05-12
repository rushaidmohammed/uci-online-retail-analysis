SELECT 
    Country,
    COUNT(CASE WHEN IsCancelled = 'Yes' THEN 1 END) AS CancelledOrders,
    COUNT(CASE WHEN IsCancelled = 'No' THEN 1 END) AS CompletedOrders,
    ROUND(
        COUNT(CASE WHEN IsCancelled = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2
    ) AS CancellationRate_Pct
FROM dbo.OnlineRetail
GROUP BY Country
ORDER BY CancellationRate_Pct DESC;