
Q1
SELECT 
    Status, 
    COUNT(*) AS Transaction_Count
FROM Transactions
GROUP BY Status;

Q2
SELECT 
    Merchant_Name, 
    SUM(Amt_USD) AS Total_Captured_GMV
FROM Transactions
WHERE Status = 'captured'
GROUP BY Merchant_Name;

Q3
SELECT 
    Merchant_Name, 
    SUM(Amt_USD) AS Total_Captured_GMV
FROM Transactions
WHERE Status = 'captured'
GROUP BY Merchant_Name
ORDER BY Total_Captured_GMV DESC
LIMIT 10;

Q4
SELECT 
    transaction_date, 
    SUM(Amt_USD) AS Daily_GMV, 
    COUNT(*) AS Successful_Txn_Count
FROM Transactions
WHERE Status = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date;

Q5
SELECT 
    Merchant_Name,
    (COUNT(CASE WHEN Status = 'chargeback' THEN 1 END) * 100.0 / COUNT(*)) AS Chargeback_Ratio
FROM Transactions
GROUP BY Merchant_Name
HAVING (COUNT(CASE WHEN Status = 'chargeback' THEN 1 END) * 100.0 / COUNT(*)) > 1.0;

Q6
SELECT 
    Gateway_Region, 
    AVG(Risk_Score) AS Avg_Risk_Score, 
    COUNT(*) AS Total_Txns
FROM Transactions
GROUP BY Gateway_Region
HAVING AVG(Risk_Score) > 50 AND COUNT(*) > 20;

Q7
SELECT 
    User_Id, 
    transaction_date, 
    COUNT(*) AS Failed_Or_CB_Count
FROM Transactions
WHERE Status LIKE 'failed%' OR Status = 'chargeback'
GROUP BY User_Id, transaction_date
HAVING COUNT(*) >= 3;

Q8
SELECT 
    Merchant_Name, 
    COUNT(*) AS Chargeback_Count, 
    COUNT(DISTINCT User_Id) AS Unique_Affected_Users, 
    SUM(Amt_USD) AS Total_Chargeback_Amount
FROM Transactions
WHERE Status = 'chargeback'
GROUP BY Merchant_Name;

