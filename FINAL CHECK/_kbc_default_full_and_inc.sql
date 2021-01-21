CREATE SCHEMA [in.c-tests-SAS-MASTER_KEY-HEAP4000];

CREATE SCHEMA [some.tests-SAS-MASTER_KEY-HEAP4000];

CREATE TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT] (
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

-- !!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!
-- FULL LOAD
-- !!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!

/* v_padak */
SELECT [object_id]
FROM sys.tables
WHERE schema_name(schema_id) = 'in.c-tests-SAS-MASTER_KEY-HEAP4000' AND NAME = 'MSFT';

SELECT [NAME] FROM sys.all_columns WHERE object_id = '291636232';
/* ^_padak */

CREATE TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc570d4c3b1_94205904] (
    [L_ORDERKEY]      nvarchar(4000),
    [L_PARTKEY]       nvarchar(4000),
    [L_SUPPKEY]       nvarchar(4000),
    [L_LINENUMBER]    nvarchar(4000),
    [L_QUANTITY]      nvarchar(4000),
    [L_EXTENDEDPRICE] nvarchar(4000),
    [L_DISCOUNT]      nvarchar(4000),
    [L_TAX]           nvarchar(4000),
    [L_RETURNFLAG]    nvarchar(4000),
    [L_LINESTATUS]    nvarchar(4000),
    [L_SHIPDATE]      nvarchar(4000),
    [L_COMMITDATE]    nvarchar(4000),
    [L_RECEIPTDATE]   nvarchar(4000),
    [L_SHIPINSTRUCT]  nvarchar(4000),
    [L_SHIPMODE]      nvarchar(4000),
    [L_COMMENT]       nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB);

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- IMPORT INTO STAGING TABLE
-- !!!!!!!!!!!!!!!!!!!!!!!!!
COPY INTO [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc570d4c3b1_94205904]
FROM 'https://zajcatest.blob.core.windows.net/testingcontainer/ExampleMSFT/csv.csv'
WITH
    (
        FILE_TYPE='CSV',
        CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2020-12-18T15:06:20Z&se=2020-12-18T16:06:20Z&sp=rwl&sig=FooReLjWBvO9n0K8aYRU6u8maxa5kn0SipUL%2FHyFFRk%3D'),
        FIELDQUOTE='"',
        FIELDTERMINATOR =',',
        ENCODING = 'UTF8',
        ROWTERMINATOR ='0x0A',
        IDENTITY_INSERT = 'OFF'
        , FIRSTROW =2
    );

/* v_padak */
SELECT COUNT(*) AS [count] FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc570d4c3b1_94205904];

SELECT [object_id]
FROM sys.tables
WHERE schema_name(schema_id) = 'in.c-tests-SAS-MASTER_KEY-HEAP4000' AND NAME = 'MSFT';

SELECT
    COL_NAME(ic.OBJECT_ID, ic.column_id) AS ColumnName
FROM
    sys.indexes AS i
        INNER JOIN
        sys.index_columns AS ic ON i.OBJECT_ID = ic.OBJECT_ID AND i.index_id = ic.index_id
WHERE
    i.is_primary_key = 1 AND i.OBJECT_ID = '291636232';
/* ^_padak */

CREATE TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc574210a17_30254247] (
    [L_ORDERKEY]      nvarchar(4000),
    [L_PARTKEY]       nvarchar(4000),
    [L_SUPPKEY]       nvarchar(4000),
    [L_LINENUMBER]    nvarchar(4000),
    [L_QUANTITY]      nvarchar(4000),
    [L_EXTENDEDPRICE] nvarchar(4000),
    [L_DISCOUNT]      nvarchar(4000),
    [L_TAX]           nvarchar(4000),
    [L_RETURNFLAG]    nvarchar(4000),
    [L_LINESTATUS]    nvarchar(4000),
    [L_SHIPDATE]      nvarchar(4000),
    [L_COMMITDATE]    nvarchar(4000),
    [L_RECEIPTDATE]   nvarchar(4000),
    [L_SHIPINSTRUCT]  nvarchar(4000),
    [L_SHIPMODE]      nvarchar(4000),
    [L_COMMENT]       nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB);

