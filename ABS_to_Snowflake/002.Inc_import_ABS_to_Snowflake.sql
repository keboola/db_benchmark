--
-- large DWH
-- 60M rows src as a inc load
--   -> 15M, 1.5M and 150k rows after dedupe

--destination (final) table already exist
--

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

copy into "lineitems_tmp" from @padak_azure_stage_csv/CSV/FILE_10M/TPCH_SF10/LINEITEM; 

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

-- creating two smaller version
create table "lineitems_dedupe_1pct" as
select *
    from "lineitems_dedupe"
    limit 150000
;

create table "lineitems_dedupe_10pct" as
select *
    from "lineitems_dedupe"
    limit 1500000
;

--forcing upsert on all rows by changing inc data (deriver from final table)
update "lineitems_dedupe_1pct"
set "L_DISCOUNT" = "L_DISCOUNT"+"L_ORDERKEY"/100
;

update "lineitems_dedupe_10pct"
set "L_DISCOUNT" = "L_DISCOUNT"+"L_ORDERKEY"/99
;

update "lineitems_dedupe"
set "L_DISCOUNT" = "L_DISCOUNT"+"L_ORDERKEY"/98
;


-- final upsert + timestamp (15M rows in)
UPDATE "lineitems_final" 
SET 
  "L_ORDERKEY"        = COALESCE("src"."L_ORDERKEY", ''), 
  "L_PARTKEY"         = COALESCE("src"."L_PARTKEY", ''),
  "L_SUPPKEY"         = COALESCE("src"."L_SUPPKEY", ''), 
  "L_LINENUMBER"      = COALESCE("src"."L_LINENUMBER", ''),
  "L_QUANTITY"        = COALESCE("src"."L_QUANTITY", ''), 
  "L_EXTENDEDPRICE"   = COALESCE("src"."L_EXTENDEDPRICE", ''),
  "L_DISCOUNT"        = COALESCE("src"."L_DISCOUNT", ''), 
  "L_TAX"             = COALESCE("src"."L_TAX", ''),
  "L_RETURNFLAG"      = COALESCE("src"."L_RETURNFLAG", ''), 
  "L_LINESTATUS"      = COALESCE("src"."L_LINESTATUS", ''),
  "L_SHIPDATE"        = COALESCE("src"."L_SHIPDATE", ''), 
  "L_COMMITDATE"      = COALESCE("src"."L_COMMITDATE", ''),
  "L_RECEIPTDATE"     = COALESCE("src"."L_RECEIPTDATE", ''), 
  "L_SHIPINSTRUCT"    = COALESCE("src"."L_SHIPINSTRUCT", ''),
  "L_SHIPMODE"        = COALESCE("src"."L_SHIPMODE", ''), 
  "L_COMMENT"         = COALESCE("src"."L_COMMENT", ''),
  "_timestamp"        = '2020-12-18 15:06:35'
FROM "lineitems_dedupe" AS "src"
WHERE
        "lineitems_final"."L_ORDERKEY" = COALESCE("src"."L_ORDERKEY", '') AND
        (COALESCE(CAST("lineitems_final"."L_ORDERKEY" AS varchar), '')      != COALESCE("src"."L_ORDERKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_PARTKEY" AS varchar), '')       != COALESCE("src"."L_PARTKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_SUPPKEY" AS varchar), '')       != COALESCE("src"."L_SUPPKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_LINENUMBER" AS varchar), '')    != COALESCE("src"."L_LINENUMBER", '') OR
         COALESCE(CAST("lineitems_final"."L_QUANTITY" AS varchar), '')      != COALESCE("src"."L_QUANTITY", '') OR
         COALESCE(CAST("lineitems_final"."L_EXTENDEDPRICE" AS varchar), '') != COALESCE("src"."L_EXTENDEDPRICE", '') OR
         COALESCE(CAST("lineitems_final"."L_DISCOUNT" AS varchar), '')      != COALESCE("src"."L_DISCOUNT", '') OR
         COALESCE(CAST("lineitems_final"."L_TAX" AS varchar), '')           != COALESCE("src"."L_TAX", '') OR
         COALESCE(CAST("lineitems_final"."L_RETURNFLAG" AS varchar), '')    != COALESCE("src"."L_RETURNFLAG", '') OR
         COALESCE(CAST("lineitems_final"."L_LINESTATUS" AS varchar), '')    != COALESCE("src"."L_LINESTATUS", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPDATE" AS varchar), '')      != COALESCE("src"."L_SHIPDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMITDATE" AS varchar), '')    != COALESCE("src"."L_COMMITDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_RECEIPTDATE" AS varchar), '')   != COALESCE("src"."L_RECEIPTDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPINSTRUCT" AS varchar), '')  != COALESCE("src"."L_SHIPINSTRUCT", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPMODE" AS varchar), '')      != COALESCE("src"."L_SHIPMODE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMENT" AS varchar), '')       != COALESCE("src"."L_COMMENT", ''))
