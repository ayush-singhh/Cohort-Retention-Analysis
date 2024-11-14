-- Points Required to do Cohort Retention Analysis
-- 1. Unique Identifier (CustomerID)
-- 2. Initial Start Date (First Invoice Date)
-- 3. User activity Data


-- Step 1: Creating Cohort Groups (View)
CREATE VIEW cohort_group_view AS
    -- Identify the first purchase date for each customer and create cohorts based on the month and year of their first purchase
    SELECT
        [CustomerID],
        MIN([InvoiceDate]) AS first_purchase_date,
        DATEPART(YEAR, MIN([InvoiceDate])) AS cohort_year,
        DATEPART(MONTH, MIN([InvoiceDate])) AS cohort_month
    FROM
        cleaned_online_retail_data_view
    GROUP BY
        [CustomerID];
GO

-- Step 2: Calculating User Activity (View)
CREATE VIEW user_activity_view AS
    -- Joining cohort groups with the original transaction data to identify customer activity within their cohort
    SELECT
        c.[CustomerID],
        c.cohort_year,
        c.cohort_month,
        DATEPART(YEAR, o.[InvoiceDate]) AS order_year,
        DATEPART(MONTH, o.[InvoiceDate]) AS order_month,
        order_year_diff = DATEPART(YEAR, o.[InvoiceDate]) - c.cohort_year,
        order_month_diff = DATEPART(MONTH, o.[InvoiceDate]) - c.cohort_month
    FROM
        cohort_group_view c
    LEFT JOIN
        cleaned_online_retail_data_view o ON c.[CustomerID] = o.[CustomerID];
GO

-- Step 3: Create Cohort Index and Cohort Table (View)
CREATE VIEW cohort_table_view AS
    -- Calculate a cohort index (period index) representing the number of months since the cohort's first purchase
    SELECT 
        DISTINCT c.[CustomerID] AS customer_number,
        DATEFROMPARTS(c.cohort_year, c.cohort_month, 1) AS cohort_date,
        (DATEPART(YEAR, o.[InvoiceDate]) - c.cohort_year) * 12 + DATEPART(MONTH, o.[InvoiceDate]) - c.cohort_month + 1 AS cohort_index_akaPeriod
    FROM 
        cohort_group_view c
    LEFT JOIN 
        cleaned_online_retail_data_view o ON c.[CustomerID] = o.[CustomerID];
GO

-- Step 4: Pivot and Calculate Retention
SELECT * 
FROM cohort_table_view
PIVOT 
(
    COUNT(customer_number)
    FOR cohort_index_akaPeriod 
    IN (
        [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13]
    )
) AS pivot_table
ORDER BY cohort_date;
