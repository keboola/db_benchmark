-- warmup
select * from call_center order by cc_call_center_id desc limit 100;
select * from catalog_page order by cp_catalog_page_id desc limit 100;
select * from catalog_returns order by cr_returned_date_sk desc limit 100;
select * from catalog_sales order by cs_sold_date_sk desc limit 100;
select * from customer_address order by ca_address_id desc limit 100;
select * from customer_demographics order by cd_demo_sk desc limit 100;
select * from customer order by c_customer_id desc limit 100;
select * from date_dim order by d_date_id desc limit 100;
select * from household_demographics order by hd_demo_sk desc limit 100;
select * from income_band order by ib_income_band_sk desc limit 100;
select * from inventory order by inv_item_sk desc limit 100;
select * from item order by i_item_id desc limit 100;
select * from promotion order by p_promo_id desc limit 100;
select * from reason order by r_reason_id desc limit 100;
select * from ship_mode order by sm_ship_mode_id desc limit 100;
select * from store_returns order by sr_returned_date_sk desc limit 100;
select * from store_sales order by ss_sold_date_sk desc limit 100;
select * from store order by s_store_id desc limit 100;
select * from time_dim order by t_time_id desc limit 100;
select * from warehouse order by w_warehouse_id desc limit 100;
select * from web_page order by wp_web_page_id desc limit 100;
select * from web_returns order by wr_returned_date_sk desc limit 100;
select * from web_sales order by ws_sold_date_sk desc limit 100;
select * from web_site order by web_site_id desc limit 100;

