WITH RFM_Base AS (
    SELECT 
        CustomerID,
        DATEDIFF(day, MAX(InvoiceDate), '2011-12-10') AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        ROUND(SUM(Revenue), 2) AS Monetary
    FROM dbo.OnlineRetail_Clean
    WHERE IsCancelled = 'No'
    GROUP BY CustomerID
),
RFM_Scored AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Base
)
SELECT *,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score,
    CASE 
        WHEN R_Score = 4 AND F_Score = 4 AND M_Score = 4 THEN 'Champion'
        WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customer'
        WHEN R_Score = 4 AND F_Score <= 2 THEN 'New Customer'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        WHEN R_Score = 1 AND F_Score = 1 THEN 'Lost Customer'
        ELSE 'Potential Loyalist'
    END AS CustomerSegment
FROM RFM_Scored
ORDER BY Monetary DESC;