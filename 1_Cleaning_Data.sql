----------- Error Documentation --------

-- 1. Merging Datasets
-- No datasets were merged in this case, as there is only a single table being analyzed.

-- 2. Removing Unnecessary Data
-- No columns removed: All columns are considered relevant for analysis.

-- 3. Data Type Conversion
-- Action Taken: No changes to data types, as all columns already have proper data types. However, Quantity was cast to int for consistency.

-- 4. Handling Missing Data
-- Identified Missing Data:
-- Found missing values in Description and CustomerID.
-- Action Taken:
-- Replaced missing Description values with 'Unknown'.
-- Removed rows where CustomerID was missing.
-- Retained rows even if Description was missing (replaced with 'Unknown'), but removed rows with CustomerID as it's critical for analysis.

-- 5. Removing Duplicates
-- Action Taken: Found and removed duplicates based on the combination of InvoiceNo, StockCode, Quantity, UnitPrice, and CustomerID.
-- Used row numbering to identify and remove duplicates, keeping only the first occurrence.

-- 6. Checking for Structural Errors
-- No issues found: No typos, extra spaces, or other structural errors in the columns, as confirmed.

-- 7. Standardization/Normalization
-- Action Taken: No additional standardization needed as the data is already in a consistent format.

-- 8. Handling Outliers

-- Quantity: Removed rows where Quantity was 0 or negative, as they do not make sense for analysis.
-- UnitPrice: Removed rows with non-positive (<= 0) UnitPrice, as these values are invalid for pricing analysis.
-- Final Cleaned Data View

-- Created a cleaned data view (cleaned_online_retail_data_view) with all adjustments applied, ready for further analysis.






-- # Removing Irrelevant Data

-- We don't need to remove any specific column here as all columns seem relevant for analysis.


-- # Converting Data Types

-- There's no need to change data types, all the columns already have proper datatypes.


SELECT 
    InvoiceNo,
    StockCode,
    Description,
    CAST(Quantity AS int) AS Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM [Online Retail_CSV];



-- # Handling missing Data

-- 1. Identifying missing data

WITH cte1 AS (
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    CAST(Quantity AS int) AS Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM [Online Retail_CSV]
)
SELECT 
    COUNT(*) AS total_rows, 
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS missing_InvoiceNo,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS missing_StockCode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS missing_Description,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS missing_Quantity,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS missing_InvoiceDate,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS missing_UnitPrice,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_CustomerID,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS missing_Country
FROM cte1


-- Observation: There are missing values in Description and CustomerID
-- Checking if there's any pattern to the missing data to find the root cause behind it.  
-- There's no pattern to missing data and based on the context we can move to next stage of handling these dataset. 


-- 2. Handling Null and Missing Values

-- Replaced missing values of 'Description' column with Unknown, 
-- Removed rows with missing CustomerID, 
-- Removed the rows where price is missing or is 0 or less.


SELECT 
    InvoiceNo,
    StockCode,
    COALESCE(Description, 'Unknown') AS Description,
    CAST(Quantity AS int) AS Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM [Online Retail_CSV]
WHERE CustomerID IS NOT NULL


-- # Removing duplicates

WITH without_missing_data AS (
SELECT 
    InvoiceNo,
    StockCode,
    COALESCE(Description, 'Unknown') AS Description,
    CAST(Quantity AS int) AS Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM [Online Retail_CSV]
WHERE CustomerID IS NOT NULL
), without_duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Quantity, UnitPrice, CustomerID ORDER BY InvoiceNo ASC) AS rn
    FROM without_missing_data 
)
SELECT *
FROM without_duplicates
WHERE rn = 1


-- # Fixing structural errors

-- There are not typos and extra spaces in the brand or event_type column


-- # Standerdize/Normalize Data                          

-- There are no columns to be standardized 



-- # Dealing with outliers


-- Removed negative or 0 quantity
-- Removed negative or 0 UnitPrice


GO
CREATE VIEW cleaned_online_retail_data_view AS
WITH without_missing_data AS (
SELECT 
    InvoiceNo,
    StockCode,
    COALESCE(Description, 'Unknown') AS Description,
    CAST(Quantity AS int) AS Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM [Online Retail_CSV]
WHERE 
    CustomerID IS NOT NULL AND
    Quantity > 0 AND
    UnitPrice > 0
), without_duplicates AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Quantity, UnitPrice, CustomerID ORDER BY InvoiceNo ASC) AS rn
    FROM without_missing_data 
)
SELECT InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM without_duplicates
WHERE rn = 1
GO 
