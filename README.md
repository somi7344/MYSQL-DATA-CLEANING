# MYSQL-DATA-CLEANING
This is my first data cleaning project using MYSQL and i am happy with the outcome and hope for a greater achievements and improvements
## TABLE OF CONTENTS
- [PROJECT OVERVIEW](#project-overview)
- [DATA SOURCE](#data-source)
- [TOOLS](#tools)
- [DATA CLEANING/PREPARATION](data-cleaning/preparation)
- [DATA ANALYSIS](#data-analysis)
## PROJECT OVERVIEW
This project centers on data cleaning techniques applied to a Kaggle.com Finance dataset using MySQL. I have eliminated duplicates, standardized formats, and corrected erroneous values. These enhancements significantly improve data quality, ensuring reliable insights for analysis and fostering informed decision-making in future research initiatives.
### DATA SOURCE
The primary data used in this analysis is the Financials.csv dataset file,containing detailed information and sales/profits made by this particular company.
#### TOOLS
-SQL SERVER (used for the whole data cleaning)
#### DATA CLEANING/PREPARATION
- Data loading and inspection
- Handling missing values and duplicates
- Data cleaning and formatting
#### DATA ANALYSIS
Some intresting code used to change my date column to DATE type
````sql
SELECT `Date`, 
STR_TO_DATE(`Date`,'%m/%d/%Y')
FROM financials2;

UPDATE financials2 
SET `Date`= STR_TO_DATE(`Date`,'%m/%d/%Y');

ALTER TABLE financials2
MODIFY `Date` DATE ;

SELECT `Date` FROM financials2
WHERE `Date` IS NULL;
````
