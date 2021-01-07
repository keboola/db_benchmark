-- warmup_01.sql
select *
    from "call_center"
    where "cc_call_center_sk" = -100
    order by "cc_call_center_id" desc
    limit 100
;

-- warmup_02.sql
select *
    from "catalog_page"
    where "cp_catalog_page_sk" = -100
    order by "cp_catalog_page_id" desc
    limit 100
;

-- warmup_03.sql
select *
    from "catalog_returns"
    where "cr_returned_date_sk" = -100
    order by "cr_returned_date_sk" desc
    limit 100
;

-- warmup_04.sql
select *
    from "catalog_sales"
    where "cs_sold_date_sk" = -100
    order by "cs_sold_date_sk" desc
    limit 100
;

-- warmup_05.sql
select *
    from "customer_address"
    where "ca_address_sk" = -100
    order by "ca_address_id" desc
    limit 100
;

-- warmup_06.sql
select *
    from "customer_demographics"
    where "cd_demo_sk" = -100
    order by "cd_demo_sk" desc
    limit 100
;

-- warmup_07.sql
select *
    from "customer"
    where "c_customer_sk" = -100
    order by "c_customer_id" desc
    limit 100
;

-- warmup_08.sql
select *
    from "date_dim"
    where "d_date_sk" = -100
    order by "d_date_id" desc
    limit 100
;

-- warmup_09.sql
select *
    from "household_demographics"
    where "hd_demo_sk" = -100
    order by "hd_demo_sk" desc
    limit 100
;

-- warmup_10.sql
select *
    from "income_band"
    where "ib_income_band_sk" = -100
    order by "ib_income_band_sk" desc
    limit 100
;

-- warmup_11.sql
select *
    from "inventory"
    where "inv_item_sk" = -100
    order by "inv_item_sk" desc
    limit 100
;

-- warmup_12.sql
select *
    from "item"
    where "i_item_sk" = -100
    order by "i_item_id" desc
    limit 100
;

-- warmup_13.sql
select *
    from "promotion"
    where "p_promo_sk" = -100
    order by "p_promo_id" desc
    limit 100
;

-- warmup_14.sql
select *
    from "reason"
    where "r_reason_sk" = -100
    order by "r_reason_id" desc
    limit 100
;

-- warmup_15.sql
select *
    from "ship_mode"
    where "sm_ship_mode_sk" = -100
    order by "sm_ship_mode_id" desc
    limit 100
;

-- warmup_16.sql
select *
    from "store_returns"
    where "sr_returned_date_sk" = -100
    order by "sr_returned_date_sk" desc
    limit 100
;

-- warmup_17.sql
select *
    from "store_sales"
    where "ss_sold_date_sk" = -100
    order by "ss_sold_date_sk" desc
    limit 100
;

-- warmup_18.sql
select *
    from "store"
    where "s_store_sk" = -100
    order by "s_store_id" desc
    limit 100
;

-- warmup_19.sql
select *
    from "time_dim"
    where "t_time_sk" = -100
    order by "t_time_id" desc
    limit 100
;

-- warmup_20.sql
select *
    from "warehouse"
    where "w_warehouse_sk" = -100
    order by "w_warehouse_id" desc
    limit 100
;

-- warmup_21.sql
select *
    from "web_page"
    where "wp_web_page_sk" = -100
    order by "wp_web_page_id" desc
    limit 100
;

-- warmup_22.sql
select *
    from "web_returns"
    where "wr_returned_date_sk" = -100
    order by "wr_returned_date_sk" desc
    limit 100
;

-- warmup_23.sql
select *
    from "web_sales"
    where "ws_sold_date_sk" = -100
    order by "ws_sold_date_sk" desc
    limit 100
;

-- warmup_24.sql
select *
    from "web_site"
    where "web_site_sk" = -100
    order by "web_site_id" desc
    limit 100
;

