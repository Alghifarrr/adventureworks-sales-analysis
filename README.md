# Sales Performance Analysis & Dashboard

An end-to-end data analytics project using PostgreSQL, SQL, and Power BI to analyze sales performance across time, customers, locations, and order values.

## 📊 Dashboard Preview

<img width="1000" alt="Sales Performance Dashboard" src="https://github.com/user-attachments/assets/b3add4c1-a82f-492d-82eb-bf925f48a792" />

## 🛠️ Tools

- PostgreSQL
- SQL
- Power BI
- DAX

## 📂 Dataset

This project uses the AdventureWorks 2014 dataset.

The dataset consists of three CSV files:

- AdventureWorks_CustomerMaster.csv
- AdventureWorks_SalesOrderHeader.csv
- AdventureWorks_VendorMaster.csv

The data was imported into PostgreSQL for data preparation and analysis.

## 🔄 Data Preparation

The main data preparation steps included:

- Creating relational tables
- Importing CSV data into PostgreSQL
- Handling NULL values
- Converting date fields into DATE format
- Validating relationships between sales and address data

## 🔍 Analysis

The project analyzes:

- Overall sales performance
- Sales trends over time
- Top customers by sales
- Top cities by sales
- Order value distribution
- Shipping performance
- Tax and freight
- Data quality

## 📊 Power BI Dashboard

The dashboard contains:

### KPIs
- Total Sales
- Total Orders
- Customers
- Average Order Value

### Visualizations
- Sales Trend Over Time
- Top 10 Cities by Sales
- Top 10 Customers by Sales
- Orders by Order Type

### Filters
- Year
- Month
- City

## 🔗 Database Relationship

The main relationship used in the analysis is:

sales_order → address

through:

ShipToAddressID → AddressID

This relationship allows sales to be analyzed by city, province/state, and country.

## 📁 Project Structure

sales-performance/
│
├── README.md
├── data/
│   ├── AdventureWorks_CustomerMaster.csv
│   ├── AdventureWorks_SalesOrderHeader.csv
│   └── AdventureWorks_VendorMaster.csv
├── sql/
│   └── sales_performance.sql
└── powerbi/
    └── Sales_Performance.pbix

## 🎯 Key Questions

- What is the overall sales performance?
- Which customers generate the highest sales?
- Which cities generate the highest sales?
- How does sales change over time?
- What is the distribution of order values?
- How long does it take to ship orders?

## 🚀 Future Improvements

- Year-over-Year sales analysis
- Customer segmentation
- Additional shipping KPIs
- More advanced sales insights

## 👤 Author

**Rafi Ahmad Alghifari**

Aspiring Data Analyst interested in SQL, Python, Data Visualization, and Business Intelligence.
