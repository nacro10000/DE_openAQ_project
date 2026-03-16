                +----------------------+
                |     dim_location     |
                |----------------------|
                | location_id (PK)     |
                | location             |
                | lat                  |
                | lon                  |
                +----------------------+
                         ^
                         |
                         |
+----------------------+ |   +----------------------+
|    fact_air_quality  |--+--|    dim_parameter     |
|----------------------|     |----------------------|
| location_id (FK)     |     | parameter (PK)       |
| parameter (FK)       |     | units                |
| measurement_time     |     +----------------------+
| value                |
+----------------------+
         |
         |
         v
                +----------------------+
                |       dim_date       |
                |----------------------|
                | date (PK)            |
                | year                 |
                | month                |
                | day                  |
                +----------------------+

         |
         | Derived Aggregates
         v

+----------------------+   +----------------------+   +----------------------+
|      agg_daily       |   |     agg_monthly      |   |      agg_hourly      |
|----------------------|   |----------------------|   |----------------------|
| location, date       |   | location, month      |   | location, hour       |
| avg_pm25             |   | avg_co               |   | avg_pm25             |
| avg_co               |   | avg_so2              |   | mean_co              |
| avg_so2              |   | percentile_90        |   | median_co            |
+----------------------+   +----------------------+   | mean_so2             |
                                                      | median_so2           |
                                                      +----------------------+

                         +----------------------+
                         |   air_quality_index  |
                         |----------------------|
                         | country, hour        |
                         | index_level          |
                         +----------------------+