;

-- final rows 150.000.000
-- upserting   15.000.000 (all inserted rows are new)
-- large:  42s

-- final upsert + timestamp (1.5M rows in)
UPDATE "lineitems_final" 
SET 
  "L_ORDERKEY"        = COALESCE("src"."L_ORDERKEY", ''), 
  "L_PARTKEY"         = COALESCE("src"."L_PARTKEY", ''),
  "L_SUPPKEY"         = COALESCE("src"."L_SUPPKEY", ''), 
  "L_LINENUMBER"      = COALESCE("src"."L_LINENUMBER", ''),
  "L_QUANTITY"        = COALESCE("src"."L_QUANTITY", ''), 
  "L_EXTENDEDPRICE"   = COALESCE("src"."L_EXTENDEDPRICE", ''),
  "L_DISCOUNT"        = COALESCE("src"."L_DISCOUNT", ''), 
  "L_TAX"             = COALESCE("src"."L_TAX", ''),
  "L_RETURNFLAG"      = COALESCE("src"."L_RETURNFLAG", ''), 
  "L_LINESTATUS"      = COALESCE("src"."L_LINESTATUS", ''),
  "L_SHIPDATE"        = COALESCE("src"."L_SHIPDATE", ''), 
  "L_COMMITDATE"      = COALESCE("src"."L_COMMITDATE", ''),
  "L_RECEIPTDATE"     = COALESCE("src"."L_RECEIPTDATE", ''), 
  "L_SHIPINSTRUCT"    = COALESCE("src"."L_SHIPINSTRUCT", ''),
  "L_SHIPMODE"        = COALESCE("src"."L_SHIPMODE", ''), 
  "L_COMMENT"         = COALESCE("src"."L_COMMENT", ''),
  "_timestamp"        = '2020-12-18 15:06:35'
FROM "lineitems_dedupe_10pct" AS "src"
WHERE
        "lineitems_final"."L_ORDERKEY" = COALESCE("src"."L_ORDERKEY", '') AND
        (COALESCE(CAST("lineitems_final"."L_ORDERKEY" AS varchar), '')      != COALESCE("src"."L_ORDERKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_PARTKEY" AS varchar), '')       != COALESCE("src"."L_PARTKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_SUPPKEY" AS varchar), '')       != COALESCE("src"."L_SUPPKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_LINENUMBER" AS varchar), '')    != COALESCE("src"."L_LINENUMBER", '') OR
         COALESCE(CAST("lineitems_final"."L_QUANTITY" AS varchar), '')      != COALESCE("src"."L_QUANTITY", '') OR
         COALESCE(CAST("lineitems_final"."L_EXTENDEDPRICE" AS varchar), '') != COALESCE("src"."L_EXTENDEDPRICE", '') OR
         COALESCE(CAST("lineitems_final"."L_DISCOUNT" AS varchar), '')      != COALESCE("src"."L_DISCOUNT", '') OR
         COALESCE(CAST("lineitems_final"."L_TAX" AS varchar), '')           != COALESCE("src"."L_TAX", '') OR
         COALESCE(CAST("lineitems_final"."L_RETURNFLAG" AS varchar), '')    != COALESCE("src"."L_RETURNFLAG", '') OR
         COALESCE(CAST("lineitems_final"."L_LINESTATUS" AS varchar), '')    != COALESCE("src"."L_LINESTATUS", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPDATE" AS varchar), '')      != COALESCE("src"."L_SHIPDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMITDATE" AS varchar), '')    != COALESCE("src"."L_COMMITDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_RECEIPTDATE" AS varchar), '')   != COALESCE("src"."L_RECEIPTDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPINSTRUCT" AS varchar), '')  != COALESCE("src"."L_SHIPINSTRUCT", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPMODE" AS varchar), '')      != COALESCE("src"."L_SHIPMODE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMENT" AS varchar), '')       != COALESCE("src"."L_COMMENT", ''))
