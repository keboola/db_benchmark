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
- `007_Snowflake_results_cpu_io_LARGE.csv` - Results LARGE DWH (cpu+I/O)
- `008_Snowflake_results_cpu_io_XSMALL.csv` - Results XSMALL DWH (cpu+I/O) (might be affected by caches - tried to avoid it by cloning the database before running scripts, but results are still too good)

## Quick Results

| TYPE / DWH  | LARGE | XSMALL |
| --- | ---: | ---: | 
| SELECT w/ LIMIT | 181 |  |
| CREATE TABLE | 241 |  |