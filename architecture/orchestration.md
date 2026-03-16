

+-------------------------------+
| Scheduler                     |
| (EventBridge cron)            |
| Run daily at 2 AM             |
+-------------------------------+
            |
            v
+-------------------------------+
| Workflow                      |
| (AWS Step Functions)          |
| openaq-data-pipeline          |
+-------------------------------+
            |
            v
+-------------------------------+
| ETL Processing                |
| (AWS Glue Job)                |
| glue_etl_openaq.py            |
+-------------------------------+
            |
            v
+-------------------------------+
| Metadata Update               |
| (Glue Crawler)                |
+-------------------------------+
            |
            v
+-------------------------------+
| Data Mart Load                |
| (Redshift SQL)                |
| load_into_datamart.sql        |
+-------------------------------+
