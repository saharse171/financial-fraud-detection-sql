# Financial Fraud Detection Database

A financial fraud monitoring database built with SQL as the final project for Harvard University's **CS50's Introduction to Databases with SQL**.

## Project Overview

This project is a relational database designed to organize and analyze financial transaction data and identify **potentially suspicious activity** for further investigation.

The database models customers, financial accounts, merchants, transaction locations, transactions, and fraud alerts.

The system does not attempt to prove that fraud has occurred. Instead, it uses structured data and predefined indicators to help investigators identify transactions that may require additional review.

## Key Features

* Relational database design using SQL
* Customers and multiple financial accounts
* Financial transaction tracking
* Merchant and geographic information
* Fraud alert management
* Risk levels: Low, Medium, and High
* Investigation statuses: Open, Investigating, and Resolved
* SQL queries for fraud monitoring and analysis
* Database indexes for commonly queried fields
* A view for reviewing potentially suspicious transactions
* Data integrity using primary keys, foreign keys, `NOT NULL`, and `CHECK` constraints

## Database Structure

The database contains six main entities:

* **Customers** — stores customer information
* **Accounts** — stores financial account information
* **Merchants** — stores merchant information
* **Locations** — stores transaction locations
* **Transactions** — stores financial transactions
* **Fraud Alerts** — stores potential fraud indicators and investigation status

### Entity Relationship Diagram

![Entity Relationship Diagram](er_diagram.png)

## Example Analysis

The database supports queries such as:

* Finding unusually large transactions
* Identifying high-risk fraud alerts
* Finding customers associated with suspicious activity
* Identifying merchants associated with the most fraud alerts
* Finding accounts with unusually high transaction activity
* Comparing completed transactions with the average transaction amount
* Finding open high-risk alerts requiring investigation

## Technologies

* SQL
* SQLite
* Relational Database Design
* Database Indexing
* SQL Views
* Primary and Foreign Keys
* Data Integrity Constraints

## Project Files

| File             | Description                                     |
| ---------------- | ----------------------------------------------- |
| `schema.sql`     | Database schema, constraints, indexes, and view |
| `queries.sql`    | SQL queries for financial and fraud analysis    |
| `DESIGN.md`      | Detailed database design documentation          |
| `er_diagram.png` | Entity relationship diagram                     |

## Course

This project was developed as the final project for:

**CS50's Introduction to Databases with SQL — Harvard University**

## Project Video

[Watch the project walkthrough on YouTube](https://youtu.be/SgOXP270zv8)

## Portfolio Context

This project demonstrates practical skills in:

**SQL · Database Design · Data Analysis · Financial Analytics · Risk Monitoring**

It complements my Python-based **Financial Data Analyzer** project by demonstrating database design and SQL skills applied to a financial domain.
