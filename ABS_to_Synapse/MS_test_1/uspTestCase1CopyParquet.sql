alter proc TestCase1CopyParquet
	@DWU int,
	@resourceclass varchar(100),
	@files int,
	@scalefactor int,
	@folder varchar(100),
	@compression varchar(100)
as
begin 

declare @filesfolder varchar(100), @scalefactorfolder varchar(100)
set @filesfolder = 'split_' + convert(varchar, @files)
set @scalefactorfolder = 'SF' + convert(varchar,@scalefactor) + '_LINEITEM'


IF OBJECT_ID('[dbo].[lineitems_final]') IS NOT NULL
	DROP TABLE [dbo].[lineitems_final]
CREATE TABLE [dbo].[lineitems_final] (
	[L_ORDERKEY] nvarchar(4000) NOT NULL,-- DEFAULT NULL,
	[L_PARTKEY] nvarchar(4000) NOT NULL,
	[L_SUPPKEY] nvarchar(4000) NOT NULL,
	[L_LINENUMBER] nvarchar(4000) NOT NULL,
	[L_QUANTITY] nvarchar(4000) NOT NULL,
	[L_EXTENDEDPRICE] nvarchar(4000) NOT NULL,
	[L_DISCOUNT] nvarchar(4000) NOT NULL,
	[L_TAX] nvarchar(4000) NOT NULL,
	[L_RETURNFLAG] nvarchar(4000) NOT NULL,
	[L_LINESTATUS] nvarchar(4000) NOT NULL,
	[L_SHIPDATE] nvarchar(4000) NOT NULL,
	[L_COMMITDATE] nvarchar(4000) NOT NULL,
	[L_RECEIPTDATE] nvarchar(4000) NOT NULL,
	[L_SHIPINSTRUCT] nvarchar(4000) NOT NULL,
	[L_SHIPMODE] nvarchar(4000) NOT NULL,
	[L_COMMENT] nvarchar(4000) NOT NULL,
	[_timestamp] datetime2
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION=HASH(L_ORDERKEY))

IF OBJECT_ID('[dbo].[lineitems_tmp]') IS NOT NULL
	DROP TABLE [dbo].[lineitems_tmp]
CREATE TABLE [dbo].[lineitems_tmp] (
	[L_ORDERKEY] nvarchar(4000),--,
	[L_PARTKEY] nvarchar(4000),
	[L_SUPPKEY] nvarchar(4000),
	[L_LINENUMBER] nvarchar(4000),
	[L_QUANTITY] nvarchar(4000),
	[L_EXTENDEDPRICE] nvarchar(4000),
	[L_DISCOUNT] nvarchar(4000),
	[L_TAX] nvarchar(4000),
	[L_RETURNFLAG] nvarchar(4000),
	[L_LINESTATUS] nvarchar(4000),
	[L_SHIPDATE] nvarchar(4000),
	[L_COMMITDATE] nvarchar(4000),
	[L_RECEIPTDATE] nvarchar(4000),
	[L_SHIPINSTRUCT] nvarchar(4000),
	[L_SHIPMODE] nvarchar(4000),
	[L_COMMENT] nvarchar(4000)
)
WITH (HEAP, DISTRIBUTION=HASH(L_ORDERKEY))


declare @sql nvarchar(max)
set @sql = '
declare @t0 datetime = getdate(), @t1 datetime, @t2 datetime, @t3 datetime

COPY INTO [dbo].[lineitems_tmp] FROM ''https://synapsedemoadlsamirskiy.dfs.core.windows.net/dbxshare/' + @folder + '/' + @compression + '/' + @scalefactorfolder + '/' + @filesfolder + '/''
WITH
(
	FILE_TYPE=''Parquet'',
		--COMPRESSION = ''' + @compression + ''',
	CREDENTIAL = (IDENTITY =''Managed Identity'')
)
OPTION (LABEL=''' + @resourceclass + ''')

set @t1 = getdate()


IF OBJECT_ID(''[dbo].[lineitems_dedupe]'') IS NOT NULL
	DROP TABLE [dbo].[lineitems_dedupe] 

CREATE TABLE [dbo].[lineitems_dedupe] 
WITH (HEAP, DISTRIBUTION=HASH(L_ORDERKEY))
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
FROM
(
	SELECT
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
	FROM [dbo].[lineitems_tmp]
) AS a
WHERE a."_row_number_" = 1
OPTION (LABEL=''' + @resourceclass + ''')

set @t2 = getdate()


INSERT INTO [dbo].[lineitems_final] 
( [L_ORDERKEY]
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
	[L_ORDERKEY] --ISNULL([L_ORDERKEY], '''') AS [L_ORDERKEY]
	, ISNULL([L_PARTKEY], '''') AS [L_PARTKEY]
	, ISNULL([L_SUPPKEY], '''') AS [L_SUPPKEY]
	, ISNULL([L_LINENUMBER], '''') AS [L_LINENUMBER]
	, ISNULL([L_QUANTITY], '''') AS [L_QUANTITY]
	, ISNULL([L_EXTENDEDPRICE], '''') AS [L_EXTENDEDPRICE]
	, ISNULL([L_DISCOUNT], '''') AS [L_DISCOUNT]
	, ISNULL([L_TAX], '''') AS [L_TAX]
	, ISNULL([L_RETURNFLAG], '''') AS [L_RETURNFLAG]
	, ISNULL([L_LINESTATUS], '''') AS [L_LINESTATUS]
	, ISNULL([L_SHIPDATE], '''') AS [L_SHIPDATE]
	, ISNULL([L_COMMITDATE], '''''''') AS [L_COMMITDATE]
	, ISNULL([L_RECEIPTDATE], '''') AS [L_RECEIPTDATE]
	, ISNULL([L_SHIPINSTRUCT], '''') AS [L_SHIPINSTRUCT]
	, ISNULL([L_SHIPMODE], '''') AS [L_SHIPMODE]
	, ISNULL([L_COMMENT], '''') AS [L_COMMENT]
	, ''2020-11-23 09:25:24'' AS [_timestamp]
FROM [dbo].[lineitems_dedupe] AS [src]
OPTION (LABEL=''' + @resourceclass + ''')

set @t3 = getdate()


insert into TestCase1PerfResults ([DateTime], DWU, ResourceClass, Method, FileType, Compression, Files, ScaleFactor, Duration1, Duration2, Duration3)
select getdate(), ' + convert(varchar,@DWU) + ', ''' + @resourceclass + ''' as resourceclass, ''COPY'' as Method, 
	''' + @folder + ''' as FileType, ''' + @compression + ''' as Compression, ' 
	+ convert(varchar,@files) + ' as files, ' + convert(varchar,@scalefactor) + ' as scalefactor, 
	@t1-@t0 as Time1, @t2-@t1 as Time2, @t3-@t2 as Time3
'

--print @sql
exec (@sql)
end
go


/*
exec TestCase1CopyParquet @DWU=500, @ResourceClass='largerc', @scalefactor=1, @files=60, @folder='Parquet', @compression='snappy'
--exec TestCase1CopyParquet @DWU=500, @ResourceClass='largerc', @scalefactor=1, @files=60, @folder='Parquet', @compression='none'
*/

print 'completed'