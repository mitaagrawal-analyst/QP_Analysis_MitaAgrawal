\#Spreadsheet Answers



\## Cleaning Steps

1. Standardize Text \& Remove Whitespace
2. Handling missing values
3. Convert data types to standard form
4. Fix data inconsistency



\## Standardisation rules

1. Case consistency
2. Text alignment \& blank or white space removal
3. Date format is standard
4. Unit or currency standardisation


\## Lookup \& enrichment logic

1. Using formulas like XLOOKUP, VLOOKUP, HLOOKUP, INDEX \& MATCH using a primary key
2. Enriching data by adding categories e.g merchants
3. Flagging risk \& status



\## Final Answers

1. Total raw rows - 30
2. Total cleaned rows - 30
3. Invalid or missing rows handled - 1
4. Top region by GMV - India 80298
5. Number of high value transactions - 7
6. Number of high risk transactions - 9
7. Top merchant by captured GMV - Beta Stores 41782



\## Formula Samples

Clean the raw transaction data

* standardize merchant names : using syntax =TRIM(PROPER(C2)) to remove spaces \& change words to sentence case
* standardize date formats : select date column \& in number tab select custom date international format YYYY/MM/DD
* standardize status values : use syntax =TRIM(LOWER(I2)) to remove spaces \& change words to lower case
* standardize risk scores : in column next column write number \& press Ctrl + E to fill the numbers extracted as this command copies the pattern
* standardize gateway regions : Use syntax =TRIM(UPPER(M2)) to remove spaces \& change words to upper case.
* convert transaction amounts into a single reporting currency using exchange\_rates.csv : in exchange\_rates.csv file create a column to join date \& currency combination, now match this with same combination in main file to fetch exchange rate. Multiply it with raw amount as amount\_USD to standardise the values
* enrich the transactions using merchant\_master.csv : use merchants data with vlookup to fill missing gateways for merchants.



2. create the following flags:
* high\_value\_flag : use syntax =IFS(AND(O2="APAC",H2>5000),1,AND(O2="EU",H2>6000),1,AND(O2="US",H2>7000),1,TRUE,0) to check conditions based on different currencies as per given condition \& flag them as 1 meaning high value
* high\_risk\_flag : use syntax =IF(OR(L2>=70, ISNUMBER(SEARCH("chargeback", J2))), 1, 0) to check any one condition \& flag as high risk



3. Merchant summary : from the cleaned file create a pivot to make summary of merchants. High value merchants with average transaction value. High rish merchants based on different payment methods

