-- load from ABS
copy into call_center
from 'https://keboolabenchmark.blob.core.windows.net/padak/USER_TRANSF/CSV/FILE_100M/TPCDS_100/CALL_CENTER/*.csv.gz'
with (
        FILE_TYPE='CSV',
        CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET = '?sv=2019-12-12&ss=bfqt&srt=sco&sp=rwdlacx&se=2020-12-17T06:38:09Z&st=2020-11-16T22:38:09Z&spr=https&sig=xxx'),
        FIELDQUOTE='"',
        FIELDTERMINATOR =',',
        ENCODING = 'UTF8',
        ROWTERMINATOR ='0x0A',
        IDENTITY_INSERT = 'OFF' ,
        FIRSTROW =1
    )
;

copy into catalog_page
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/catalog_page/'
with (file_type = 'CSV', fieldterminator = '|');

copy into catalog_returns
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/catalog_returns/'
with (file_type = 'CSV', fieldterminator = '|');

copy into catalog_sales
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/catalog_sales/'
with (file_type = 'CSV', fieldterminator = '|');

copy into customer
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/customer/'
with (file_type = 'CSV', fieldterminator = '|');

copy into customer_address
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/customer_address/'
with (file_type = 'CSV', fieldterminator = '|');

copy into customer_demographics
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/customer_demographics/'
with (file_type = 'CSV', fieldterminator = '|');

copy into date_dim
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/date_dim/'
with (file_type = 'CSV', fieldterminator = '|');

copy into household_demographics
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/household_demographics/'
with (file_type = 'CSV', fieldterminator = '|');

copy into income_band
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/income_band/'
with (file_type = 'CSV', fieldterminator = '|');

copy into inventory
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/inventory/'
with (file_type = 'CSV', fieldterminator = '|');

copy into item
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/item/'
with (file_type = 'CSV', fieldterminator = '|');

copy into promotion
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/promotion/'
with (file_type = 'CSV', fieldterminator = '|');

copy into reason
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/reason/'
with (file_type = 'CSV', fieldterminator = '|');

copy into ship_mode
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/ship_mode/'
with (file_type = 'CSV', fieldterminator = '|');

copy into store
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/store/'
with (file_type = 'CSV', fieldterminator = '|');

copy into store_returns
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/store_returns/'
with (file_type = 'CSV', fieldterminator = '|');

copy into store_sales
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/store_sales/'
with (file_type = 'CSV', fieldterminator = '|');

copy into time_dim
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/time_dim/'
with (file_type = 'CSV', fieldterminator = '|');

copy into warehouse
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/warehouse/'
with (file_type = 'CSV', fieldterminator = '|');

copy into web_page
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/web_page/'
with (file_type = 'CSV', fieldterminator = '|');

copy into web_returns
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/web_returns/'
with (file_type = 'CSV', fieldterminator = '|');

copy into web_sales
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/web_sales/'
with (file_type = 'CSV', fieldterminator = '|');

copy into web_site
from 'https://fivetranbenchmark.blob.core.windows.net/tpcds/tpcds_100_dat/web_site/'
with (file_type = 'CSV', fieldterminator = '|');
