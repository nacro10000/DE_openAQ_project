
-- Top 5 cities with highest PM2.5 levels per day

SELECT
l.location_name,
DATE_TRUNC('day', f.measurement_time) AS day,
AVG(f.value) AS avg_pm25
FROM air_quality_dm.fact_air_quality f
JOIN air_quality_dm.dim_location l
ON f.location_id = l.location_id
WHERE f.parameter = 'pm25'
GROUP BY l.location_name, day
ORDER BY avg_pm25 DESC
LIMIT 5;
