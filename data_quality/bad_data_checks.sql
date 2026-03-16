
SELECT *
FROM spectrum.air_quality
WHERE value IS NULL;

CREATE TABLE bad_data_report AS
SELECT *
FROM spectrum.air_quality
WHERE value IS NULL;
