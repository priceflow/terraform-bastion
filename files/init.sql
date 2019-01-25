create or replace view api.vehicles_view as 
SELECT a.dealer_id_is,
a.vin_ss,
a.stock_no_ss,
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN b.user_price
       ELSE a.price_fs
       END as price_fs,
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN b.user_price
       ELSE a.suggested_price
       END as suggested_price,       
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN 0
       ELSE a.suggested_price_change
       END as suggested_price_change,         
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN 0
       ELSE a.suggested_price_change_pct
       END as suggested_price_change_pct,   
       
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN 0
       ELSE abs(a.suggested_price_change_pct)
       END as suggested_price_change_pct_abs,   
a.year_is,
a.make_ss,
a.model_ss,
a.trim_ss,
a.city_ss,
a.state_ss,
a.zip_is,
a.seller_name_ss,
a.photo_url_ss,
a.more_info_ss,
a.miles_fs,
a.dom_active_is,
a.rank,
a.rank_at_suggested_price,
a.rank_change,
a.total_vehicles_in_comp_set,
a.added_last_7_days,
a.added_last_7_days_change,
a.sold_last_7_days,
a.sold_last_7_days_change,
a.first_price_flag,
b.user_price,
b.user_price_change,
/** Vehicle will sit in pending changes for 7 days after being added **/ 
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where exported = False and (current_date - added_time::date) <= 7)
       THEN 1
       ELSE 0
       END as in_price_changes_table,
       
/** Vehicle will sit in exported changes for 7 days after export **/ 
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where exported = True and (current_date - added_time::date) <= 7)
       THEN 1
       ELSE 0
       END as in_price_changes_exported_table,
/** Assume that dealer is updating price for 1 day until we see new data. After 1 day vehicle will retain first price change suggestion if not updated, have zero price change suggestion if updated for 7 days **/
CASE WHEN a.vin_ss in (select b.vin_ss from api.price_changes b where (current_date - exported_time::date) < 2)
       THEN 'at market'
       ELSE a.price_change_bucket
       END as price_change_bucket
 
       FROM api.vehicles a left join (select c.* from api.price_changes c join (SELECT max(added_time) as added_time, dealer_id_is, vin_ss FROM api.price_changes group by dealer_id_is, vin_ss) d on c.dealer_id_is = d.dealer_id_is and c.vin_ss=d.vin_ss and c.added_time=d.added_time) b on a.dealer_id_is = b.dealer_id_is and a.vin_ss=b.vin_ss;       
       
    

   
GRANT USAGE ON SCHEMA api TO web_anon;
GRANT SELECT ON ALL TABLES IN SCHEMA api TO web_anon;

ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT SELECT ON TABLES TO web_anon;
ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT SELECT ON SEQUENCES TO web_anon;
