# Full load from ABS to Synapse

- DWH: 
- DATA: LINEITEM table from [Snowflake](https://docs.snowflake.com/en/user-guide/sample-data-tpch.html)


## Files

- `001.Full_import_ABS_to_Synapse.sql` - Code

## Quick Results

### Synapse

| SIZE / DWH  | DW1500 | DW100 |
| --- | ---: | ---: |
| 6M rows | 39s | 79s |
| 60M rows | 61s | 416s |
| 600M rows | 400s | n/a |