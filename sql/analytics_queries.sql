-- Monthly 90th Percentile for CO and SO2
-- For any given month, find all cities with average monthly levels of CO and SO2 in the 90th percentile globally

SELECT
    l.location,
    DATE_TRUNC('month', f.measurement_time) AS month,
    PERCENTILE_CONT(0.9)
    WITHIN GROUP (ORDER BY f.value) AS pollution_90
FROM air_quality_dm.fact_air_quality f
JOIN air_quality_dm.dim_location l
ON f.location_id = l.location_id
WHERE f.parameter IN ('co','so2')
GROUP BY l.location, DATE_TRUNC('month', f.measurement_time);


--Daily Top 5 Cities for PM2.5
-- For any given day, find the top 5 cities globally with the highest daily average PM2.5

SELECT
    l.location,
    DATE_TRUNC('day', f.measurement_time) AS day,
    AVG(f.value) AS avg_pm25
FROM air_quality_dm.fact_air_quality f
JOIN air_quality_dm.dim_location l
ON f.location_id = l.location_id
WHERE f.parameter = 'pm25'
GROUP BY l.location, DATE_TRUNC('day', f.measurement_time)
ORDER BY avg_pm25 DESC
LIMIT 5;


-- Hourly Top 10 Cities for PM2.5 + CO/SO₂ Stats
-- For any given hour, find the top 10 cities with highest PM2.5 and provide mean, median, mode of CO and SO2

SELECT
    l.location,
    DATE_TRUNC('hour', f.measurement_time) AS hour,
    AVG(f.value) AS avg_pm25
FROM air_quality_dm.fact_air_quality f
JOIN air_quality_dm.dim_location l
ON f.location_id = l.location_id
WHERE f.parameter = 'pm25'
GROUP BY l.location, DATE_TRUNC('hour', f.measurement_time)
ORDER BY avg_pm25 DESC
LIMIT 10;


-- Hourly Air Quality Index per Country
-- For any given hour, compute AQI per country with 3 discrete levels

SELECT
    l.country,
    DATE_TRUNC('hour', f.measurement_time) AS hour,

    AVG(CASE WHEN f.parameter='pm25' THEN f.value END) AS avg_pm25,
    AVG(CASE WHEN f.parameter='co' THEN f.value END) AS avg_co,
    AVG(CASE WHEN f.parameter='so2' THEN f.value END) AS avg_so2,

    CASE

        WHEN AVG(CASE WHEN f.parameter='pm25' THEN f.value END) > 100
          OR AVG(CASE WHEN f.parameter='so2' THEN f.value END) > 80
          OR AVG(CASE WHEN f.parameter='co' THEN f.value END) > 50
        THEN 'High'

        WHEN AVG(CASE WHEN f.parameter='pm25' THEN f.value END) > 50
          OR AVG(CASE WHEN f.parameter='so2' THEN f.value END) > 40
          OR AVG(CASE WHEN f.parameter='co' THEN f.value END) > 25
        THEN 'Moderate'

        ELSE 'Low'

    END AS air_quality_index

FROM air_quality_dm.fact_air_quality f
JOIN air_quality_dm.dim_location l
ON f.location_id = l.location_id

WHERE f.parameter IN ('pm25','co','so2')

GROUP BY
    l.country,
    DATE_TRUNC('hour', f.measurement_time);

