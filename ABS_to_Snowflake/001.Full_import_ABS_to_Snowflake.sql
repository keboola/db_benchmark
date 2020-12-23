--
-- large DWH & xsmall DWH
-- 6M rows full load with PKEY
-- 60M rows --''--

--destination (final) table
CREATE TABLE "lineitems_final" (
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
    "_timestamp"      timestamp,
    PRIMARY KEY ("L_ORDERKEY") 
);
-- 300ms

--staging  table
CREATE TEMPORARY TABLE "lineitems_tmp" (
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
    "L_COMMENT"       varchar(4000) NOT NULL DEFAULT NULL
)
;
-- 328ms

copy into "lineitems_tmp" from @padak_azure_stage_csv/CSV/FILE_10M/TPCH_SF10/LINEITEM; 
-- xsmall  6M:  9.6s
-- xsmall 60M: 70.0s
-- large   6M:  4.42s
-- large  60M: 11.93s

--dedup TMP table
CREATE TEMPORARY TABLE "lineitems_dedupe" (
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
    "L_COMMENT"       varchar(4000) NOT NULL DEFAULT NULL
)
;
-- 359ms

-- dedupe
INSERT INTO "lineitems_dedupe" ("L_ORDERKEY",
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
                                "L_COMMENT")
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
       "a"."L_COMMENT"
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
-- xsmall  6M:  5.20s
-- xsmall 60M: 44.44s
-- large   6M:  4.11s
-- large  60M: 10.92s

-- final copy + timestamp
INSERT INTO "lineitems_final" ("L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY", "L_LINENUMBER", "L_QUANTITY", "L_EXTENDEDPRICE",
                               "L_DISCOUNT", "L_TAX", "L_RETURNFLAG", "L_LINESTATUS", "L_SHIPDATE", "L_COMMITDATE",
                               "L_RECEIPTDATE", "L_SHIPINSTRUCT", "L_SHIPMODE", "L_COMMENT",
                               "_timestamp") (SELECT CAST(COALESCE("L_ORDERKEY", '') AS VARCHAR(4000))      AS "L_ORDERKEY"
                                                 , CAST(COALESCE("L_PARTKEY", '') AS VARCHAR(4000))       AS "L_PARTKEY"
                                                 , CAST(COALESCE("L_SUPPKEY", '') AS VARCHAR(4000))       AS "L_SUPPKEY"
                                                 , CAST(COALESCE("L_LINENUMBER", '') AS VARCHAR(4000))    AS "L_LINENUMBER"
                                                 , CAST(COALESCE("L_QUANTITY", '') AS VARCHAR(4000))      AS "L_QUANTITY"
                                                 , CAST(COALESCE("L_EXTENDEDPRICE", '') AS VARCHAR(4000)) AS "L_EXTENDEDPRICE"
                                                 , CAST(COALESCE("L_DISCOUNT", '') AS VARCHAR(4000))      AS "L_DISCOUNT"
                                                 , CAST(COALESCE("L_TAX", '') AS VARCHAR(4000))           AS "L_TAX"
                                                 , CAST(COALESCE("L_RETURNFLAG", '') AS VARCHAR(4000))    AS "L_RETURNFLAG"
                                                 , CAST(COALESCE("L_LINESTATUS", '') AS VARCHAR(4000))    AS "L_LINESTATUS"
                                                 , CAST(COALESCE("L_SHIPDATE", '') AS VARCHAR(4000))      AS "L_SHIPDATE"
                                                 , CAST(COALESCE("L_COMMITDATE", '') AS VARCHAR(4000))    AS "L_COMMITDATE"
                                                 , CAST(COALESCE("L_RECEIPTDATE", '') AS VARCHAR(4000))   AS "L_RECEIPTDATE"
                                                 , CAST(COALESCE("L_SHIPINSTRUCT", '') AS VARCHAR(4000))  AS "L_SHIPINSTRUCT"
                                                 , CAST(COALESCE("L_SHIPMODE", '') AS VARCHAR(4000))      AS "L_SHIPMODE"
                                                 , CAST(COALESCE("L_COMMENT", '') AS VARCHAR(4000))       AS "L_COMMENT"
                                                 , '2020-11-23 09:25:24'                                  AS "_timestamp"
                                              FROM "lineitems_dedupe" AS "src")
;
-- xsmall  6M:  2.47s
-- xsmall 60M: 27.11s
-- large   6M:  2.87s
-- large  60M:  4.87s

--
-- TOTAL
--
-- xsmall  6M:  17.30s
-- xsmall 60M: 141.55s
-- large   6M:  11.40s
-- large  60M:  27.72s
