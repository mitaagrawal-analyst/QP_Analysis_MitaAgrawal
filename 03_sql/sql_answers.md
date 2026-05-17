# SQL Answers

## Q1 Count Transactions by Status
### Query
SELECT 
    Status, 
    COUNT(*) AS Transaction_Count
FROM Transactions
GROUP BY Status;

### Result Summary
Status	Transaction_Count
captured	19
failed e05 timeout	7
chargeback	4

## Q2 Total Captured GMV by Merchant
### Query
SELECT 
    Merchant_Name, 
    SUM(Amt_USD) AS Total_Captured_GMV
FROM cleaned_transactions
WHERE Status = 'captured'
GROUP BY Merchant_Name;

### Result Summary
Merchant_Name	Total_Captured_GMV
Alpha Mart	29984.5
Beta Stores	33431
City Pharma	8640
Delta Travels	10300

## Q3 Top 10 Merchants by Captured GMV
### Query
SELECT 
    Merchant_Name, 
    SUM(Amt_USD) AS Total_Captured_GMV
FROM Transactions
WHERE Status = 'captured'
GROUP BY Merchant_Name
ORDER BY Total_Captured_GMV DESC
LIMIT 10;

### Result Summary
Merchant_Name	Total_Captured_GMV
Beta Stores	33431
Alpha Mart	29984.5
Delta Travels	10300
City Pharma	8640

## Q4 Daily GMV and Successful Transaction Count
### Query
SELECT 
    transaction_date, 
    SUM(Amt_USD) AS Daily_GMV, 
    COUNT(*) AS Successful_Txn_Count
FROM Transactions
WHERE Status = 'captured'
GROUP BY transaction_date
ORDER BY transaction_date;

### Result Summary
transaction_date	Daily_GMV	Successful_Txn_Count
2026-03-01T00:00:00.000Z	26382	5
2026-03-02T00:00:00.000Z	11080	3
2026-03-03T00:00:00.000Z	16031.5	4
2026-03-04T00:00:00.000Z	13920	4
2026-03-05T00:00:00.000Z	6136	1
2026-03-06T00:00:00.000Z	8806	2


## Q5 Merchants with Chargeback Ratio Above 1%
### Query
SELECT 
    Merchant_Name,
    (COUNT(CASE WHEN Status = 'chargeback' THEN 1 END) * 100.0 / COUNT(*)) AS Chargeback_Ratio
FROM Transactions
GROUP BY Merchant_Name
HAVING (COUNT(CASE WHEN Status = 'chargeback' THEN 1 END) * 100.0 / COUNT(*)) > 1.0;

### Result Summary
Merchant_Name	Chargeback_Ratio
Alpha Mart	9.090909090909092
Beta Stores	9.090909090909092
Eco Home	50
Delta Travels	25

## Q6 Regions with Average Risk Score > 50 and > 20 Transactions
### Query
SELECT 
    Gateway_Region, 
    AVG(Risk_Score) AS Avg_Risk_Score, 
    COUNT(*) AS Total_Txns
FROM Transactions
GROUP BY Gateway_Region
HAVING AVG(Risk_Score) > 50 AND COUNT(*) > 20;

### Result Summary
Gateway_Region	Avg_Risk_Score	Total_Txns
APAC	65.47619047619048	22


## Q7 Users with 3+ Failed/Chargeback Transactions on the Same Day
### Query
SELECT 
    User_Id, 
    transaction_date, 
    COUNT(*) AS Failed_Or_CB_Count
FROM Transactions
WHERE Status LIKE 'failed%' OR Status = 'chargeback'
GROUP BY User_Id, transaction_date
HAVING COUNT(*) >= 3;

### Result Summary
User_Id	transaction_date	Failed_Or_CB_Count
U008	2026-03-05T00:00:00.000Z	4

## Q8 Chargeback Summary by Merchant
### Query
SELECT 
    Merchant_Name, 
    COUNT(*) AS Chargeback_Count, 
    COUNT(DISTINCT User_Id) AS Unique_Affected_Users, 
    SUM(Amt_USD) AS Total_Chargeback_Amount
FROM Transactions
WHERE Status = 'chargeback'
GROUP BY Merchant_Name;

### Result Summary
Merchant_Name	Chargeback_Count	Unique_Affected_Users	Total_Chargeback_Amount
Alpha Mart	1	1	5400
Beta Stores	1	1	1711
Eco Home	1	1	6649
Delta Travels	1	1	2500
