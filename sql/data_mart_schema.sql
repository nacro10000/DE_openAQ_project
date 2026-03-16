
CREATE SCHEMA IF NOT EXISTS air_quality_dm;

CREATE TABLE fact_air_quality (
location_id INT,
parameter VARCHAR(20),
measurement_time TIMESTAMP,
value FLOAT
)
DISTKEY(location_id)
SORTKEY(measurement_time);

CREATE TABLE dim_location AS
SELECT DISTINCT location_id, location, lat, lon
FROM spectrum.air_quality;

CREATE TABLE dim_parameter AS
SELECT DISTINCT parameter
FROM spectrum.air_quality;

CREATE TABLE dim_date AS
SELECT DISTINCT
measurement_time::date AS date,
EXTRACT(year FROM measurement_time) AS year,
EXTRACT(month FROM measurement_time) AS month,
EXTRACT(day FROM measurement_time) AS day
FROM spectrum.air_quality;
