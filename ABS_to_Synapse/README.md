# Full load from ABS to Synapse

- DWH: 
- DATA: LINEITEM table from [Snowflake](https://docs.snowflake.com/en/user-guide/sample-data-tpch.html)


## Files

- `001.Full_import_ABS_to_Synapse.sql` - Code for full load to destination table
- `002.Inc_import_ABS_to_Synapse.sql` - Code for incremental load to destination table

## Quick Results

### Synapse

| SIZE / DWH  | DW1500 | DW100 |
| --- | ---: | ---: |
| Full 6M rows | 39s | 79s |
| Full 60M rows | 61s | 416s |
| Full 600M rows | 400s | n/a |
| Inc ?M to 6M rows | n/a | n/a |
| Inc ?M to 60M rows | n/a | n/a |
| Inc ?M to 600M rows | n/a | n/a |