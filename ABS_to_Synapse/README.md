# Full load from ABS to Synapse

- DWH: DW100 & DW1500
- DATA: LINEITEM table from (Snowflake)[https://docs.snowflake.com/en/user-guide/sample-data-tpch.html]


## Files

- `001.Full_import_ABS_to_Synapse.sql` - Code

## Quick Results

| TYPE / DWH  | LARGE | XSMALL |
| --- | ---: | ---: | 
| SELECT w/ LIMIT | 181 |  |
| CREATE TABLE | 241 |  |