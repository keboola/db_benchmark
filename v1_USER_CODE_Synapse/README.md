# Sample DB benchmark

- DWH: DW100 & DW1500

## Files

- `001_Synapse_DDL.sql` - Tables creation
- `002_Synapse_data_load.sql` - Data loading
- `003_Synapse_cache_warmup.sql` - Cache Warmup
- `004_Synapse_queries_cpu.sql` - Queries doing (mostly) computation (cpu)

## Quick Results

| SIZE / DWH  | DW1500 | DW100 |
| --- | ---: | ---: |
| SELECT w/ LIMIT |  |  |
| CREATE TABLE |  |  |
