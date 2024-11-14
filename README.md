
# Cohort Retention Analysis

## Overview

This project performs a cohort retention analysis on the **Online Retail** dataset. The analysis aims to track customer retention over time based on their first purchase (cohort) and the frequency of their subsequent orders. The output is visualized as a **Cohort Retention Heatmap** in **Tableau**, which provides insights into customer behavior and helps in understanding retention trends.

## Project Structure

- **SQL Queries**: 
  - **`cleaned_online_retail_data_view`**: Prepares the dataset by cleaning missing or invalid data and filtering out irrelevant records.
  - **Cohort Analysis**: Identifies customer cohorts based on their first purchase date and tracks retention across periods (monthly).
  - **Pivot Table**: The final cohort retention table is generated and ready for visualization.

- **Excel Table**: 
  - A cleaned version of the cohort retention data exported from SQL. This file can be imported into Tableau to create the heatmap.

- **Tableau Visualization**:
  - A **Cohort Retention Heatmap** in Tableau that visualizes customer retention over time by cohort period.

## Steps to Reproduce

### 1. SQL Queries (Cohort Calculation)

The SQL queries are designed to:
- Clean the data by removing invalid records and handling missing values.
- Group customers by their first purchase date (cohort).
- Calculate the retention for each cohort over the months following their first purchase.

The SQL script contains the following parts:
- **Cleaned Data View**: Filters and formats the raw data.
- **Cohort Grouping**: Creates cohort groups based on the first purchase date.
- **User Activity**: Tracks customer activity over time.
- **Cohort Index**: Generates a cohort period index representing months since the first purchase.
- **Cohort Table**: Prepares the data for pivoting and final output.

### 2. Export Data to Excel

After executing the SQL queries, the cohort data is exported to an Excel table. This table can be imported into Tableau for visualization. The Excel file contains:
- **CustomerID**: Unique identifier for each customer.
- **Cohort Date**: The month and year of the customer's first purchase.
- **Cohort Period**: The number of months since the first purchase (cohort period index).
- **Retention Count**: The number of customers who made subsequent purchases in each cohort period.

### 3. Tableau Visualization

The exported Excel table is used to create a **Cohort Retention Heatmap** in Tableau:
- **Rows**: Cohort Date (Month/Year of First Purchase)
- **Columns**: Cohort Period (Months since First Purchase)
- **Color**: Retention Count (Number of customers retained in each period)

### 4. Interpretation

The heatmap allows you to visually analyze customer retention patterns. High retention periods are represented by darker shades, and periods with significant drop-offs can be identified with lighter colors.

## How to Use

1. Clone or download this repository.
2. Run the SQL queries on your SQL Server to create the necessary views and tables.
3. Export the resulting cohort data to an Excel file.
4. Open Tableau and import the Excel file to create the cohort retention heatmap.
5. Analyze the heatmap to understand customer retention behavior over time.

## Prerequisites

- **SQL Server**: For executing the SQL queries.
- **Tableau**: For data visualization and heatmap creation.
- **Excel**: For exporting and formatting the cohort data.

## SQL Code Example

```sql
-- Example of creating the cohort group view
CREATE VIEW cohort_group_view AS
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
