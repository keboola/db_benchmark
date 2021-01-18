--select * from call_center order by 1
truncate table call_center
copy into call_center
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/SF100/CALL_CENTER/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table catalog_page
copy into catalog_page
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CATALOG_PAGE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table catalog_returns
copy into catalog_returns
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CATALOG_RETURNS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table catalog_sales
copy into catalog_sales
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CATALOG_SALES/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table customer
copy into customer
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CUSTOMER/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table customer_address
copy into customer_address
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CUSTOMER_ADDRESS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table customer_demographics
copy into customer_demographics
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/CUSTOMER_DEMOGRAPHICS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table date_dim
copy into date_dim
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/DATE_DIM/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table household_demographics
copy into household_demographics
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/HOUSEHOLD_DEMOGRAPHICS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table income_band
copy into income_band
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/INCOME_BAND/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table inventory
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/INVENTORY/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table item
copy into item
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/ITEM/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table promotion
copy into promotion
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/PROMOTION/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table reason
copy into reason
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/REASON/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table ship_mode
copy into ship_mode
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/SHIP_MODE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table store
copy into store
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/STORE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table store_returns
copy into store_returns
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/STORE_RETURNS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table store_sales
copy into store_sales
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/STORE_SALES/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table time_dim
copy into time_dim
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/TIME_DIM/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table warehouse
copy into warehouse
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/WAREHOUSE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table web_page
copy into web_page
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/WEB_PAGE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table web_returns
copy into web_returns
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/WEB_RETURNS/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table web_sales
copy into web_sales
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/WEB_SALES/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go

truncate table web_site
copy into web_site
from 'https://synapsedemoadlsamirskiy.blob.core.windows.net/synapse/TPCDS/CSV/none/TPCDS100/WEB_SITE/'
with (file_type = 'CSV', fieldterminator = '|', fieldquote='', credential = (identity ='Managed Identity')) 
option (label = 'largerc');
go


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
go