CREATE PROC dbo.TestCase2 @DWU [int] AS
BEGIN

--declare @DWU [int]  = 0

---- final table
--IF OBJECT_ID('[dbo].[lineitems_final_150M]') IS NOT NULL
--	DROP TABLE [dbo].[lineitems_final_150M]
--CREATE TABLE [dbo].[lineitems_final_150M] 
--WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
--AS 
--SELECT T.L_ORDERKEY,
--       T.L_PARTKEY,
--       T.L_SUPPKEY,
--       T.L_LINENUMBER,
--       T.L_QUANTITY,
--       T.L_EXTENDEDPRICE,
--       T.L_DISCOUNT,
--       T.L_TAX,
--       T.L_RETURNFLAG,
--       T.L_LINESTATUS,
--       T.L_SHIPDATE,
--       T.L_COMMITDATE,
--       T.L_RECEIPTDATE,
--       T.L_SHIPINSTRUCT,
--       T.L_SHIPMODE,
--       T.L_COMMENT,
--	   convert(datetime2,getdate()) as _timestamp
--FROM (SELECT L_ORDERKEY,
--             L_PARTKEY,
--             L_SUPPKEY,
--             L_LINENUMBER,
--             L_QUANTITY,
--             L_EXTENDEDPRICE,
--             L_DISCOUNT,
--             L_TAX,
--             L_RETURNFLAG,
--             L_LINESTATUS,
--             L_SHIPDATE,
--             L_COMMITDATE,
--             L_RECEIPTDATE,
--             L_SHIPINSTRUCT,
--             L_SHIPMODE,
--             L_COMMENT,
--             ROW_NUMBER() OVER (PARTITION BY L_ORDERKEY ORDER BY L_ORDERKEY, L_LINENUMBER) AS _row_number_
--      FROM lineitem_varchar_100GB) AS T
--WHERE T.[_row_number_] = 1
--option (label='xlargerc')

---- dedupe table
--IF OBJECT_ID('[dbo].[lineitems_dedupe_15M]') IS NOT NULL
--	DROP TABLE [dbo].[lineitems_dedupe_15M]
--CREATE TABLE [dbo].[lineitems_dedupe_15M] 
--WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
--AS 
--SELECT T.L_ORDERKEY,
--       T.L_PARTKEY,
--       T.L_SUPPKEY,
--       T.L_LINENUMBER,
--       T.L_QUANTITY,
--       T.L_EXTENDEDPRICE,
--       T.L_DISCOUNT,
--       T.L_TAX,
--       T.L_RETURNFLAG,
--       T.L_LINESTATUS,
--       T.L_SHIPDATE,
--       T.L_COMMITDATE,
--       T.L_RECEIPTDATE,
--       T.L_SHIPINSTRUCT,
--       T.L_SHIPMODE,
--       T.L_COMMENT,
--	   convert(datetime2,getdate()) as _timestamp
--FROM (SELECT L_ORDERKEY,
--             L_PARTKEY,
--             L_SUPPKEY,
--             L_LINENUMBER,
--             L_QUANTITY,
--             L_EXTENDEDPRICE,
--             L_DISCOUNT,
--             L_TAX,
--             L_RETURNFLAG,
--             L_LINESTATUS,
--             L_SHIPDATE,
--             L_COMMITDATE,
--             L_RECEIPTDATE,
--             L_SHIPINSTRUCT,
--             L_SHIPMODE,
--             L_COMMENT,
--             ROW_NUMBER() OVER (PARTITION BY L_ORDERKEY ORDER BY L_ORDERKEY, L_LINENUMBER) AS _row_number_
--      FROM lineitem_varchar_10GB) AS T
--WHERE T.[_row_number_] = 1
--option (label='xlargerc')


IF OBJECT_ID('[dbo].[lineitems_final]') IS NOT NULL
	DROP TABLE [dbo].[lineitems_final]
CREATE TABLE [dbo].[lineitems_final] 
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT * FROM [dbo].[lineitems_final_150M] option (label='xlargerc')

create statistics stats_lineitems_final_ORDERKEY on [dbo].[lineitems_final] (L_ORDERKEY) with fullscan

