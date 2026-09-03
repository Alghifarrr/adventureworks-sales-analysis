DROP TABLE IF EXISTS sales_order;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS vendor;

--------------------------------

-- CREATE TABLE --

CREATE TABLE address(
    Address_ID INT PRIMARY KEY,
    Address_Line1 VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(40) NOT NULL,
    Province_State VARCHAR(50) NOT NULL,
    CountryRegion_Code VARCHAR(10) NOT NULL,
    Country_Name VARCHAR(50) NOT NULL  
);

CREATE TABLE sales_order(
    SalesOrder_ID INT PRIMARY KEY,
    Order_Date VARCHAR(40) NOT NULL,
    Ship_Date VARCHAR(40) NOT NULL,
    Customer_ID INT NOT NULL,
    ShipToAddress_ID INT NOT NULL,
    BillToAddress_ID INT NOT NULL,
    Sub_Total NUMERIC NOT NULL,
    Tax_Amt NUMERIC NOT NULL,
    Freight NUMERIC NOT NULL,
    Total_Due NUMERIC NOT NULL
);

CREATE TABLE vendor(
    BusinessEntity_ID INT PRIMARY KEY,
    Account_Number VARCHAR(50) NOT NULL,
    Vendor_Name VARCHAR(50) NOT NULL,
    Address_Type VARCHAR(50) NOT NULL,
    Address_Line1 VARCHAR(100) NOT NULL,
    Address_Line2 VARCHAR(100),
    City VARCHAR(50) NOT NULL,
    Postal_Code VARCHAR(40) NOT NULL,
    Province_State VARCHAR(50) NOT NULL,
    Territory VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL
);


-- IMPORT DATA --

-- Run the following commands in psql terminal

-- \copy address FROM 'C:/Users/HP/Downloads/kodingan/DA/dataset/sales_performance/AdventureWorks_CustomerMaster.csv' DELIMITER ',' CSV HEADER;

-- \copy sales_order FROM 'C:/Users/HP/Downloads/kodingan/DA/dataset/sales_performance/AdventureWorks_SalesOrderHeader.csv' DELIMITER ',' CSV HEADER;

-- \copy vendor FROM 'C:/Users/HP/Downloads/kodingan/DA/dataset/sales_performance/AdventureWorks_VendorMaster.csv' DELIMITER ',' CSV HEADER;


-- DATA CLEANING --

UPDATE vendor
SET address_line2 = NULL
WHERE address_line2 = 'NULL';


ALTER TABLE sales_order
ALTER COLUMN Order_Date TYPE DATE
USING TO_DATE(Order_Date, 'MM/DD/YYYY');

ALTER TABLE sales_order
ALTER COLUMN Ship_Date TYPE DATE
USING TO_DATE(Ship_Date, 'MM/DD/YYYY');


-- DATA EXPLORATION --

SELECT COUNT(*) FROM address;

SELECT COUNT(*) FROM sales_order;

SELECT COUNT(*) FROM vendor;

SELECT * FROM address LIMIT 10;

SELECT * FROM sales_order LIMIT 10;

SELECT * FROM vendor LIMIT 10;


-- SALES ANALYSIS -- 

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(total_due), 2) AS total_sales,
    ROUND(AVG(total_due), 2) AS average_order_value,
    ROUND(MAX(total_due), 2) AS highest_order_value,
    ROUND(MIN(total_due), 2) AS lowest_order_value
FROM sales_order;


-- SHIPPING PERFORMANCE ANALYSIS --

SELECT 
    SalesOrder_ID,
    Customer_ID,
    Order_Date,
    Ship_Date,
    Ship_Date - Order_Date AS Shipping_Days
FROM sales_order
ORDER BY Shipping_Days ASC
LIMIT 5;

SELECT 
    SalesOrder_ID,
    Customer_ID,
    Order_Date,
    Ship_Date,
    Ship_Date - Order_Date AS Shipping_Days
FROM sales_order
ORDER BY Shipping_Days DESC
LIMIT 5;

SELECT 
    ROUND(AVG(Ship_Date - Order_Date), 2) AS average_shipping_days
FROM sales_order;

SELECT
    Ship_Date - Order_Date AS Shipping_Days,
    COUNT(*) AS Total_Orders
FROM sales_order
GROUP BY Shipping_Days
ORDER BY Shipping_Days;




-- CUSTOMER ANALYSIS --

SELECT
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM  sales_order;

SELECT
    Customer_ID,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Total_Due), 2) AS Total_Spending
FROM sales_order
GROUP BY Customer_ID
ORDER BY Total_Spending DESC
LIMIT 10;


-- TIME BASED SALES ANALYSIS --

SELECT
    DATE_TRUNC('month', Order_Date) AS Month,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Total_Due), 2) AS Total_Sales
FROM sales_order
GROUP BY Month
ORDER BY Month;


-- TAX ANALYSIS --

SELECT
    ROUND(SUM(Tax_Amt), 2) AS total_tax,
    ROUND(AVG(Tax_Amt), 2) AS average_tax,
    ROUND(MAX(Tax_Amt), 2) AS highest_tax
FROM sales_order;


-- FREIGHT ANALYSIS --

SELECT
    ROUND(SUM(Freight), 2) AS total_freight,
    ROUND(AVG(Freight), 2) AS average_freight,
    ROUND(MAX(Freight), 2) AS highest_freight
FROM sales_order;


-- SHIPPING VS ORDER VALUE  ANALYSIS --

SELECT
    CASE
        WHEN total_due < 1000 THEN 'Low Value'
        WHEN total_due < 5000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_category,
    COUNT(*) AS total_orders,
    ROUND(AVG(Total_Due), 2) AS average_total_due,
    ROUND(AVG(Freight), 2) AS average_freight
FROM sales_order
GROUP BY order_category
ORDER BY total_orders DESC;


-- LOCATION BASED ANALYSIS --

SELECT
    a.city,
    a.province_state,
    a.country_name,
    COUNT(s.salesorder_id) AS total_orders,
    ROUND(SUM(s.total_due), 2) AS total_sales
FROM sales_order s
JOIN address a
    ON s.shiptoaddress_id = a.address_id
GROUP BY
    a.country_name,
    a.city,
    a.province_state
ORDER BY total_sales DESC
LIMIT 10;


-- DATA QUALITY CHECK --

SELECT
    province_state,
    country_name,
    COUNT(*) AS total_address
FROM address
GROUP BY province_state, country_name
ORDER BY total_address DESC;


SELECT
    COUNT(*) AS total_sales_orders,
    COUNT(a.address_id) AS matched_addresses
FROM sales_order s
LEFT JOIN address a
    ON s.shiptoaddress_id = a.address_id;
