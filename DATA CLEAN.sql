#DATA CLEANING

SELECT * 
FROM financials;

INSERT INTO fin2
SELECT * FROM financials;

SELECT * FROM fin2;


SELECT *,
row_number() OVER(PARTITION BY Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`) AS Row_num
FROM fin2;
 
SHOW COLUMNS FROM fin2;

WITH fin2_cte AS
(SELECT *,
row_number() OVER(PARTITION BY Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`) AS Row_num
FROM fin2
)
SELECT * FROM fin2_cte
WHERE Row_num > 1;

SELECT * FROM fin2
WHERE `Month Number` = 9;

CREATE TABLE `financials2` (
  `Segment` text,
  `Country` text,
  `Product` text,
  `Discount Band` text,
  `Units Sold` text,
  `Manufacturing Price` text,
  `Sale Price` text,
  `Gross Sales` text,
  `Discounts` text,
  `Sales` text,
  `COGS` text,
  `Profit` text,
  `Date` text,
  `Month Number` int DEFAULT NULL,
  `Month Name` text,
  `Year` int DEFAULT NULL,
  `Row_num`int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT * FROM financials2;


INSERT INTO financials2 
SELECT *,
row_number() OVER(PARTITION BY Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`) AS Row_num
FROM fin2;


SELECT DISTINCT Segment FROM financials2
WHERE Row_num > 1
ORDER BY Segment ASC;

SELECT *
FROM fin2
WHERE (Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`) IN (
    SELECT Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`
    FROM fin2
    GROUP BY Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
`Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, `Profit`, `Date`, `Month Number`, `Month Name`, `Year`
    HAVING COUNT(*) > 1
);

SELECT Segment, COUNT(*) AS count
FROM fin2
GROUP BY Segment
HAVING count > 1;

SELECT Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
       `Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, 
       `Profit`, `Date`, `Month Number`, `Month Name`, `Year`, 
       COUNT(*) AS count
FROM fin2
GROUP BY Segment, Country, Product, `Units Sold`, `Manufacturing Price`,
         `Sale Price`, `Gross Sales`, `Discounts`, `Sales`, `COGS`, 
         `Profit`, `Date`, `Month Number`, `Month Name`, `Year`
HAVING count > 1;
 
 SET SQL_SAFE_UPDATES = 0;

DELETE FROM financials2
WHERE Row_num > 1;

SELECT * FROM financials2;

--- STANDARDIZING
SELECT Segment,TRIM(Segment)
FROM financials2;

UPDATE financials2
SET Segment = TRIM(Segment);

SELECT Country , TRIM(Country)
FROM financials2;

UPDATE financials2
SET Country = TRIM(Country);

SELECT Country 
FROM financials2
ORDER BY 1;

SELECT Product , TRIM(Product)
FROM financials2;

UPDATE financials2
SET Product = TRIM(Product);

SELECT * FROM financials2;

SELECT `Discount Band`  , TRIM(`Discount Band`)
FROM financials2;

UPDATE financials2
SET `Discount Band` = TRIM(`Discount Band`);

SELECT  `Month Name` FROM financials2;

SELECT REPLACE(`Units Sold`, '$', '') AS amount_without_dollar
FROM financials2;

UPDATE financials2
SET `Units Sold` = REPLACE(`Units Sold`, '$', '');

SELECT CAST(REPLACE(`Units Sold`, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET `Units Sold` = REPLACE(REPLACE(`Units Sold`, '$', ''), ',', '');

SELECT * FROM financials2;

SHOW COLUMNS FROM financials2 LIKE 'Units Sold';

SELECT DISTINCT `Units Sold`
FROM financials2
WHERE `Units Sold` IS NULL;

SELECT `Units Sold`
FROM financials2
WHERE `Units Sold` NOT REGEXP '^[0-9]+$';

ALTER TABLE financials2
MODIFY `Units Sold` INT;

SELECT * FROM financials2;


SELECT REPLACE(`Manufacturing Price`, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET `Manufacturing Price` = REPLACE(`Manufacturing Price`, '$', '');

SELECT CAST(REPLACE(`Manufacturing Price`, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET `Manufacturing Price` = REPLACE(REPLACE(`Manufacturing Price`, '$', ''), ',', '');


SELECT DISTINCT  `Manufacturing Price`
FROM financials2
WHERE `Manufacturing Price` IS NULL;

ALTER TABLE financials2
MODIFY  `Manufacturing Price` INT;

SELECT * FROM financials2;

SELECT REPLACE(`Sale Price`, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET `Sale Price` = REPLACE(`Sale Price`, '$', '');

SELECT CAST(REPLACE(`Sale Price`, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET `Sale Price` = REPLACE(REPLACE(`Sale Price`, '$', ''), ',', '');


SELECT DISTINCT  `Sale Price`
FROM financials2
WHERE `Sale Price` IS NULL;

ALTER TABLE financials2
MODIFY  `Sale Price` INT;

SELECT * FROM financials2;



SELECT REPLACE(`Gross Sales`, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET `Gross Sales` = REPLACE(`Gross Sales`, '$', '');

SELECT CAST(REPLACE(`Gross Sales`, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET `Gross Sales`= REPLACE(REPLACE(`Gross Sales`, '$', ''), ',', '');


SELECT DISTINCT  `Gross Sales`
FROM financials2
WHERE `Gross Sales` IS NULL;

ALTER TABLE financials2
MODIFY  `Gross Sales` INT;

SELECT * FROM financials2;



SELECT REPLACE(`Discounts`, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET `Discounts`= REPLACE(`Discounts`, '$', '');

SELECT CAST(REPLACE(`Discounts`, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET`Discounts`= REPLACE(REPLACE(`Discounts`, '$', ''), ',', '');

SELECT CAST(REPLACE(`Discounts`, '-', '0') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET`Discounts`= REPLACE(REPLACE(`Discounts`, '-', '0'), ',', '');


SELECT `Discounts`
FROM financials2
;

ALTER TABLE financials2
MODIFY  `Discounts` INT;

SELECT * FROM financials2;



SELECT REPLACE(COGS, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET COGS = REPLACE(COGS, '$', '');

SELECT CAST(REPLACE(COGS, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET COGS= REPLACE(REPLACE(COGS, '$', ''), ',', '');


SELECT DISTINCT COGS
FROM financials2
WHERE COGS IS NULL;

ALTER TABLE financials2
MODIFY  COGS INT;

SELECT * FROM financials2;



SELECT REPLACE(Profit, '$', '') AS amount_without_dollar2
FROM financials2;

UPDATE financials2
SET Profit = REPLACE(Profit, '$', '');

SELECT CAST(REPLACE(Profit, '$', '') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET Profit= REPLACE(REPLACE(Profit, '$', ''), ',', '');

SELECT CAST(REPLACE(Profit, '-', '0') AS DECIMAL(10, 2)) AS amount
FROM financials2;

UPDATE financials2
SET Profit= REPLACE(REPLACE(`Discounts`, '-', '0'), ',', '');


SELECT Profit
FROM financials2
;

ALTER TABLE financials2
MODIFY  Profit INT;

SELECT * FROM financials2;

SELECT `Date`, 
STR_TO_DATE(`Date`,'%m/%d/%Y')
FROM financials2;

UPDATE financials2 
SET `Date`= STR_TO_DATE(`Date`,'%m/%d/%Y');

ALTER TABLE financials2
MODIFY `Date` DATE ;

SELECT `Date` FROM financials2
WHERE `Date` IS NULL;
 