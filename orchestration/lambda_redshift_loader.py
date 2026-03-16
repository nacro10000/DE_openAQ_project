import psycopg2
import os

def lambda_handler(event, context):

    conn = psycopg2.connect(
        host=os.environ['REDSHIFT_HOST'],
        dbname=os.environ['DB_NAME'],
        user=os.environ['USER'],
        password=os.environ['PASSWORD'],
        port=5439
    )

    cursor = conn.cursor()

    sql = """
    INSERT INTO air_quality_dm.fact_air_quality
    SELECT
        location_id,
        parameter,
        measurement_time,
        value
    FROM spectrum.air_quality
    WHERE value IS NOT NULL;
    """

    cursor.execute(sql)
    conn.commit()

    cursor.close()
    conn.close()

    return {"status": "Data mart loaded"}
