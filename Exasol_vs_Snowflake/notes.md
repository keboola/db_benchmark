select * from INVENTORY limit 100;
select count(distinct "INV_DATE_SK") from INVENTORY; --395ms
select count(distinct "INV_ITEM_SK") from INVENTORY; --813ms
select count(distinct "INV_WAREHOUSE_SK") from INVENTORY; --514ms
select count(distinct "INV_QUANTITY_ON_HAND") from INVENTORY; --420ms
select "INV_DATE_SK", AVG("INV_QUANTITY_ON_HAND") from INVENTORY GROUP BY 1; --556ms

select * from CATALOG_SALES limit 100;

CREATE TABLE "PUB3420"."lineitems_final_hash_ctas"
AS
SELECT
    a.L_ORDERKEY
  , a.L_PARTKEY
  , a.L_SUPPKEY
  , a.L_LINENUMBER
  , a.L_QUANTITY
  , a.L_EXTENDEDPRICE
  , a.L_DISCOUNT
  , a.L_TAX
  , a.L_RETURNFLAG
  , a.L_LINESTATUS
  , a.L_SHIPDATE
  , a.L_COMMITDATE
  , a.L_RECEIPTDATE
  , a.L_SHIPINSTRUCT
  , a.L_SHIPMODE
  , a.L_COMMENT
  , '2020-11-23 09:25:24'                                   AS "_timestamp"
FROM
    (SELECT
         L_ORDERKEY
       , L_PARTKEY
       , L_SUPPKEY
       , L_LINENUMBER
       , L_QUANTITY
       , L_EXTENDEDPRICE
       , L_DISCOUNT
       , L_TAX
       , L_RETURNFLAG
       , L_LINESTATUS
       , L_SHIPDATE
       , L_COMMITDATE
       , L_RECEIPTDATE
       , L_SHIPINSTRUCT
       , L_SHIPMODE
       , L_COMMENT
       , ROW_NUMBER() OVER (PARTITION BY L_ORDERKEY ORDER BY L_ORDERKEY) AS "_row_number_"
    FROM "TPCH_10GB"."LINEITEM") AS a
WHERE
    a."_row_number_" = 1;
-- 9s 168ms

select count(*) from "TPCH_10GB"."LINEITEM"

```
Tak to co trvá Synapse DW1500 25 sec, zabere Snowflake Large 12s a Exasol to má za 9s. Neznámá je náklad Exasolu na hodinu - čekám na odpověď Thomase, jak výkonný je jejich Cloud Demo. Tohle je test jednoho CTAS nad 60M řádků. De-facto I/O load s jednou row_number window fcí. Pokud pustím 99 queries od TPCDS_100GB datasetu, tak Exasol 276s, Snowflake Large 398s a Synapse DW1500 to dala za 459s.
```