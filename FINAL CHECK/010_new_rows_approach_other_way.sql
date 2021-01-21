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

CREATE TABLE [lineitems_dst] (
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

CREATE TABLE [lineitems_inc] (
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


COPY INTO [lineitems_dst] FROM 'https://keboolabenchmark.blob.core.windows.net/padak/CSV/FILE_10M/TPCH_SF1/*.csv.gz'
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

COPY INTO [lineitems_inc] FROM 'https://keboolabenchmark.blob.core.windows.net/padak/CSV/FILE_10M/TPCH_SF10/*.csv.gz'
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

CREATE TABLE [lineitems_final_hash_ctas]
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
    FROM [lineitems_dst]) AS a
WHERE
    a."_row_number_" = 1
; --25s STATS_OFF, 28.2s STATS_ON



-- final UPDATE by the same amount of data (w/ & w/o PKEY)
UPDATE [lineitems_final_hash_ctas]
SET 
  --L_ORDERKEY        = src.L_ORDERKEY, 
  L_PARTKEY         = src.L_PARTKEY,
  L_SUPPKEY         = src.L_SUPPKEY, 
  L_LINENUMBER      = src.L_LINENUMBER,
  L_QUANTITY        = src.L_QUANTITY, 
  L_EXTENDEDPRICE   = src.L_EXTENDEDPRICE,
  L_DISCOUNT        = src.L_DISCOUNT, 
  L_TAX             = src.L_TAX,
  L_RETURNFLAG      = src.L_RETURNFLAG, 
  L_LINESTATUS      = src.L_LINESTATUS,
  L_SHIPDATE        = src.L_SHIPDATE, 
  L_COMMITDATE      = src.L_COMMITDATE,
  L_RECEIPTDATE     = src.L_RECEIPTDATE, 
  L_SHIPINSTRUCT    = src.L_SHIPINSTRUCT,
  L_SHIPMODE        = src.L_SHIPMODE, 
  L_COMMENT         = src.L_COMMENT,
  _timestamp        = '2020-12-18 15:06:35'
FROM lineitems_inc AS src
WHERE
        lineitems_final_hash_ctas.L_ORDERKEY = src.L_ORDERKEY 
        /* AND
        (lineitems_final_10pct.L_ORDERKEY      != src.L_ORDERKEY OR
         lineitems_final_10pct.L_PARTKEY       != src.L_PARTKEY OR
         lineitems_final_10pct.L_SUPPKEY       != src.L_SUPPKEY OR
         lineitems_final_10pct.L_LINENUMBER    != src.L_LINENUMBER OR
         lineitems_final_10pct.L_QUANTITY      != src.L_QUANTITY OR
         lineitems_final_10pct.L_EXTENDEDPRICE != src.L_EXTENDEDPRICE OR
         lineitems_final_10pct.L_DISCOUNT      != src.L_DISCOUNT OR
         lineitems_final_10pct.L_TAX           != src.L_TAX OR
         lineitems_final_10pct.L_RETURNFLAG    != src.L_RETURNFLAG OR
         lineitems_final_10pct.L_LINESTATUS    != src.L_LINESTATUS OR
         lineitems_final_10pct.L_SHIPDATE      != src.L_SHIPDATE OR
         lineitems_final_10pct.L_COMMITDATE    != src.L_COMMITDATE OR
         lineitems_final_10pct.L_RECEIPTDATE   != src.L_RECEIPTDATE OR
         lineitems_final_10pct.L_SHIPINSTRUCT  != src.L_SHIPINSTRUCT OR
         lineitems_final_10pct.L_SHIPMODE      != src.L_SHIPMODE OR
         lineitems_final_10pct.L_COMMENT       != src.L_COMMENT)
         */
;

/* 
implementuju jako WHERE podmínku do INSERTu 

-- delete existing (already updated) rows
DELETE [lineitems_inc]
WHERE
    EXISTS(
            SELECT * FROM [lineitems_inc] 
                WHERE [lineitems_inc].[L_ORDERKEY] = [lineitems_final_hash_ctas].[L_ORDERKEY]
          );
*/

-- adding new rows only
INSERT INTO
    [lineitems_final_hash_ctas] ([L_ORDERKEY], [L_PARTKEY], [L_SUPPKEY], [L_LINENUMBER], [L_QUANTITY],
                                                 [L_EXTENDEDPRICE], [L_DISCOUNT], [L_TAX], [L_RETURNFLAG],
                                                 [L_LINESTATUS], [L_SHIPDATE], [L_COMMITDATE], [L_RECEIPTDATE],
                                                 [L_SHIPINSTRUCT], [L_SHIPMODE], [L_COMMENT], [_timestamp]) (SELECT
                                                                                                                 [L_ORDERKEY]      AS [L_ORDERKEY]
                                                                                                               , [L_PARTKEY]       AS [L_PARTKEY]
                                                                                                               , [L_SUPPKEY]       AS [L_SUPPKEY]
                                                                                                               , [L_LINENUMBER]    AS [L_LINENUMBER]
                                                                                                               , [L_QUANTITY]      AS [L_QUANTITY]
                                                                                                               , [L_EXTENDEDPRICE] AS [L_EXTENDEDPRICE]
                                                                                                               , [L_DISCOUNT]      AS [L_DISCOUNT]
                                                                                                               , [L_TAX]           AS [L_TAX]
                                                                                                               , [L_RETURNFLAG]    AS [L_RETURNFLAG]
                                                                                                               , [L_LINESTATUS]    AS [L_LINESTATUS]
                                                                                                               , [L_SHIPDATE]      AS [L_SHIPDATE]
                                                                                                               , [L_COMMITDATE]    AS [L_COMMITDATE]
                                                                                                               , [L_RECEIPTDATE]   AS [L_RECEIPTDATE]
                                                                                                               , [L_SHIPINSTRUCT]  AS [L_SHIPINSTRUCT]
                                                                                                               , [L_SHIPMODE]      AS [L_SHIPMODE]
                                                                                                               , [L_COMMENT]       AS [L_COMMENT]
                                                                                                               , '2020-12-18 15:06:35'
FROM [lineitems_inc] AS [src]
WHERE         lineitems_final_hash_ctas.L_ORDERKEY != src.L_ORDERKEY 
);          