-- dedup table
IF OBJECT_ID('dbo.lineitems_dedupe') is not null
	DROP TABLE dbo.lineitems_dedupe
CREATE TABLE dbo.lineitems_dedupe 
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT * FROM [dbo].[lineitems_dedupe_15M] 
OPTION (LABEL='xlargerc')

create statistics stats_lineitems_dedupe_ORDERKEY on [dbo].lineitems_dedupe (L_ORDERKEY) with fullscan


-- creating two smaller version
/*
IF OBJECT_ID('dbo.lineitems_dedupe_1pct') is not null
	DROP TABLE dbo.lineitems_dedupe_1pct
CREATE TABLE dbo.lineitems_dedupe_1pct
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT TOP 150000 * FROM dbo.lineitems_dedupe
OPTION (LABEL='xlargerc')

create statistics stats_lineitems_dedupe_1pct_ORDERKEY on [dbo].lineitems_dedupe_1pct (L_ORDERKEY)

IF OBJECT_ID('dbo.lineitems_dedupe_10pct') is not null
	DROP TABLE dbo.lineitems_dedupe_10pct
CREATE TABLE dbo.lineitems_dedupe_10pct 
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT TOP 1500000 * FROM dbo.lineitems_dedupe 
OPTION (LABEL='xlargerc')

create statistics stats_lineitems_dedupe_10pct_ORDERKEY on [dbo].lineitems_dedupe_10pct (L_ORDERKEY)

--forcing upsert on all rows by changing inc data (deriver from final table)
update lineitems_dedupe_1pct
set L_DISCOUNT = convert(DECIMAL(15,2),L_DISCOUNT)+convert(int,L_ORDERKEY)/100
OPTION (LABEL='xlargerc')

update lineitems_dedupe_10pct
set L_DISCOUNT = convert(DECIMAL(15,2),L_DISCOUNT)+convert(int,L_ORDERKEY)/99
OPTION (LABEL='xlargerc')

update lineitems_dedupe
set L_DISCOUNT = convert(DECIMAL(15,2),L_DISCOUNT)+convert(int,L_ORDERKEY)/98
OPTION (LABEL='xlargerc')
*/

--CREATE TABLE dbo.lineitems_dedupe_1pct_bak
--WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
--AS SELECT * FROM dbo.lineitems_dedupe_1pct 

--CREATE TABLE dbo.lineitems_dedupe_10pct_bak
--WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
--AS SELECT * FROM dbo.lineitems_dedupe_10pct 


if object_id('dbo.lineitems_dedupe_1pct') is not null
	drop table dbo.lineitems_dedupe_1pct
CREATE TABLE dbo.lineitems_dedupe_1pct
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT * FROM dbo.lineitems_dedupe_1pct_bak
create statistics stats_lineitems_dedupe_1pct_ORDERKEY on [dbo].lineitems_dedupe_1pct (L_ORDERKEY)

if object_id('dbo.lineitems_dedupe_10pct') is not null
	drop table dbo.lineitems_dedupe_10pct
CREATE TABLE dbo.lineitems_dedupe_10pct
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))
AS SELECT * FROM dbo.lineitems_dedupe_10pct_bak
create statistics stats_lineitems_dedupe_10pct_ORDERKEY on [dbo].lineitems_dedupe_10pct (L_ORDERKEY)




declare @t0 datetime, @t1 datetime, @t2 datetime, @t3 datetime, @t4 datetime
declare @d1 time(7), @d2 time(7), @d3 time(7), @d4 time(7)

set @t0 = getdate()

