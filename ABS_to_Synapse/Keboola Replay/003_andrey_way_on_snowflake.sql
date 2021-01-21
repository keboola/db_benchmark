show tables;--
-- large DWH 
-- 60M rows

--destination (final) table
CREATE TABLE "lineitems_tmp" (
    "L_ORDERKEY"      varchar(4000) NOT NULL DEFAULT NULL,
    "L_PARTKEY"       varchar(4000) NOT NULL DEFAULT NULL,
    "L_SUPPKEY"       varchar(4000) NOT NULL DEFAULT NULL,
    "L_LINENUMBER"    varchar(4000) NOT NULL DEFAULT NULL,
    "L_QUANTITY"      varchar(4000) NOT NULL DEFAULT NULL,
    "L_EXTENDEDPRICE" varchar(4000) NOT NULL DEFAULT NULL,
    "L_DISCOUNT"      varchar(4000) NOT NULL DEFAULT NULL,
    "L_TAX"           varchar(4000) NOT NULL DEFAULT NULL,
    "L_RETURNFLAG"    varchar(4000) NOT NULL DEFAULT NULL,
    "L_LINESTATUS"    varchar(4000) NOT NULL DEFAULT NULL,
    "L_SHIPDATE"      varchar(4000) NOT NULL DEFAULT NULL,
    "L_COMMITDATE"    varchar(4000) NOT NULL DEFAULT NULL,
    "L_RECEIPTDATE"   varchar(4000) NOT NULL DEFAULT NULL,
    "L_SHIPINSTRUCT"  varchar(4000) NOT NULL DEFAULT NULL,
    "L_SHIPMODE"      varchar(4000) NOT NULL DEFAULT NULL,
    "L_COMMENT"       varchar(4000) NOT NULL DEFAULT NULL,
    PRIMARY KEY ("L_ORDERKEY") 
);

create or replace stage padak_azure_stage_csv
  url='azure://keboolabenchmark.blob.core.windows.net/padak'
  credentials=(azure_sas_token='?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-01-22T18:28:10Z&st=2021-01-20T10:28:10Z&spr=https&sig=v2iAtTySRo4%2FiOCC9P9gZzdvKhHQFU7ije%2FC59%2FWCeg%3D')
  file_format = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
    COMPRESSION='GZIP'
    TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
);

copy into "lineitems_tmp" from @padak_azure_stage_csv/CSV/FILE_10M/TPCH_SF10/LINEITEM; 
-- large  60M: 11.47s

CREATE TABLE "lineitems_final_ctas" AS
SELECT "a"."L_ORDERKEY",
       "a"."L_PARTKEY",
       "a"."L_SUPPKEY",
       "a"."L_LINENUMBER",
       "a"."L_QUANTITY",
       "a"."L_EXTENDEDPRICE",
       "a"."L_DISCOUNT",
       "a"."L_TAX",
       "a"."L_RETURNFLAG",
       "a"."L_LINESTATUS",
       "a"."L_SHIPDATE",
       "a"."L_COMMITDATE",
       "a"."L_RECEIPTDATE",
       "a"."L_SHIPINSTRUCT",
       "a"."L_SHIPMODE",
       "a"."L_COMMENT",
       '2020-11-23 09:25:24' AS "_timestamp"
FROM (SELECT "L_ORDERKEY",
             "L_PARTKEY",
             "L_SUPPKEY",
             "L_LINENUMBER",
             "L_QUANTITY",
             "L_EXTENDEDPRICE",
             "L_DISCOUNT",
             "L_TAX",
             "L_RETURNFLAG",
             "L_LINESTATUS",
             "L_SHIPDATE",
             "L_COMMITDATE",
             "L_RECEIPTDATE",
             "L_SHIPINSTRUCT",
             "L_SHIPMODE",
             "L_COMMENT",
             ROW_NUMBER() OVER (PARTITION BY "L_ORDERKEY" ORDER BY "L_ORDERKEY") AS "_row_number_"
      FROM "lineitems_tmp") AS "a"
WHERE "a"."_row_number_" = 1
;
-- large  60M: 10.5s

