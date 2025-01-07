# Cohort Retention Analysis on Online Retail Dataset

## Project Overview
This project aims to perform Cohort Retention Analysis on an online retail dataset to track user behavior and identify key trends in customer retention over time.  
By analyzing user cohorts based on their first purchase date, the project visualizes retention patterns, allowing businesses to understand how different customer segments behave after their first interaction with the platform.

Using SQL, the analysis filters and cleanses the dataset, performs cohort grouping, and calculates the retention rates for different cohorts.  
Power BI and Tableau are used to visualize these insights in an interactive heatmap for easy interpretation.

## Project Structure
The project is organized as follows:

1. **Data Cleaning**: A set of SQL queries to clean and preprocess the raw dataset.
2. **Cohort Retention Calculation**: SQL queries to create cohort groups, track user activity, and calculate retention metrics.
3. **Data Visualization**: Power BI and Tableau are used to create an interactive heatmap that visualizes the retention rates of different customer cohorts.
4. **Insights and Conclusions**: A summary of the key insights derived from the cohort analysis.

## Tableau Visualization
You can explore the interactive Cohort Retention Heatmap created in Power BI and Tableau at the following links:  
[Cohort Retention Analysis - Power BI Report File](https://studentmesacin-my.sharepoint.com/:u:/g/personal/ayushfm19_student_mes_ac_in/EaR1Kd2nNm9EpLFC2qywYIABfXgIApeM68lLnHBDavu3kA?e=CZLFHY)

[Cohort Retention Analysis - Tableau Public](https://public.tableau.com/app/profile/ayush.singh3840/viz/CohortRetentionAnalysis_16878105860820/Dashboard1)



## Data Cleaning Process

1. **Remove Irrelevant Data**: Excluded rows that didn’t align with the business objective, like transactions without key details.
2. **Handle Missing Data**: Replaced missing Description values with 'Unknown' and removed rows with missing or zero CustomerID, Quantity, or UnitPrice.
3. **Remove Duplicates**: Used ROW_NUMBER() to eliminate duplicate transaction entries.
4. **Fix Structural Errors**: Corrected inconsistencies like typos, wrong capitalization, and naming issues.
5. **Convert Data Types**: Ensured correct types (e.g., Quantity as integer, InvoiceDate as DATETIME).
6. **Standardize/Normalize Data**: Made sure units and scales (e.g., price format, quantity) were consistent.
7. **Dealing with Outliers**: Removed outliers using the IQR method or investigated their cause.
8. **Validate Data**: Conducted final checks to ensure data consistency and completeness.

## Cohort Retention Calculation Process

1. **Create Cohorts**: Grouped customers based on the month and year of their first purchase to define each cohort.
2. **Track User Activity**: Joined cohort data with transaction details to track each customer's activity within their cohort, identifying the year and month of each order.
3. **Calculate Cohort Index**: Calculated the number of months since a customer's first purchase to create a cohort index representing their time in the cohort.
4. **Calculate Retention**: Pivoted cohort data to calculate retention rates for each cohort period, showing how many users from the original cohort made subsequent purchases.

## Key Insights & Findings
This section summarizes the key findings and trends from the Cohort Retention Analysis.

- **Retention Trends**: Retention drops sharply after Month 1, most cohorts lose 60–80% of users by Month 2.
- **High-Performing Cohorts**: 2010-12-01 cohort performs best, maintaining 50% retention by Month 12, far exceeding other cohorts.
- **Drop-off Points**: Later cohorts show weaker retention, Post-2011-07-01 cohorts often fall below 10% by Month 6.

- **Improvement Suggestionss**: 1. Improving Months 1–3 engagement is key to reducing churn and driving long-term growth. 2. Analyzing why 2010-12-01 performed well can guide future strategies.

