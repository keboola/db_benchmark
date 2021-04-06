Legend and comments for `raw_queries.sql` file

SQL file contains 6 usecases. Each does following:
- create table from CSV
- load table into workspace (full load)
- upload data to Storage (full load)
- create table from CSV for incremental load
- load table into workspace (inc load)
- unload table from workspace (inc unload)

All 6 usecases are:
- SPK_NO_PK
- SPK_PK
- SPK_PK_DK
- MPK_NO_PK
- MPK_PK
- MPK_PK_DK

where
- SPK = Single Primary Key
- MPK = Multiple Primary Keys
- NO_PK without defined Primary Key
- PK = defined Primary Key (one or more)
- DK = defined distribution key

Internal note: 
- slack link https://keboola.slack.com/archives/CFVRE56UA/p1617693781251400
- raw file is not nicely formated, which I'm going to fix based on my priorities

Questions: petr@keboola.com