;

-- final rows 150.000.000
-- upserting    1.500.000 (all inserted rows are new)
-- large:  31s

-- final upsert + timestamp (150k rows in)
UPDATE "lineitems_final" 
SET 
  "L_ORDERKEY"        = COALESCE("src"."L_ORDERKEY", ''), 
  "L_PARTKEY"         = COALESCE("src"."L_PARTKEY", ''),
  "L_SUPPKEY"         = COALESCE("src"."L_SUPPKEY", ''), 
  "L_LINENUMBER"      = COALESCE("src"."L_LINENUMBER", ''),
  "L_QUANTITY"        = COALESCE("src"."L_QUANTITY", ''), 
  "L_EXTENDEDPRICE"   = COALESCE("src"."L_EXTENDEDPRICE", ''),
  "L_DISCOUNT"        = COALESCE("src"."L_DISCOUNT", ''), 
  "L_TAX"             = COALESCE("src"."L_TAX", ''),
  "L_RETURNFLAG"      = COALESCE("src"."L_RETURNFLAG", ''), 
  "L_LINESTATUS"      = COALESCE("src"."L_LINESTATUS", ''),
  "L_SHIPDATE"        = COALESCE("src"."L_SHIPDATE", ''), 
  "L_COMMITDATE"      = COALESCE("src"."L_COMMITDATE", ''),
  "L_RECEIPTDATE"     = COALESCE("src"."L_RECEIPTDATE", ''), 
  "L_SHIPINSTRUCT"    = COALESCE("src"."L_SHIPINSTRUCT", ''),
  "L_SHIPMODE"        = COALESCE("src"."L_SHIPMODE", ''), 
  "L_COMMENT"         = COALESCE("src"."L_COMMENT", ''),
  "_timestamp"        = '2020-12-18 15:06:35'
FROM "lineitems_dedupe_1pct" AS "src"
WHERE
        "lineitems_final"."L_ORDERKEY" = COALESCE("src"."L_ORDERKEY", '') AND
        (COALESCE(CAST("lineitems_final"."L_ORDERKEY" AS varchar), '')      != COALESCE("src"."L_ORDERKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_PARTKEY" AS varchar), '')       != COALESCE("src"."L_PARTKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_SUPPKEY" AS varchar), '')       != COALESCE("src"."L_SUPPKEY", '') OR
         COALESCE(CAST("lineitems_final"."L_LINENUMBER" AS varchar), '')    != COALESCE("src"."L_LINENUMBER", '') OR
         COALESCE(CAST("lineitems_final"."L_QUANTITY" AS varchar), '')      != COALESCE("src"."L_QUANTITY", '') OR
         COALESCE(CAST("lineitems_final"."L_EXTENDEDPRICE" AS varchar), '') != COALESCE("src"."L_EXTENDEDPRICE", '') OR
         COALESCE(CAST("lineitems_final"."L_DISCOUNT" AS varchar), '')      != COALESCE("src"."L_DISCOUNT", '') OR
         COALESCE(CAST("lineitems_final"."L_TAX" AS varchar), '')           != COALESCE("src"."L_TAX", '') OR
         COALESCE(CAST("lineitems_final"."L_RETURNFLAG" AS varchar), '')    != COALESCE("src"."L_RETURNFLAG", '') OR
         COALESCE(CAST("lineitems_final"."L_LINESTATUS" AS varchar), '')    != COALESCE("src"."L_LINESTATUS", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPDATE" AS varchar), '')      != COALESCE("src"."L_SHIPDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMITDATE" AS varchar), '')    != COALESCE("src"."L_COMMITDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_RECEIPTDATE" AS varchar), '')   != COALESCE("src"."L_RECEIPTDATE", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPINSTRUCT" AS varchar), '')  != COALESCE("src"."L_SHIPINSTRUCT", '') OR
         COALESCE(CAST("lineitems_final"."L_SHIPMODE" AS varchar), '')      != COALESCE("src"."L_SHIPMODE", '') OR
         COALESCE(CAST("lineitems_final"."L_COMMENT" AS varchar), '')       != COALESCE("src"."L_COMMENT", ''))
