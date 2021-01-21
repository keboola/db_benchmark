/*
 Andrey way

 - STATS OFF
 - HASH DATA DIST
  DW1500: 
    COPY: 31.9s
    DEDUPE+FINAL INSERT: 25s
    ========
    TOTAL: 56.9s

 - STATS ON
 - HASH DATA DIST
  DW1500: 
    COPY: 33.9s
    DEDUPE+FINAL INSERT: 28.2s
    ========
    TOTAL: 62.1s

 */

drop table lineitems_tmp_hash;
drop table lineitems_final_hash_ctas;

/* dw1500 (59.985.789 rows) */

ALTER DATABASE [benchmark]
SET auto_create_statistics OFF;

SELECT NAME,
       CASE
         WHEN is_auto_create_stats_on = 1 THEN 'Enabled.'
         ELSE 'Disabled'
       END AS 'Auto Creates statistics Status',
       CASE
         WHEN is_auto_update_stats_on = 1 THEN 'Enabled'
         ELSE 'Disabled'
       END AS 'Auto Update statistics Status'
FROM   sys.databases
WHERE  database_id > 4;

/* LOAD DATA */

CREATE TABLE [lineitems_tmp_hash] (
    [L_ORDERKEY]      nvarchar(4000) NOT NULL,
    [L_PARTKEY]       nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SUPPKEY]       nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_LINENUMBER]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_QUANTITY]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_EXTENDEDPRICE] nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_DISCOUNT]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_TAX]           nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_RETURNFLAG]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_LINESTATUS]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPDATE]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_COMMITDATE]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_RECEIPTDATE]   nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPINSTRUCT]  nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPMODE]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_COMMENT]       nvarchar(4000) NOT NULL DEFAULT NULL
)
WITH
    (   HEAP
    ,  DISTRIBUTION = HASH([L_ORDERKEY])
); 

COPY INTO [lineitems_tmp_hash] FROM 'https://keboolabenchmark.blob.core.windows.net/padak/CSV/FILE_10M/TPCH_SF10/*.csv.gz'
WITH
    (
        FILE_TYPE='CSV',
        CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET = '?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-01-22T18:28:10Z&st=2021-01-20T10:28:10Z&spr=https&sig=v2iAtTySRo4%2FiOCC9P9gZzdvKhHQFU7ije%2FC59%2FWCeg%3D'),
        FIELDQUOTE='"',
        FIELDTERMINATOR =',',
        ENCODING = 'UTF8',
        ROWTERMINATOR ='0x0A',
        IDENTITY_INSERT = 'OFF' ,
        FIRSTROW =2
    ); --31.9s STATS_OFF, 33.9s STATS_ON



CREATE TABLE [lineitems_final_old] (
    [L_ORDERKEY]      nvarchar(4000) NOT NULL,
    [L_PARTKEY]       nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SUPPKEY]       nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_LINENUMBER]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_QUANTITY]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_EXTENDEDPRICE] nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_DISCOUNT]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_TAX]           nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_RETURNFLAG]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_LINESTATUS]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPDATE]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_COMMITDATE]    nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_RECEIPTDATE]   nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPINSTRUCT]  nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_SHIPMODE]      nvarchar(4000) NOT NULL DEFAULT NULL,
    [L_COMMENT]       nvarchar(4000) NOT NULL DEFAULT NULL,
    [_timestamp]      datetime2
)
WITH
    (DISTRIBUTION = HASH([L_ORDERKEY])
); 

INSERT INTO
    [lineitems_final_old] ( [L_ORDERKEY]
                          , [L_PARTKEY]
                          , [L_SUPPKEY]
                          , [L_LINENUMBER]
                          , [L_QUANTITY]
                          , [L_EXTENDEDPRICE]
                          , [L_DISCOUNT]
                          , [L_TAX]
                          , [L_RETURNFLAG]
                          , [L_LINESTATUS]
                          , [L_SHIPDATE]
                          , [L_COMMITDATE]
                          , [L_RECEIPTDATE]
                          , [L_SHIPINSTRUCT]
                          , [L_SHIPMODE]
                          , [L_COMMENT]
                          , [_timestamp]) 
SELECT
    a.[L_ORDERKEY]
  , a.[L_PARTKEY]
  , a.[L_SUPPKEY]
  , a.[L_LINENUMBER]
  , a.[L_QUANTITY]
  , a.[L_EXTENDEDPRICE]
  , a.[L_DISCOUNT]
  , a.[L_TAX]
  , a.[L_RETURNFLAG]
  , a.[L_LINESTATUS]
  , a.[L_SHIPDATE]
  , a.[L_COMMITDATE]
  , a.[L_RECEIPTDATE]
  , a.[L_SHIPINSTRUCT]
  , a.[L_SHIPMODE]
  , a.[L_COMMENT]
  , '2020-11-23 09:25:24'                                   AS [_timestamp]
FROM
    (SELECT
         [L_ORDERKEY]
       , [L_PARTKEY]
       , [L_SUPPKEY]
       , [L_LINENUMBER]
       , [L_QUANTITY]
       , [L_EXTENDEDPRICE]
       , [L_DISCOUNT]
       , [L_TAX]
       , [L_RETURNFLAG]
       , [L_LINESTATUS]
       , [L_SHIPDATE]
       , [L_COMMITDATE]
       , [L_RECEIPTDATE]
       , [L_SHIPINSTRUCT]
       , [L_SHIPMODE]
       , [L_COMMENT]
       , ROW_NUMBER() OVER (PARTITION BY [L_ORDERKEY] ORDER BY [L_ORDERKEY]) AS "_row_number_"
    FROM [lineitems_tmp_hash]) AS a
WHERE
    a."_row_number_" = 1
; --25s STATS_OFF, 28.2s STATS_ON
