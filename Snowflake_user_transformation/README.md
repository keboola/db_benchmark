# Sample DB benchmark

- DWH: LARGE
- Location: https://keboola.west-europe.azure.snowflakecomputing.com/

## Files

- `001_Snowflake_DDL.sql` - Tables creation
- `002_Snowflake_data_load.sql` - Data loading
- `003_Snowflake_cache_warmup.sql` - Cache Warmup
- `004_Snowflake_queries_cpu.sql` - Queries doing (mostly) computation (cpu)
- `005_Snowflake_results_cpu.csv` - Results (cpu)
- `006_Snowflake_queries_cpu_io.sql` - Queries writing full resultsets to disk
- `007_Snowflake_results_cpu_io.csv` - Results (cpu+I/O)

## Quick Results

| TYPE / DWH  | LARGE | XSMALL |
| --- | ---: | ---: | 
| SELECT w/ LIMIT | 181 |  |
| CREATE TABLE | 241 |  |