-- final upsert + timestamp (15M rows in)
UPDATE lineitems_final
SET 
  --L_ORDERKEY        = COALESCE(src.L_ORDERKEY, ''), 
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
FROM lineitems_dedupe AS src
WHERE
        --lineitems_final.L_ORDERKEY = COALESCE(src.L_ORDERKEY, '') AND
        lineitems_final.L_ORDERKEY = src.L_ORDERKEY AND
        (lineitems_final.L_ORDERKEY      != src.L_ORDERKEY OR
         lineitems_final.L_PARTKEY       != src.L_PARTKEY OR
         lineitems_final.L_SUPPKEY       != src.L_SUPPKEY OR
         lineitems_final.L_LINENUMBER    != src.L_LINENUMBER OR
         lineitems_final.L_QUANTITY      != src.L_QUANTITY OR
         lineitems_final.L_EXTENDEDPRICE != src.L_EXTENDEDPRICE OR
         lineitems_final.L_DISCOUNT      != src.L_DISCOUNT OR
         lineitems_final.L_TAX           != src.L_TAX OR
         lineitems_final.L_RETURNFLAG    != src.L_RETURNFLAG OR
         lineitems_final.L_LINESTATUS    != src.L_LINESTATUS OR
         lineitems_final.L_SHIPDATE      != src.L_SHIPDATE OR
         lineitems_final.L_COMMITDATE    != src.L_COMMITDATE OR
         lineitems_final.L_RECEIPTDATE   != src.L_RECEIPTDATE OR
         lineitems_final.L_SHIPINSTRUCT  != src.L_SHIPINSTRUCT OR
         lineitems_final.L_SHIPMODE      != src.L_SHIPMODE OR
         lineitems_final.L_COMMENT       != src.L_COMMENT)
option (label='largerc')

set @t1 = getdate()
set @d1 = @t1-@t0

-- final rows 150.000.000
-- upserting   15.000.000 (all inserted rows are new)
-- large:   42s
-- Synapse: 00:01:03



set @t0 = getdate()

-- final upsert + timestamp (1.5M rows in)
UPDATE lineitems_final 
SET 
  --L_ORDERKEY        = COALESCE(src.L_ORDERKEY, ''), 
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
FROM lineitems_dedupe_10pct AS src
WHERE
        --lineitems_final.L_ORDERKEY = COALESCE(src.L_ORDERKEY, '') AND
        lineitems_final.L_ORDERKEY = src.L_ORDERKEY AND
        (lineitems_final.L_ORDERKEY      != src.L_ORDERKEY OR
         lineitems_final.L_PARTKEY       != src.L_PARTKEY OR
         lineitems_final.L_SUPPKEY       != src.L_SUPPKEY OR
         lineitems_final.L_LINENUMBER    != src.L_LINENUMBER OR
         lineitems_final.L_QUANTITY      != src.L_QUANTITY OR
         lineitems_final.L_EXTENDEDPRICE != src.L_EXTENDEDPRICE OR
         lineitems_final.L_DISCOUNT      != src.L_DISCOUNT OR
         lineitems_final.L_TAX           != src.L_TAX OR
         lineitems_final.L_RETURNFLAG    != src.L_RETURNFLAG OR
         lineitems_final.L_LINESTATUS    != src.L_LINESTATUS OR
         lineitems_final.L_SHIPDATE      != src.L_SHIPDATE OR
         lineitems_final.L_COMMITDATE    != src.L_COMMITDATE OR
         lineitems_final.L_RECEIPTDATE   != src.L_RECEIPTDATE OR
         lineitems_final.L_SHIPINSTRUCT  != src.L_SHIPINSTRUCT OR
         lineitems_final.L_SHIPMODE      != src.L_SHIPMODE OR
         lineitems_final.L_COMMENT       != src.L_COMMENT)
option (label='largerc')

set @t2 = getdate()
set @d2 = @t2-@t0

-- final rows 150.000.000
-- upserting    1.500.000 (all inserted rows are new)
-- large:   31s
-- synapse: 00:02:37



set @t0 = getdate()

