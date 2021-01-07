-- warmup_01.sql
select *
    from "CALL_CENTER"
    where "cc_call_center_sk" = -100
    order by "cc_call_center_id" desc
    limit 100
;

-- warmup_02.sql
select *
    from "CATALOG_PAGE"
    where "cp_catalog_page_sk" = -100
    order by "cp_catalog_page_id" desc
    limit 100
;

-- warmup_03.sql
select *
    from "CATALOG_RETURNS"
    where "cr_returned_date_sk" = -100
    order by "cr_returned_date_sk" desc
    limit 100
;

-- warmup_04.sql
select *
    from "CATALOG_SALES"
    where "cs_sold_date_sk" = -100
    order by "cs_sold_date_sk" desc
    limit 100
;

-- warmup_05.sql
select *
    from "CUSTOMER_ADDRESS"
    where "ca_address_sk" = -100
    order by "ca_address_id" desc
    limit 100
;

-- warmup_06.sql
select *
    from "CUSTOMER_DEMOGRAPHICS"
    where "cd_demo_sk" = -100
    order by "cd_demo_sk" desc
    limit 100
;

-- warmup_07.sql
select *
    from "CUSTOMER"
    where "c_customer_sk" = -100
    order by "c_customer_id" desc
    limit 100
;

-- warmup_08.sql
select *
    from "DATE_DIM"
    where "d_date_sk" = -100
    order by "d_date_id" desc
    limit 100
;

-- warmup_09.sql
select *
    from "HOUSEHOLD_DEMOGRAPHICS"
    where "hd_demo_sk" = -100
    order by "hd_demo_sk" desc
    limit 100
;

-- warmup_10.sql
select *
    from "INCOME_BAND"
    where "ib_income_band_sk" = -100
    order by "ib_income_band_sk" desc
    limit 100
;

-- warmup_11.sql
select *
    from "INVENTORY"
    where "inv_item_sk" = -100
    order by "inv_item_sk" desc
    limit 100
;

-- warmup_12.sql
select *
    from "ITEM"
    where "i_item_sk" = -100
    order by "i_item_id" desc
    limit 100
;

-- warmup_13.sql
select *
    from "PROMOTION"
    where "p_promo_sk" = -100
    order by "p_promo_id" desc
    limit 100
;

-- warmup_14.sql
select *
    from "REASON"
    where "r_reason_sk" = -100
    order by "r_reason_id" desc
    limit 100
;

-- warmup_15.sql
select *
    from "SHIP_MODE"
    where "sm_ship_mode_sk" = -100
    order by "sm_ship_mode_id" desc
    limit 100
;

-- warmup_16.sql
select *
    from "STORE_RETURNS"
    where "sr_returned_date_sk" = -100
    order by "sr_returned_date_sk" desc
    limit 100
;

-- warmup_17.sql
select *
    from "STORE_SALES"
    where "ss_sold_date_sk" = -100
    order by "ss_sold_date_sk" desc
    limit 100
;

-- warmup_18.sql
select *
    from "STORE"
    where "s_store_sk" = -100
    order by "s_store_id" desc
    limit 100
;

-- warmup_19.sql
select *
    from "TIME_DIM"
    where "t_time_sk" = -100
    order by "t_time_id" desc
    limit 100
;

-- warmup_20.sql
select *
    from "WAREHOUSE"
    where "w_warehouse_sk" = -100
    order by "w_warehouse_id" desc
    limit 100
;

-- warmup_21.sql
select *
    from "WEB_PAGE"
    where "wp_web_page_sk" = -100
    order by "wp_web_page_id" desc
    limit 100
;

-- warmup_22.sql
select *
    from "WEB_RETURNS"
    where "wr_returned_date_sk" = -100
    order by "wr_returned_date_sk" desc
    limit 100
;

-- warmup_23.sql
select *
    from "WEB_SALES"
    where "ws_sold_date_sk" = -100
    order by "ws_sold_date_sk" desc
    limit 100
;

-- warmup_24.sql
select *
    from "WEB_SITE"
    where "web_site_sk" = -100
    order by "web_site_id" desc
    limit 100
;

