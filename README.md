
# OpenAQ Air Quality Data Analytics Pipeline

This project demonstrates a modern AWS-based data engineering pipeline that ingests,
transforms, and analyzes global air quality measurements from the OpenAQ dataset.

Architecture:
OpenAQ → S3 Raw → AWS Glue ETL → S3 Processed (Parquet) → Glue Catalog → Redshift Spectrum → Redshift Data Mart

Key Features
- Data lake architecture
- PySpark ETL transformation
- Partitioned Parquet storage
- Redshift Spectrum external querying
- Star schema data mart
- Data quality checks
