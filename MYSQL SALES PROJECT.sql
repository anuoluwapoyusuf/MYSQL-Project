CREATE DATABASE SALES;
USE SALES;
CREATE TABLE REPORT(
SALES_ID INT,
PRODUCT_ID INT,
CUSTOMER_NAME VARCHAR(225),
LOCATION VARCHAR(225),
SALESPERSON VARCHAR(225),
CUSTOMER_TYPE VARCHAR(225),
DATES DATETIME,
QUANTITY INT,
VALUE_IN_RUPIAH INT);
INSERT INTO REPORT(SALES_ID,PRODUCT_ID,CUSTOMER_NAME,LOCATION,SALESPERSON,CUSTOMER_TYPE,DATES,QUANTITY,VALUE_IN_RUPIAH)
VALUES(1,100,"Holiday Inn","Bandung","Gates","Hotel","2019-10-01 00:00:00",25,50000000),
(2,200,"McKinsey","Jakarta","Kristi","Corporate","2019-11-01 00:00:00",300,35000000),
(3,300,"Ritz Carlton","Jakarta","Oprah","Hotel","2019-12-01 00:00:00",40,65000000),
(4,100,"McD","Makassar","Mark","Restaurant","2018-10-01 00:00:00",60,85000000),
(5,200,"Sate Senayan","Bali","Mercy","Restaurant","2018-11-01 00:00:00",220,29000000),
(6,300,"Hypermart","Medan","Frans","Retail","2018-12-01 00:00:00",20,22000000),
(7,100,"Holiday Inn","Jakarta","Gates","Hotel","2016-10-01 00:00:00",29,58000000),
(8,200,"McD","Jakarta","Mark","Restaurant","2016-11-01 00:00:00",100,200000000),
(9,300,"Sate Senayan","Jakarta","Mercy","Resturant","2016-12-01 00:00:00",150,19000000),
(10,100,"Grand Hayat","Jakarta","Merry","Hotel","2017-10-01 00:00:00",33,58000000),
(11,200,"Microsoft","Jakarta","Kristi","Corporate","2017-11-01 00:00:00",22,40000000),
(12,300,"Google","Jakarta","William","Corporate","2017-12-01 00:00:00",150,18000000);
SELECT * FROM REPORT;
USE SALES;
CREATE TABLE PRODUCT(
PRODUCT_ID INT,
PRODUCT_NAME TEXT,
BRAND VARCHAR(225),
UoM TEXT);
INSERT INTO PRODUCT(PRODUCT_ID,PRODUCT_NAME,BRAND,UoM)
VALUES(100,"Illy Ground 250 Gr","Illy","Kg"),
(200,"Viktory Ground 500 Gr","Viktory","Kg"),
(300,"San Pellgrino Sparkling 500 MI","Water","Bottle"),
(400,"Mango Puree Sorbetto","Ice Cream","Kg");
SELECT * FROM PRODUCT;
SELECT * FROM REPORT;
-- Get the sales report where the value is greater than or equal to 30,000,000 and rank them from largest to smallest --
SELECT * FROM REPORT WHERE VALUE_IN_RUPIAH >= 30000000 ORDER BY VALUE_IN_RUPIAH DESC;
-- Get only the customer_name, customer_type, date, value, from the sales table and sort them by date(newest to oldest) --
SELECT CUSTOMER_NAME, CUSTOMER_TYPE, DATES, VALUE_IN_RUPIAH FROM REPORT ORDER BY DATES DESC;
-- From the above query(maintaining the arrangement), change the customer_type to channel temporarily --
SELECT CUSTOMER_NAME, CUSTOMER_TYPE AS CHANNELS, DATES, VALUE_IN_RUPIAH FROM REPORT ORDER BY DATES DESC;
-- Your manager wants to know who is the big contributor based on customer_type --
SELECT CUSTOMER_TYPE, VALUE_IN_RUPIAH FROM REPORT GROUP BY CUSTOMER_TYPE ORDER BY VALUE_IN_RUPIAH DESC;
-- Join the sales and product tabl in order to get more details about the products that have been sold --
SELECT * FROM REPORT INNER JOIN PRODUCT ON REPORT.PRODUCT_ID = PRODUCT.PRODUCT_ID ORDER BY VALUE_IN_RUPIAH DESC;
-- Using the qery above, a salesperson named kristi asked you to extract her records from 2017 to 2019 sorted from largest to smallest --
SELECT * FROM REPORT  INNER JOIN PRODUCT ON REPORT.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE DATES BETWEEN "2017-10-01" AND "2019-12-01" AND SALESPERSON="Kristi" ORDER BY VALUE_IN_RUPIAH DESC;
-- Get all th products and their corresponding sales information, if any --
SELECT PRODUCT.PRODUCT_NAME, PRODUCT.BRAND, REPORT.DATES, REPORT.QUANTITY, REPORT.VALUE_IN_RUPIAH FROM PRODUCT LEFT JOIN REPORT ON PRODUCT.PRODUCT_ID = REPORT.PRODUCT_ID;
-- Do data aggregation or summarization of the table and get the total_sales, average_sales, minimum_sales, maximum_sales --
SELECT COUNT(*) TOTAL_ROW,
SUM(VALUE_IN_RUPIAH) AS TOTAL_SALES,
AVG(VALUE_IN_RUPIAH) AS AVERAGE_SALES,
MIN(VALUE_IN_RUPIAH) AS SMALLEST_VALUE,
MAX(VALUE_IN_RUPIAH) AS BIGGEST_VALUE FROM REPORT;
-- Get the total quantity, total sales and total pricesold for each product in the databasetable --
SELECT PRODUCT.PRODUCT_NAME, 
COALESCE(SUM(QUANTITY),0) AS TOTAL_QUANTITY,
COALESCE (SUM(VALUE_IN_RUPIAH),0) AS TOTAL_SALES,
SUM(VALUE_IN_RUPIAH) / SUM(QUANTITY) AS PRICE FROM REPORT LEFT JOIN PRODUCT ON REPORT.PRODUCT_ID = PRODUCT.PRODUCT_ID GROUP BY PRODUCT.PRODUCT_NAME;
-- Summarize the data to sales report or trends on a yearly basis --
SELECT year(DATES) AS YEAR, SUM(VALUE_IN_RUPIAH) AS TOTAL_SALES FROM REPORT GROUP BY YEAR(DATES) ORDER BY YEAR(DATES) DESC;
