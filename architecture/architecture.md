This architecture outlines a scalable cloud-based data engineering pipeline designed to ingest, transform, and analyze Openaq dataset.

The pipeline enables:

-ingestion of large volumes of raw air quality measurements

-transformation of raw CSV files into analytics-optimized formats

-storage of partitioned datasets in a scalable data lake

-creation of a structured data mart for analytical workloads

-execution of SQL queries to generate insights

+---------------------------+
|   OpenAQ S3 Raw Data      |
+---------------------------+
              |
              v
+---------------------------+
|   AWS Glue ETL           |
|   (CSV → Parquet)         |
+---------------------------+
              |
              v
+---------------------------+
|   S3 Processed Zone       |
|   (Partitioned)           |
+---------------------------+
              |
              v
+---------------------------+
|   Glue Data Catalog       |
+---------------------------+
              |
              v
+---------------------------+
|   Redshift Spectrum       |
+---------------------------+
              |
              v
+---------------------------+
|   Redshift Data Mart      |
+---------------------------+
              |
              v
+---------------------------+
|   Analytics Queries       |
+---------------------------+
