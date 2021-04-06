--
--
-- INCREMENTAL IMPORT ABS -> SYNAPSE
--
--

--destination (final) table
CREATE TABLE [lineitems_final] (
    [L_ORDERKEY]      nvarchar(4000) NOT NULL DEFAULT NULL,
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
    [_timestamp]      datetime2,
    PRIMARY KEY NONCLUSTERED ("L_ORDERKEY") NOT ENFORCED
);

--staging HEAP table
CREATE TABLE [lineitems_tmp] (
    [L_ORDERKEY]      nvarchar(4000) NOT NULL DEFAULT NULL,
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
    WITH (HEAP);

-- load from ABS
COPY INTO [lineitems_tmp] FROM 'https://keboolabenchmark.blob.core.windows.net/padak/CSV/FILE_10M/TPCH_SF10/*.csv.gz'
WITH
    (
        FILE_TYPE='CSV',
        CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET = '?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacx&se=2020-12-17T06:38:09Z&st=2020-11-16T22:38:09Z&spr=https&sig=xxx'),
        FIELDQUOTE='"',
        FIELDTERMINATOR =',',
        ENCODING = 'UTF8',
        ROWTERMINATOR ='0x0A',
        IDENTITY_INSERT = 'OFF' ,
        FIRSTROW =2
    );

--dedup HEAP table
CREATE TABLE [lineitems_dedupe] (
    [L_ORDERKEY]      nvarchar(4000) NOT NULL DEFAULT NULL,
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
    WITH (HEAP);

-- dedupe data
INSERT INTO
    [lineitems_dedupe] ([L_ORDERKEY], [L_PARTKEY], [L_SUPPKEY], [L_LINENUMBER], [L_QUANTITY],
                        [L_EXTENDEDPRICE], [L_DISCOUNT], [L_TAX], [L_RETURNFLAG], [L_LINESTATUS],
                        [L_SHIPDATE], [L_COMMITDATE], [L_RECEIPTDATE], [L_SHIPINSTRUCT], [L_SHIPMODE], [L_COMMENT])
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
    FROM [lineitems_tmp]) AS a
WHERE
    a."_row_number_" = 1;

-- UPSERT final table + timestamp
UPDATE [lineitems_final]
SET
    [L_ORDERKEY]        = COALESCE([src].[L_ORDERKEY], ''), 
    [L_PARTKEY]         = COALESCE([src].[L_PARTKEY], ''),
    [L_SUPPKEY]         = COALESCE([src].[L_SUPPKEY], ''), 
    [L_LINENUMBER]      = COALESCE([src].[L_LINENUMBER], ''),
    [L_QUANTITY]        = COALESCE([src].[L_QUANTITY], ''), 
    [L_EXTENDEDPRICE]   = COALESCE([src].[L_EXTENDEDPRICE], ''),
    [L_DISCOUNT]        = COALESCE([src].[L_DISCOUNT], ''), 
    [L_TAX]             = COALESCE([src].[L_TAX], ''),
    [L_RETURNFLAG]      = COALESCE([src].[L_RETURNFLAG], ''), 
    [L_LINESTATUS]      = COALESCE([src].[L_LINESTATUS], ''),
    [L_SHIPDATE]        = COALESCE([src].[L_SHIPDATE], ''), 
    [L_COMMITDATE]      = COALESCE([src].[L_COMMITDATE], ''),
    [L_RECEIPTDATE]     = COALESCE([src].[L_RECEIPTDATE], ''), 
    [L_SHIPINSTRUCT]    = COALESCE([src].[L_SHIPINSTRUCT], ''),
    [L_SHIPMODE]        = COALESCE([src].[L_SHIPMODE], ''), 
    [L_COMMENT]         = COALESCE([src].[L_COMMENT], ''),
    [_timestamp]        = '2020-12-18 15:06:35'
FROM [lineitems_dedupe] AS [src]
WHERE
        [lineitems_final].[L_ORDERKEY] = COALESCE([src].[L_ORDERKEY], '') AND
        (COALESCE(CAST([lineitems_final].[L_ORDERKEY] AS varchar), '')      != COALESCE([src].[L_ORDERKEY], '') OR
         COALESCE(CAST([lineitems_final].[L_PARTKEY] AS varchar), '')       != COALESCE([src].[L_PARTKEY], '') OR
         COALESCE(CAST([lineitems_final].[L_SUPPKEY] AS varchar), '')       != COALESCE([src].[L_SUPPKEY], '') OR
         COALESCE(CAST([lineitems_final].[L_LINENUMBER] AS varchar), '')    != COALESCE([src].[L_LINENUMBER], '') OR
         COALESCE(CAST([lineitems_final].[L_QUANTITY] AS varchar), '')      != COALESCE([src].[L_QUANTITY], '') OR
         COALESCE(CAST([lineitems_final].[L_EXTENDEDPRICE] AS varchar), '') != COALESCE([src].[L_EXTENDEDPRICE], '') OR
         COALESCE(CAST([lineitems_final].[L_DISCOUNT] AS varchar), '')      != COALESCE([src].[L_DISCOUNT], '') OR
         COALESCE(CAST([lineitems_final].[L_TAX] AS varchar), '')           != COALESCE([src].[L_TAX], '') OR
         COALESCE(CAST([lineitems_final].[L_RETURNFLAG] AS varchar), '')    != COALESCE([src].[L_RETURNFLAG], '') OR
         COALESCE(CAST([lineitems_final].[L_LINESTATUS] AS varchar), '')    != COALESCE([src].[L_LINESTATUS], '') OR
         COALESCE(CAST([lineitems_final].[L_SHIPDATE] AS varchar), '')      != COALESCE([src].[L_SHIPDATE], '') OR
         COALESCE(CAST([lineitems_final].[L_COMMITDATE] AS varchar), '')    != COALESCE([src].[L_COMMITDATE], '') OR
         COALESCE(CAST([lineitems_final].[L_RECEIPTDATE] AS varchar), '')   != COALESCE([src].[L_RECEIPTDATE], '') OR
         COALESCE(CAST([lineitems_final].[L_SHIPINSTRUCT] AS varchar), '')  != COALESCE([src].[L_SHIPINSTRUCT], '') OR
         COALESCE(CAST([lineitems_final].[L_SHIPMODE] AS varchar), '')      != COALESCE([src].[L_SHIPMODE], '') OR
         COALESCE(CAST([lineitems_final].[L_COMMENT] AS varchar), '')       != COALESCE([src].[L_COMMENT], ''))
         
;

/* Final INSERT INTO of the new rows follows here... */
