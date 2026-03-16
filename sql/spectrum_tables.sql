
CREATE EXTERNAL SCHEMA spectrum
FROM DATA CATALOG
DATABASE 'air_quality_db'
IAM_ROLE 'redshift-spectrum-role'
CREATE EXTERNAL DATABASE IF NOT EXISTS;

CREATE EXTERNAL TABLE spectrum.air_quality (
location_id INT,
parameter VARCHAR(20),
value FLOAT,
measurement_time TIMESTAMP
)
PARTITIONED BY (year INT, month INT, day INT)
STORED AS PARQUET
LOCATION 's3://openaq-data-shubham/processed/openaq/';