BEGIN TRANSACTION;

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- DEDUPLICATION
-- !!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO
    [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc574210a17_30254247] ([L_ORDERKEY], [L_PARTKEY],
                                                                                     [L_SUPPKEY], [L_LINENUMBER],
                                                                                     [L_QUANTITY], [L_EXTENDEDPRICE],
                                                                                     [L_DISCOUNT], [L_TAX],
                                                                                     [L_RETURNFLAG], [L_LINESTATUS],
                                                                                     [L_SHIPDATE], [L_COMMITDATE],
                                                                                     [L_RECEIPTDATE], [L_SHIPINSTRUCT],
                                                                                     [L_SHIPMODE], [L_COMMENT])
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
    FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc570d4c3b1_94205904]) AS a
WHERE a."_row_number_" = 1;

/* v_padak */
DELETE FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc570d4c3b1_94205904];

DELETE FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT];
/* ^_padak */

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- INSERT FINAL DATA
-- !!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO
    [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT] ([L_ORDERKEY], [L_PARTKEY], [L_SUPPKEY], [L_LINENUMBER], [L_QUANTITY],
                                                 [L_EXTENDEDPRICE], [L_DISCOUNT], [L_TAX], [L_RETURNFLAG],
                                                 [L_LINESTATUS], [L_SHIPDATE], [L_COMMITDATE], [L_RECEIPTDATE],
                                                 [L_SHIPINSTRUCT], [L_SHIPMODE], [L_COMMENT], [_timestamp]) (SELECT
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
                                                                                                               , CAST(COALESCE([L_COMMITDATE], '') as nvarchar(4000))    AS [L_COMMITDATE]
                                                                                                               , CAST(COALESCE([L_RECEIPTDATE], '') as nvarchar(4000))   AS [L_RECEIPTDATE]
                                                                                                               , CAST(COALESCE([L_SHIPINSTRUCT], '') as nvarchar(4000))  AS [L_SHIPINSTRUCT]
                                                                                                               , CAST(COALESCE([L_SHIPMODE], '') as nvarchar(4000))      AS [L_SHIPMODE]
                                                                                                               , CAST(COALESCE([L_COMMENT], '') as nvarchar(4000))       AS [L_COMMENT]
                                                                                                               , '2020-12-18 15:06:31'
FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc574210a17_30254247] AS [src]);

COMMIT;

/* v_padak */
DROP TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc574210a17_30254247];
/* ^_padak */

-- !!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!
-- INCREMENTAL LOAD
-- !!!!!!!!!!!!!!!!
-- !!!!!!!!!!!!!!!!

/* v_padak */
SELECT [object_id]
FROM sys.tables
WHERE schema_name(schema_id) = 'in.c-tests-SAS-MASTER_KEY-HEAP4000' AND NAME = 'MSFT';

SELECT [NAME] FROM sys.all_columns WHERE object_id = '291636232';
/* ^_padak */

CREATE TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314] (
    [L_ORDERKEY]      nvarchar(4000),
    [L_PARTKEY]       nvarchar(4000),
    [L_SUPPKEY]       nvarchar(4000),
    [L_LINENUMBER]    nvarchar(4000),
    [L_QUANTITY]      nvarchar(4000),
    [L_EXTENDEDPRICE] nvarchar(4000),
    [L_DISCOUNT]      nvarchar(4000),
    [L_TAX]           nvarchar(4000),
    [L_RETURNFLAG]    nvarchar(4000),
    [L_LINESTATUS]    nvarchar(4000),
    [L_SHIPDATE]      nvarchar(4000),
    [L_COMMITDATE]    nvarchar(4000),
    [L_RECEIPTDATE]   nvarchar(4000),
    [L_SHIPINSTRUCT]  nvarchar(4000),
    [L_SHIPMODE]      nvarchar(4000),
    [L_COMMENT]       nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB);

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- IMPORT INTO STAGING TABLE
-- !!!!!!!!!!!!!!!!!!!!!!!!!
COPY INTO [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314]
FROM 'https://zajcatest.blob.core.windows.net/testingcontainer/ExampleMSFT/csv.inc.csv'
WITH
    (
        FILE_TYPE='CSV',
        CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2020-12-18T15:06:20Z&se=2020-12-18T16:06:20Z&sp=rwl&sig=FooReLjWBvO9n0K8aYRU6u8maxa5kn0SipUL%2FHyFFRk%3D'),
        FIELDQUOTE='"',
        FIELDTERMINATOR =',',
        ENCODING = 'UTF8',
        ROWTERMINATOR ='0x0A',
        IDENTITY_INSERT = 'OFF'
        , FIRSTROW =2
    );

