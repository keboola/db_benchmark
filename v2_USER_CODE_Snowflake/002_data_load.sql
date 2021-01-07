/* DATA LOAD */

create or replace stage kbltst01
  url='azure://kbltst01.blob.core.windows.net/export'
  credentials=(azure_sas_token='?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-01-31T21:29:49Z&st=2021-01-06T13:29:49Z&spr=https,http&sig=xxx')
  file_format = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
    COMPRESSION='GZIP'
    TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
    SKIP_HEADER = 1
);


copy into call_center from @kbltst01/call_center/;

copy into catalog_page from @kbltst01/catalog_page/;

copy into catalog_returns from @kbltst01/catalog_returns/;

copy into catalog_sales from @kbltst01/catalog_sales/;

copy into customer from @kbltst01/customer/;

copy into customer_address from @kbltst01/customer_address/;

copy into customer_demographics from @kbltst01/customer_demographics/;

copy into date_dim from @kbltst01/date_dim/;

copy into household_demographics from @kbltst01/household_demographics/;

copy into income_band from @kbltst01/income_band/;

copy into inventory from @kbltst01/inventory/;

copy into item from @kbltst01/item/;

copy into promotion from @kbltst01/promotion/;

copy into reason from @kbltst01/reason/;

copy into ship_mode from @kbltst01/ship_mode/;

copy into store from @kbltst01/store/;

copy into store_returns from @kbltst01/store_returns/;

copy into store_sales from @kbltst01/store_sales/;

copy into time_dim from @kbltst01/time_dim/;

copy into warehouse from @kbltst01/warehouse/;

copy into web_page from @kbltst01/web_page/;

copy into web_returns from @kbltst01/web_returns/;

copy into web_sales from @kbltst01/web_sales/;

copy into web_site from @kbltst01/web_site/;

