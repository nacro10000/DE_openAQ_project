-- load location dimension

INSERT INTO air_quality_dm.dim_location
SELECT DISTINCT
    location_id,
    location,
    lat,
    lon
FROM spectrum.air_quality;

-- load parameter dimension

INSERT INTO air_quality_dm.dim_parameter
SELECT DISTINCT
    parameter,
    units
FROM spectrum.air_quality;

-- load date dimension

INSERT INTO air_quality_dm.dim_date
SELECT DISTINCT
    measurement_time::date AS date,
    EXTRACT(year FROM measurement_time) AS year,
    EXTRACT(month FROM measurement_time) AS month,
    EXTRACT(day FROM measurement_time) AS day
FROM spectrum.air_quality;

-- load fact table

INSERT INTO air_quality_dm.fact_air_quality
SELECT
    location_id,
    parameter,
    measurement_time,
    value
FROM spectrum.air_quality
WHERE value IS NOT NULL;