/* v_padak */
SELECT COUNT(*) AS [count] FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314];

SELECT [object_id]
FROM sys.tables
WHERE schema_name(schema_id) = 'in.c-tests-SAS-MASTER_KEY-HEAP4000' AND NAME = 'MSFT';

SELECT
    COL_NAME(ic.OBJECT_ID, ic.column_id) AS ColumnName
FROM
    sys.indexes AS i
        INNER JOIN
        sys.index_columns AS ic ON i.OBJECT_ID = ic.OBJECT_ID AND i.index_id = ic.index_id
WHERE
    i.is_primary_key = 1 AND i.OBJECT_ID = '291636232';
/* ^_padak */

CREATE TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc57b682f35_80379991] (
    [L_ORDERKEY]      nvarchar(4000),
    [L_PARTKEY]       nvarchar(4000),
    [L_SUPPKEY]       nvarchar(4000),
    [L_LINENUMBER]    nvarchar(4000),
    [L_QUANTITY]      nvarchar(4000),
    [L_EXTENDEDPRICE] nvarchar(4000),
    [L_DISCOUNT]      nvarchar(4000),
    [L_TAX]           nvarchar(4000),
    [L_RETURNFLAG]    nvarchar(4000),
    [L_LINESTATUS]    nvarchar(4000),
    [L_SHIPDATE]      nvarchar(4000),
    [L_COMMITDATE]    nvarchar(4000),
    [L_RECEIPTDATE]   nvarchar(4000),
    [L_SHIPINSTRUCT]  nvarchar(4000),
    [L_SHIPMODE]      nvarchar(4000),
    [L_COMMENT]       nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB);

BEGIN TRANSACTION;

UPDATE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT]
SET
    [L_ORDERKEY]      = COALESCE([src].[L_ORDERKEY], ''), 
    [L_PARTKEY]       = COALESCE([src].[L_PARTKEY], ''),
    [L_SUPPKEY]       = COALESCE([src].[L_SUPPKEY], ''), 
    [L_LINENUMBER]    = COALESCE([src].[L_LINENUMBER], ''),
    [L_QUANTITY]      = COALESCE([src].[L_QUANTITY], ''), 
    [L_EXTENDEDPRICE] = COALESCE([src].[L_EXTENDEDPRICE], ''),
    [L_DISCOUNT]      = COALESCE([src].[L_DISCOUNT], ''), 
    [L_TAX]           = COALESCE([src].[L_TAX], ''),
    [L_RETURNFLAG]    = COALESCE([src].[L_RETURNFLAG], ''), 
    [L_LINESTATUS]    = COALESCE([src].[L_LINESTATUS], ''),
    [L_SHIPDATE]      = COALESCE([src].[L_SHIPDATE], ''), 
    [L_COMMITDATE]    = COALESCE([src].[L_COMMITDATE], ''),
    [L_RECEIPTDATE]   = COALESCE([src].[L_RECEIPTDATE], ''), 
    [L_SHIPINSTRUCT]  = COALESCE([src].[L_SHIPINSTRUCT], ''),
    [L_SHIPMODE]      = COALESCE([src].[L_SHIPMODE], ''), 
    [L_COMMENT]       = COALESCE([src].[L_COMMENT], ''),
    [_timestamp]      = '2020-12-18 15:06:35'
FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314] AS [src]
WHERE
        [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_ORDERKEY] = COALESCE([src].[L_ORDERKEY], '') AND
        (COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_ORDERKEY] AS varchar), '') !=      COALESCE([src].[L_ORDERKEY], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_PARTKEY] AS varchar), '') !=       COALESCE([src].[L_PARTKEY], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_SUPPKEY] AS varchar), '') !=       COALESCE([src].[L_SUPPKEY], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_LINENUMBER] AS varchar), '') !=    COALESCE([src].[L_LINENUMBER], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_QUANTITY] AS varchar), '') !=      COALESCE([src].[L_QUANTITY], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_EXTENDEDPRICE] AS varchar), '') != COALESCE([src].[L_EXTENDEDPRICE], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_DISCOUNT] AS varchar), '') !=      COALESCE([src].[L_DISCOUNT], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_TAX] AS varchar), '') !=           COALESCE([src].[L_TAX], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_RETURNFLAG] AS varchar), '') !=    COALESCE([src].[L_RETURNFLAG], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_LINESTATUS] AS varchar), '') !=    COALESCE([src].[L_LINESTATUS], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_SHIPDATE] AS varchar), '') !=      COALESCE([src].[L_SHIPDATE], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_COMMITDATE] AS varchar), '') !=    COALESCE([src].[L_COMMITDATE], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_RECEIPTDATE] AS varchar), '') !=   COALESCE([src].[L_RECEIPTDATE], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_SHIPINSTRUCT] AS varchar), '') !=  COALESCE([src].[L_SHIPINSTRUCT], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_SHIPMODE] AS varchar), '') !=      COALESCE([src].[L_SHIPMODE], '') OR
         COALESCE(CAST([in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_COMMENT] AS varchar), '') !=       COALESCE([src].[L_COMMENT], ''));

DELETE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314]
WHERE
    EXISTS(
            SELECT * FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT] 
                WHERE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT].[L_ORDERKEY] = COALESCE([in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314].[L_ORDERKEY], '')
          );

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- DEDUPLICATION
-- !!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO
    [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc57b682f35_80379991] (
                                                                                     [L_ORDERKEY], [L_PARTKEY],
                                                                                     [L_SUPPKEY], [L_LINENUMBER],
                                                                                     [L_QUANTITY], [L_EXTENDEDPRICE],
                                                                                     [L_DISCOUNT], [L_TAX],
                                                                                     [L_RETURNFLAG], [L_LINESTATUS],
                                                                                     [L_SHIPDATE], [L_COMMITDATE],
                                                                                     [L_RECEIPTDATE], [L_SHIPINSTRUCT],
                                                                                     [L_SHIPMODE], [L_COMMENT]
                                                                                    )
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
    FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314]) AS a
WHERE a."_row_number_" = 1;

/* v_padak */
DELETE FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc578c70504_19303314];
/* ^_padak */

-- !!!!!!!!!!!!!!!!!!!!!!!!!
-- INSERT FINAL DATA
-- !!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO
    [in.c-tests-SAS-MASTER_KEY-HEAP4000].[MSFT] ([L_ORDERKEY], [L_PARTKEY], [L_SUPPKEY], [L_LINENUMBER], [L_QUANTITY],
                                                 [L_EXTENDEDPRICE], [L_DISCOUNT], [L_TAX], [L_RETURNFLAG],
                                                 [L_LINESTATUS], [L_SHIPDATE], [L_COMMITDATE], [L_RECEIPTDATE],
                                                 [L_SHIPINSTRUCT], [L_SHIPMODE], [L_COMMENT], [_timestamp]) (SELECT
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
                                                                                                               , CAST(COALESCE([L_COMMITDATE], '') as nvarchar(4000))    AS [L_COMMITDATE]
                                                                                                               , CAST(COALESCE([L_RECEIPTDATE], '') as nvarchar(4000))   AS [L_RECEIPTDATE]
                                                                                                               , CAST(COALESCE([L_SHIPINSTRUCT], '') as nvarchar(4000))  AS [L_SHIPINSTRUCT]
                                                                                                               , CAST(COALESCE([L_SHIPMODE], '') as nvarchar(4000))      AS [L_SHIPMODE]
                                                                                                               , CAST(COALESCE([L_COMMENT], '') as nvarchar(4000))       AS [L_COMMENT]
                                                                                                               , '2020-12-18 15:06:35'
FROM [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc57b682f35_80379991] AS [src]);

COMMIT;

DROP TABLE [in.c-tests-SAS-MASTER_KEY-HEAP4000].[#__temp_csvimport5fdcc57b682f35_80379991];