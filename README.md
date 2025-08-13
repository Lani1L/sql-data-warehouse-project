# Data Warehousing with SQL Server using Medallion Architecture

<img width="1027" height="523" alt="image" src="https://github.com/user-attachments/assets/1675cf08-b1c4-493c-8f3d-1ac4b79ce002" />



This project focuses on building a data warehouse in SQL Server based on the Medallion Architecture, which organizes data into three structured layers: Bronze, Silver, and Gold. This layered approach ensures data quality, scalability, and optimized performance for reporting and analytics.

Bronze Layer (Raw Data Layer)
The Bronze layer serves as the landing zone for raw, unprocessed data. In this project, data from CSV source files is ingested directly into the SQL Server database without modification. This preserves the original data for traceability and allows for reprocessing if needed.

Silver Layer (Cleaned & Standardized Data Layer)
In the Silver layer, raw data undergoes data cleansing, standardization, enrichment, and normalization. This stage ensures data consistency, removes errors, and applies business rules, making it ready for downstream consumption. The focus here is on improving data quality while maintaining detailed granularity.

Gold Layer (Business-Ready Layer)
The Gold layer contains fully transformed, aggregated, and business-ready data designed for reporting and analytics. Data in this layer is modeled using a Star Schema to optimize query performance and support business intelligence tools. It provides stakeholders with clean, reliable datasets for decision-making and advanced analytics.

By following the Medallion Architecture, this project ensures a clear separation of concerns, enabling better governance, maintainability, and scalability of the data warehouse.
