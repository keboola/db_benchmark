/*
 Andrey way

 - STATS OFF
 - HASH DATA DIST
  DW1500:
    COPY: 
    DEDUPE+FINAL INSERT:
    ========
    TOTAL: 

 */

drop table lineitems_tmp_hash;
drop table lineitems_final_hash_ctas;
drop table lineitems_final_hash_ctas_orig;
drop table lineitems_final_hash_ctas_keboola;
drop table lineitems_final_hash_ctas_onlycoalesce;
drop table lineitems_final_hash_ctas_isnull;


/* dw1500 */

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
    ); --48s

CREATE TABLE [lineitems_final_hash_ctas_orig]
WITH
    ( DISTRIBUTION = HASH([L_ORDERKEY]))
AS
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
; --31s (1st run), 17s (2st run), 17s (3rd run)

CREATE TABLE [lineitems_final_hash_ctas_keboola]
WITH
    ( DISTRIBUTION = HASH([L_ORDERKEY]))
AS
SELECT
    CAST(COALESCE([L_ORDERKEY], '') as nvarchar(4000))      AS [L_ORDERKEY]
                                         , CAST(COALESCE([L_PARTKEY], '') as nvarchar(4000))       AS [L_PARTKEY]
                                         , CAST(COALESCE([L_SUPPKEY], '') as nvarchar(4000))       AS [L_SUPPKEY]
                                         , CAST(COALESCE([L_LINENUMBER], '') as nvarchar(4000))    AS [L_LINENUMBER]
                                         , CAST(COALESCE([L_QUANTITY], '') as nvarchar(4000))      AS [L_QUANTITY]
                                         , CAST(COALESCE([L_EXTENDEDPRICE], '') as nvarchar(4000)) AS [L_EXTENDEDPRICE]
                                         , CAST(COALESCE([L_DISCOUNT], '') as nvarchar(4000))      AS [L_DISCOUNT]
                                         , CAST(COALESCE([L_TAX], '') as nvarchar(4000))           AS [L_TAX]
                                         , CAST(COALESCE([L_RETURNFLAG], '') as nvarchar(4000))    AS [L_RETURNFLAG]
                                         , CAST(COALESCE([L_LINESTATUS], '') as nvarchar(4000))    AS [L_LINESTATUS]
                                         , CAST(COALESCE([L_SHIPDATE], '') as nvarchar(4000))      AS [L_SHIPDATE]
                                         , CAST(COALESCE([L_COMMITDATE], '''') as nvarchar(4000))  AS [L_COMMITDATE]
                                         , CAST(COALESCE([L_RECEIPTDATE], '') as nvarchar(4000))   AS [L_RECEIPTDATE]
                                         , CAST(COALESCE([L_SHIPINSTRUCT], '') as nvarchar(4000))  AS [L_SHIPINSTRUCT]
                                         , CAST(COALESCE([L_SHIPMODE], '') as nvarchar(4000))      AS [L_SHIPMODE]
                                         , CAST(COALESCE([L_COMMENT], '') as nvarchar(4000))       AS [L_COMMENT]
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
; --22s (1st run), 19.6s (2st run), 21.6s (3rd run)

CREATE TABLE [lineitems_final_hash_ctas_onlycoalesce]
WITH
    ( DISTRIBUTION = HASH([L_ORDERKEY]))
AS
SELECT
    COALESCE([L_ORDERKEY], '')      AS [L_ORDERKEY]
  , COALESCE([L_PARTKEY], '')       AS [L_PARTKEY]
  , COALESCE([L_SUPPKEY], '')       AS [L_SUPPKEY]
  , COALESCE([L_LINENUMBER], '')    AS [L_LINENUMBER]
  , COALESCE([L_QUANTITY], '')      AS [L_QUANTITY]
  , COALESCE([L_EXTENDEDPRICE], '') AS [L_EXTENDEDPRICE]
  , COALESCE([L_DISCOUNT], '')      AS [L_DISCOUNT]
  , COALESCE([L_TAX], '')           AS [L_TAX]
  , COALESCE([L_RETURNFLAG], '')    AS [L_RETURNFLAG]
  , COALESCE([L_LINESTATUS], '')    AS [L_LINESTATUS]
  , COALESCE([L_SHIPDATE], '')      AS [L_SHIPDATE]
  , COALESCE([L_COMMITDATE], '')    AS [L_COMMITDATE]
  , COALESCE([L_RECEIPTDATE], '')   AS [L_RECEIPTDATE]
  , COALESCE([L_SHIPINSTRUCT], '')  AS [L_SHIPINSTRUCT]
  , COALESCE([L_SHIPMODE], '')      AS [L_SHIPMODE]
  , COALESCE([L_COMMENT], '')       AS [L_COMMENT]
  , '2020-11-23 09:25:24'           AS [_timestamp]
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
; --24s (1st run), 21s (2nd run), 20.5s (3rd run)

CREATE TABLE [lineitems_final_hash_ctas_isnull]
WITH
    ( DISTRIBUTION = HASH([L_ORDERKEY]))
AS
SELECT
    ISNULL([L_ORDERKEY], '')      AS [L_ORDERKEY]
  , ISNULL([L_PARTKEY], '')       AS [L_PARTKEY]
  , ISNULL([L_SUPPKEY], '')       AS [L_SUPPKEY]
  , ISNULL([L_LINENUMBER], '')    AS [L_LINENUMBER]
  , ISNULL([L_QUANTITY], '')      AS [L_QUANTITY]
  , ISNULL([L_EXTENDEDPRICE], '') AS [L_EXTENDEDPRICE]
  , ISNULL([L_DISCOUNT], '')      AS [L_DISCOUNT]
  , ISNULL([L_TAX], '')           AS [L_TAX]
  , ISNULL([L_RETURNFLAG], '')    AS [L_RETURNFLAG]
  , ISNULL([L_LINESTATUS], '')    AS [L_LINESTATUS]
  , ISNULL([L_SHIPDATE], '')      AS [L_SHIPDATE]
  , ISNULL([L_COMMITDATE], '')    AS [L_COMMITDATE]
  , ISNULL([L_RECEIPTDATE], '')   AS [L_RECEIPTDATE]
  , ISNULL([L_SHIPINSTRUCT], '')  AS [L_SHIPINSTRUCT]
  , ISNULL([L_SHIPMODE], '')      AS [L_SHIPMODE]
  , ISNULL([L_COMMENT], '')       AS [L_COMMENT]
  , '2020-11-23 09:25:24'           AS [_timestamp]
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
; --27.5s (1st run), 17.9s (2nd run), 17.9s (3rd run)