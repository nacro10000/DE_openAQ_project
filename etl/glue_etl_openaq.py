
#initialize glue and spark
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from pyspark.sql.functions import *

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

#input and output locations
input_path = "s3://openaq-data-shubham/raw/openaq/"
output_path = "s3://openaq-data-shubham/processed/openaq/"

#read csv data
df = spark.read .option("header", "true") .option("inferSchema", "true") .csv(input_path)

#convert datetime column to timestamp
df = df.withColumn(
"measurement_time",
to_timestamp(col("datetime"))
)

#cast numeric columns
df = df.withColumn("lat", col("lat").cast("double"))
df = df.withColumn("lon", col("lon").cast("double"))
df = df.withColumn("value", col("value").cast("double"))

#remove invalid records
df_clean = df.filter(col("value").isNotNull())

#create partition columns
df_partitioned = df_clean .withColumn("year", year(col("measurement_time"))) .withColumn("month", month(col("measurement_time"))) .withColumn("day", dayofmonth(col("measurement_time")))

# write partitioned parquet files
df_partitioned.write .mode("overwrite") .partitionBy("year", "month", "day") .parquet(output_path)