;

-- final rows 150.000.000
-- upserting      150.000 (all inserted rows are new)
-- large:  29s

/* SAME INC UPSERT, BUT SMALLER DST TABLE */

create table "lineitems_final_10pct" as
select * from "lineitems_final"
limit 15000000;

update "lineitems_dedupe_1pct"
set "L_DISCOUNT" = "L_ORDERKEY"/30
;

select count(distinct L_DISCOUNT) from "lineitems_dedupe_1pct";

-- final upsert + timestamp (150k rows in)
UPDATE "lineitems_final_10pct" 
SET 
  "L_ORDERKEY"        = COALESCE("src"."L_ORDERKEY", ''), 
  "L_PARTKEY"         = COALESCE("src"."L_PARTKEY", ''),
  "L_SUPPKEY"         = COALESCE("src"."L_SUPPKEY", ''), 
  "L_LINENUMBER"      = COALESCE("src"."L_LINENUMBER", ''),
  "L_QUANTITY"        = COALESCE("src"."L_QUANTITY", ''), 
  "L_EXTENDEDPRICE"   = COALESCE("src"."L_EXTENDEDPRICE", ''),
  "L_DISCOUNT"        = COALESCE("src"."L_DISCOUNT", ''), 
  "L_TAX"             = COALESCE("src"."L_TAX", ''),
  "L_RETURNFLAG"      = COALESCE("src"."L_RETURNFLAG", ''), 
  "L_LINESTATUS"      = COALESCE("src"."L_LINESTATUS", ''),
  "L_SHIPDATE"        = COALESCE("src"."L_SHIPDATE", ''), 
  "L_COMMITDATE"      = COALESCE("src"."L_COMMITDATE", ''),
  "L_RECEIPTDATE"     = COALESCE("src"."L_RECEIPTDATE", ''), 
  "L_SHIPINSTRUCT"    = COALESCE("src"."L_SHIPINSTRUCT", ''),
  "L_SHIPMODE"        = COALESCE("src"."L_SHIPMODE", ''), 
  "L_COMMENT"         = COALESCE("src"."L_COMMENT", ''),
  "_timestamp"        = '2020-12-18 15:06:35'
FROM "lineitems_dedupe_1pct" AS "src"
WHERE
        "lineitems_final_10pct"."L_ORDERKEY" = COALESCE("src"."L_ORDERKEY", '') AND
        (COALESCE(CAST("lineitems_final_10pct"."L_ORDERKEY" AS varchar), '')      != COALESCE("src"."L_ORDERKEY", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_PARTKEY" AS varchar), '')       != COALESCE("src"."L_PARTKEY", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_SUPPKEY" AS varchar), '')       != COALESCE("src"."L_SUPPKEY", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_LINENUMBER" AS varchar), '')    != COALESCE("src"."L_LINENUMBER", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_QUANTITY" AS varchar), '')      != COALESCE("src"."L_QUANTITY", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_EXTENDEDPRICE" AS varchar), '') != COALESCE("src"."L_EXTENDEDPRICE", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_DISCOUNT" AS varchar), '')      != COALESCE("src"."L_DISCOUNT", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_TAX" AS varchar), '')           != COALESCE("src"."L_TAX", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_RETURNFLAG" AS varchar), '')    != COALESCE("src"."L_RETURNFLAG", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_LINESTATUS" AS varchar), '')    != COALESCE("src"."L_LINESTATUS", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_SHIPDATE" AS varchar), '')      != COALESCE("src"."L_SHIPDATE", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_COMMITDATE" AS varchar), '')    != COALESCE("src"."L_COMMITDATE", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_RECEIPTDATE" AS varchar), '')   != COALESCE("src"."L_RECEIPTDATE", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_SHIPINSTRUCT" AS varchar), '')  != COALESCE("src"."L_SHIPINSTRUCT", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_SHIPMODE" AS varchar), '')      != COALESCE("src"."L_SHIPMODE", '') OR
         COALESCE(CAST("lineitems_final_10pct"."L_COMMENT" AS varchar), '')       != COALESCE("src"."L_COMMENT", ''))
;

-- final rows 15.000.000
-- upserting     150.000 (8580 rows are new)
-- large:  7s

