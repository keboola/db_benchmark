-- query61
CREATE TABLE [tst].[query61] WITH (HEAP, DISTRIBUTION=ROUND_ROBIN) AS 
SELECT  promotions, 
               total, 
               promotions / 
               total * 100 			as agg1
FROM   (SELECT Sum(ss_ext_sales_price) promotions 
        FROM   store_sales, 
               store, 
               promotion, 
               date_dim, 
               customer, 
               customer_address, 
               item 
        WHERE  ss_sold_date_sk = d_date_sk 
               AND ss_store_sk = s_store_sk 
               AND ss_promo_sk = p_promo_sk 
               AND ss_customer_sk = c_customer_sk 
               AND ca_address_sk = c_current_addr_sk 
               AND ss_item_sk = i_item_sk 
               AND ca_gmt_offset = -7 
               AND i_category = 'Books' 
               AND ( p_channel_dmail = 'Y' 
                      OR p_channel_email = 'Y' 
                      OR p_channel_tv = 'Y' ) 
               AND s_gmt_offset = -7 
               AND d_year = 2001 
               AND d_moy = 12) promotional_sales, 
       (SELECT Sum(ss_ext_sales_price) total 
        FROM   store_sales, 
               store, 
               date_dim, 
               customer, 
               customer_address, 
               item 
        WHERE  ss_sold_date_sk = d_date_sk 
               AND ss_store_sk = s_store_sk 
               AND ss_customer_sk = c_customer_sk 
               AND ca_address_sk = c_current_addr_sk 
               AND ss_item_sk = i_item_sk 
               AND ca_gmt_offset = -7 
               AND i_category = 'Books' 
               AND s_gmt_offset = -7 
               AND d_year = 2001 
               AND d_moy = 12) all_sales 
-- ORDER  BY promotions, 
          -- total