-- final upsert + timestamp (150k rows in)
UPDATE lineitems_final 
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
FROM lineitems_dedupe_1pct AS src
WHERE
        --lineitems_final.L_ORDERKEY = COALESCE(src.L_ORDERKEY, '') AND
        lineitems_final.L_ORDERKEY = src.L_ORDERKEY AND
        (lineitems_final.L_ORDERKEY      != src.L_ORDERKEY OR
         lineitems_final.L_PARTKEY       != src.L_PARTKEY OR
         lineitems_final.L_SUPPKEY       != src.L_SUPPKEY OR
         lineitems_final.L_LINENUMBER    != src.L_LINENUMBER OR
         lineitems_final.L_QUANTITY      != src.L_QUANTITY OR
         lineitems_final.L_EXTENDEDPRICE != src.L_EXTENDEDPRICE OR
         lineitems_final.L_DISCOUNT      != src.L_DISCOUNT OR
         lineitems_final.L_TAX           != src.L_TAX OR
         lineitems_final.L_RETURNFLAG    != src.L_RETURNFLAG OR
         lineitems_final.L_LINESTATUS    != src.L_LINESTATUS OR
         lineitems_final.L_SHIPDATE      != src.L_SHIPDATE OR
         lineitems_final.L_COMMITDATE    != src.L_COMMITDATE OR
         lineitems_final.L_RECEIPTDATE   != src.L_RECEIPTDATE OR
         lineitems_final.L_SHIPINSTRUCT  != src.L_SHIPINSTRUCT OR
         lineitems_final.L_SHIPMODE      != src.L_SHIPMODE OR
         lineitems_final.L_COMMENT       != src.L_COMMENT)
option (label='largerc') 

set @t3 = getdate()
set @d3 = @t3-@t0

-- final rows 150.000.000
-- upserting      150.000 (all inserted rows are new)
-- large:    29s
-- Synapse:  25s



/* SAME INC UPSERT, BUT SMALLER DST TABLE */

/*
if object_id('dbo.lineitems_final_10pct') is not null
	drop table dbo.lineitems_final_10pct
create table dbo.lineitems_final_10pct
with (clustered columnstore index, distribution=hash(L_ORDERKEY))
as select top 15000000 * from lineitems_final
option (label='largerc')
create statistics stats_lineitems_final_10pct_ORDERKEY on [dbo].lineitems_final_10pct (L_ORDERKEY)

create table dbo.lineitems_final_10pct_bak
with (clustered columnstore index, distribution=hash(L_ORDERKEY))
as select  * from lineitems_final_10pct
option (label='largerc')
*/

if object_id('dbo.lineitems_final_10pct') is not null
	drop table dbo.lineitems_final_10pct
create table dbo.lineitems_final_10pct
with (clustered columnstore index, distribution=hash(L_ORDERKEY))
as select * from lineitems_final_10pct_bak
option (label='largerc')

create statistics stats_lineitems_final_10pct_ORDERKEY on [dbo].lineitems_final_10pct (L_ORDERKEY)



update lineitems_dedupe_1pct
set L_DISCOUNT = L_ORDERKEY/30
where cast(L_ORDERKEY as int) < 3500000

--select count(distinct L_DISCOUNT) from lineitems_dedupe_1pct


set @t0 = getdate()

-- final upsert + timestamp (150k rows in)
UPDATE lineitems_final_10pct 
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
FROM lineitems_dedupe_1pct AS src
WHERE
        lineitems_final_10pct.L_ORDERKEY = src.L_ORDERKEY AND
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
option (label='largerc')

set @t4 = getdate()
set @d4 = @t4-@t0

-- final rows 15.000.000
-- upserting     150.000 (8580 rows are new)
-- large:   7s
-- synapse: 13s (150,000 rows affected)



insert into TestCase2PerfResults ([DateTime], DWU, ResourceClass, Duration1, Duration2, Duration3, Duration4)
select getdate(), convert(varchar,@DWU) as DWU, 'largerc' as resourceclass, 
	@d1 as Time1, @d2 as Time2, @d3 as Time3, @d4 as Time4
--select * from TestCase2PerfResults order by ID desc

select getdate(), 'largerc' as resourceclass, @d1 as Time1, @d2 as Time2, @d3 as Time3, @d4 as Time4

END
GO

/*
exec dbo.TestCase2 @DWU=0

select ID, DateTime, DWU, cast(Duration1 as time(0)), cast(Duration2 as time(0)), cast(Duration3 as time(0)), cast(Duration4 as time(0))
from TestCase2PerfResults order by DateTime desc
--truncate table TestCase2PerfResults
*/