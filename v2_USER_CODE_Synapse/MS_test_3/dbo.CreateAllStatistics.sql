ALTER PROCEDURE [dbo].[CreateAllStatistics] 
	@TableName VARCHAR(128)
AS

declare @sql nvarchar(max)
declare @SQL_Stats nvarchar(max)

set @sql = '
SELECT @SQL_Stats = 
	STRING_AGG(CONVERT(nvarchar(max),
			''
			if exists (select * from sys.stats where [object_id]=OBJECT_ID('''''+@TableName+''''') 
					and [name]=''''stats_''	+ TABLE_SCHEMA +''_'' + TABLE_NAME + ''_''
				+ CASE WHEN LEN(TABLE_SCHEMA)+LEN(TABLE_NAME)+LEN(COLUMN_NAME)>120 THEN CONVERT(nvarchar(max),ORDINAL_POSITION) ELSE REPLACE(REPLACE(COLUMN_NAME,''-'',''_''),'' '','''') END + '''''')''
				+ '' update statistics '' + TABLE_SCHEMA+''.''+TABLE_NAME+''(stats_'' + TABLE_SCHEMA + ''_''+ TABLE_NAME + ''_''
				+ CASE WHEN + LEN(TABLE_SCHEMA)+LEN(TABLE_NAME)+LEN(COLUMN_NAME)>120 THEN CONVERT(nvarchar(max),ORDINAL_POSITION) ELSE REPLACE(REPLACE(COLUMN_NAME,''-'',''_''),'' '','''') END + '')''
			+ '' else 
				create statistics stats_'' + TABLE_SCHEMA + ''_'' + TABLE_NAME + ''_''
				+ CASE WHEN + LEN(TABLE_SCHEMA)+LEN(TABLE_NAME)+LEN(COLUMN_NAME)>120 THEN CONVERT(nvarchar(max),ORDINAL_POSITION) ELSE REPLACE(REPLACE(COLUMN_NAME,''-'',''_''),'' '','''') END
				+ '' ON [''+TABLE_SCHEMA+''].[''+TABLE_NAME+''] ([''+COLUMN_NAME+''])''
		), '';''+CHAR(13)+CHAR(10)) WITHIN GROUP (ORDER BY [ORDINAL_POSITION] ASC) 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE 1=1
		AND TABLE_SCHEMA=PARSENAME(''' + @TableName + ''',2)
		AND TABLE_NAME=PARSENAME(''' + @TableName + ''',1)
'
exec sp_executesql @SQL, N'@SQL_Stats nvarchar(max) OUTPUT', @SQL_Stats=@SQL_Stats OUTPUT
--select @SQL_Stats
print @SQL_Stats
exec (@SQL_Stats)
go

/*
exec [dbo].[CreateAllStatistics] 'dbo.call_center'
exec [dbo].[CreateAllStatistics] 'dbo.catalog_page'
exec [dbo].[CreateAllStatistics] 'dbo.catalog_returns'
exec [dbo].[CreateAllStatistics] 'dbo.catalog_sales'
exec [dbo].[CreateAllStatistics] 'dbo.customer'
exec [dbo].[CreateAllStatistics] 'dbo.customer_address'
exec [dbo].[CreateAllStatistics] 'dbo.customer_demographics'
exec [dbo].[CreateAllStatistics] 'dbo.date_dim'
exec [dbo].[CreateAllStatistics] 'dbo.household_demographics'
exec [dbo].[CreateAllStatistics] 'dbo.income_band'
exec [dbo].[CreateAllStatistics] 'dbo.inventory'
exec [dbo].[CreateAllStatistics] 'dbo.item'
exec [dbo].[CreateAllStatistics] 'dbo.promotion'
exec [dbo].[CreateAllStatistics] 'dbo.reason'
exec [dbo].[CreateAllStatistics] 'dbo.ship_mode'
exec [dbo].[CreateAllStatistics] 'dbo.store'
exec [dbo].[CreateAllStatistics] 'dbo.store_returns'
exec [dbo].[CreateAllStatistics] 'dbo.store_sales'
exec [dbo].[CreateAllStatistics] 'dbo.time_dim'
exec [dbo].[CreateAllStatistics] 'dbo.warehouse'
exec [dbo].[CreateAllStatistics] 'dbo.web_page'
exec [dbo].[CreateAllStatistics] 'dbo.web_returns'
exec [dbo].[CreateAllStatistics] 'dbo.web_sales'
exec [dbo].[CreateAllStatistics] 'dbo.web_site'
*/
print 'Completed'
go



--create statistics stats_dbo_store_sales_1 ON [dbo].store_sales (ss_item_sk, ss_sold_date_sk, ss_store_sk) with fullscan
--drop statistics [dbo].store_sales.stats_dbo_store_sales_1

/*
update statistics dbo.call_center with fullscan
update statistics dbo.catalog_page with fullscan
update statistics dbo.catalog_returns with fullscan
update statistics dbo.catalog_sales with fullscan
update statistics dbo.customer with fullscan
update statistics dbo.customer_address with fullscan
update statistics dbo.customer_demographics with fullscan
update statistics dbo.date_dim with fullscan
update statistics dbo.household_demographics with fullscan
update statistics dbo.income_band with fullscan
update statistics dbo.inventory with fullscan
update statistics dbo.item with fullscan
update statistics dbo.promotion with fullscan
update statistics dbo.reason with fullscan
update statistics dbo.ship_mode with fullscan
update statistics dbo.store with fullscan
update statistics dbo.store_returns with fullscan
update statistics dbo.store_sales with fullscan
update statistics dbo.time_dim with fullscan
update statistics dbo.warehouse with fullscan
update statistics dbo.web_page with fullscan
update statistics dbo.web_returns with fullscan
update statistics dbo.web_sales with fullscan
update statistics dbo.web_site with fullscan
*/