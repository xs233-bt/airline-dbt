# Airline Data Warehouse
![DBT](https://img.shields.io/badge/dbt-data--build--tool-orange)
![AWS](https://img.shields.io/badge/AWS-Athena-yellow)
![Python](https://img.shields.io/badge/Python-ETL-blue)

### DBT + Apache Iceberg + AWS Athena Lakehouse

This project implements a **modern data engineering pipeline for airline operational analytics** using a lakehouse architecture on AWS.

The pipeline extracts operational data from a MySQL database, stores raw datasets in **Amazon S3 as Parquet files**, and transforms them using **DBT** into curated analytics tables stored as **Apache Iceberg tables**.

The resulting datasets support scalable analytics through **AWS Athena and BI dashboards**.

## Architecture

<img width="432" height="615" alt="{362EBA23-7761-4D9E-9588-38959C029A16}" src="https://github.com/user-attachments/assets/dd226188-c7e0-462f-b692-abf79a508f23" />


# Tech Stack

### Data Engineering

- Python
- SQL
- DBT

### Data Lake

- Amazon S3
- Apache Iceberg
- Parquet

### Analytics

- AWS Athena
- Power BI

### Libraries

- Pandas
- PyArrow
- Boto3

---

# Data Pipeline

Operational airline data is processed through the following pipeline:

1. Data is extracted from a **MySQL operational database** using a Python ETL pipeline with secure SSH tunneling.
2. The data is transformed into **Parquet format** using Pandas and PyArrow.
3. Raw datasets are stored in **Amazon S3 Bronze layer**.
4. **DBT models** transform raw operational data into analytics-ready tables.
5. **DBT `ref()` dependencies** are used to track model lineage and automatically manage upstream/downstream relationships.
6. **Apache Iceberg** manages the data lake tables.
7. **AWS Athena** queries the curated datasets.
8. **BI dashboards** consume the final analytics tables.

---

## DBT Lineage and Dependency Management

DBT manages model dependencies through `ref()` references, which automatically builds a directed acyclic graph (DAG) of transformations.

This enables:

- **Automatic lineage tracking** across transformation models
- **Dependency-aware execution**, ensuring upstream models run before downstream models
- **Reproducible data transformations** through version-controlled SQL models
- **Improved maintainability**, allowing schema changes in upstream models to propagate safely to downstream tables

# Data Model

The warehouse organizes operational airline data into analytics-ready tables.

Main entities include:

- Orders
- Claims
- Customers
- Vendors
- Equipment
- Invoices

These datasets are transformed using **DBT models** into curated tables that support operational analytics and financial reporting.

---

# DBT Lineage
                 raw_tables
                     │
                     ▼
              staging_models
      (stg_orders, stg_invoices)
                     │
                     ▼
            intermediate_models
              (stg_base_orders)
                     │
                     ▼
             aggregation_models
                (stg_claim_po)
                     │
                     ▼
               analytics_table
              (fact_claim_orders)

The DBT transformation layer organizes raw operational datasets into curated analytics tables.

# Repository Structure

```
airline-dbt/
│
├── models/
│   ├── staging/
│   └── marts/
│
├── macros/
├── snapshots/
├── tests/
│
├── docs/
│   └── architecture.png
│
├── dbt_project.yml
└── README.md
```


---

# Future Improvements

Possible enhancements include:

- Airflow orchestration for scheduled pipelines
- Incremental DBT models for large datasets
- Data quality validation with Great Expectations
- Real-time ingestion using Kafka

---

# Author

Neo Lu  
Business Intelligence Analyst / Data Engineer  

LinkedIn  
https://linkedin.com/in/shunci-lu-4b10171a8
