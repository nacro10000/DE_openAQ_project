
# Architecture Overview

OpenAQ Data Source
        │
        ▼
S3 Raw Zone
        │
        ▼
AWS Glue ETL (CSV → Parquet)
        │
        ▼
S3 Processed Zone (Partitioned)
        │
        ▼
Glue Data Catalog
        │
        ▼
Redshift Spectrum
        │
        ▼
Redshift Data Mart
        │
        ▼
Analytics Queries
