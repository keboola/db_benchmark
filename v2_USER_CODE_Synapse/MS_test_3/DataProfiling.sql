select count(*) from call_center
select count(*) from catalog_page
select count(*) from catalog_returns
select count(*) from catalog_sales
select count(*) from customer
select count(*) from customer_address
select count(*) from customer_demographics
select count(*) from date_dim
select count(*) from household_demographics
select count(*) from income_band
select count(*) from inventory
select count(*) from item
select count(*) from promotion
select count(*) from reason
select count(*) from ship_mode
select count(*) from store
select count(*) from store_returns
select count(*) from store_sales
select count(*) from time_dim
select count(*) from warehouse
select count(*) from web_page
select count(*) from web_returns
select count(*) from web_sales
select count(*) from web_site



select count(distinct inv_date_sk), count(distinct inv_item_sk) from inventory

select count(distinct cs_sold_date_sk), count(distinct cs_item_sk) from catalog_sales
select count(distinct cr_returned_date_sk), count(distinct cr_item_sk) from catalog_returns

select count(distinct ss_sold_date_sk), count(distinct ss_item_sk) from store_sales
select count(distinct sr_returned_date_sk), count(distinct sr_item_sk) from store_returns

select count(distinct ws_sold_date_sk), count(distinct ws_item_sk) from web_sales
select count(distinct wr_returned_date_sk), count(distinct wr_item_sk) from web_returns

dbcc pdw_showspaceused('dbo.customer')
dbcc pdw_showspaceused('dbo.customer_address')
dbcc pdw_showspaceused('dbo.customer_demographics')
dbcc pdw_showspaceused('dbo.time_dim')
dbcc pdw_showspaceused('dbo.item')
dbcc pdw_showspaceused('item_new')
dbcc pdw_showspaceused('item_new2')
dbcc pdw_showspaceused('inventory')
dbcc pdw_showspaceused('catalog_sales')
dbcc pdw_showspaceused('catalog_returns')
dbcc pdw_showspaceused('store_sales')
dbcc pdw_showspaceused('store_returns')
dbcc pdw_showspaceused('web_sales')
dbcc pdw_showspaceused('web_returns')
--select count(*) from store_sales


select * from [vNotReplicatedTables]
select * from [dbo].[vColumnstoreDensity] where table_name not like '%_old'

ALTER INDEX ALL ON [dbo].store_sales REBUILD
ALTER INDEX ALL ON [dbo].inventory REBUILD
ALTER INDEX ALL ON [dbo].item REBUILD 
ALTER INDEX ALL ON [dbo].item_new REBUILD 


createallstatistics 'dbo.call_center'