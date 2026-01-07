{{ config(
    materialized = 'view' if target.name in ['dev', 'test'] else 'table'
) }}

SELECT
  PARSE_DATE('%Y%m%d', t.event_date)                AS event_date,
  TIMESTAMP_MICROS(t.event_timestamp)               AS event_ts,
  t.event_name                                      AS raw_event_name,
  TIMESTAMP_MICROS(t.event_previous_timestamp)      AS previous_event_ts,
  t.user_pseudo_id                                  AS user_id,
  TIMESTAMP_MICROS(t.user_first_touch_timestamp)    AS user_first_seen_ts,
  t.device.category                                 AS device_category,
  t.device.operating_system                         AS device_os,
  t.device.operating_system_version                 AS device_os_version,
  t.device.language                                 AS device_language,
  t.device.time_zone_offset_seconds                 AS device_tz_offset_seconds,
  t.device.mobile_brand_name                        AS mobile_brand,
  t.device.mobile_model_name                        AS mobile_model,
  t.device.mobile_marketing_name                    AS mobile_marketing_name,
  t.device.mobile_os_hardware_model                 AS mobile_hardware_model,
  t.device.is_limited_ad_tracking                   AS limited_ad_tracking,
  t.device.web_info.browser                         AS browser_name,
  t.device.web_info.browser_version                 AS browser_version,
  t.items[OFFSET(0)].item_id                     AS therapist_id,
--   t.items[OFFSET(0)].item_name                   AS therapist_name,
--   t.items[OFFSET(0)].item_brand                  AS therapist_brand,
--   t.items[OFFSET(0)].item_variant                AS therapist_variant,
--   t.items[OFFSET(0)].item_category               AS therapist_category,
--   t.items[OFFSET(0)].price                       AS therapist_price,
--   t.items[OFFSET(0)].quantity                    AS therapist_quantity,
--   t.items[OFFSET(0)].item_revenue                AS therapist_revenue,
--   t.items[OFFSET(0)].location_id                 AS therapist_location_id,
--   t.items[OFFSET(0)].item_list_id                AS therapist_list_id,
--   t.items[OFFSET(0)].item_list_name              AS therapist_list_name,
--   t.items[OFFSET(0)].item_list_index             AS therapist_list_position,
  t.items[OFFSET(0)].promotion_name              AS promotion_name,
  t.geo.continent                                   AS geo_continent,
  t.geo.sub_continent                               AS geo_sub_continent,
  t.geo.country                                     AS geo_country,
  t.geo.region                                      AS geo_region,
  t.geo.city                                        AS geo_city,
  t.geo.metro                                       AS geo_metro,
  t.traffic_source.medium                           AS traffic_medium,
  t.traffic_source.name                             AS traffic_campaign,
  t.traffic_source.source                           AS traffic_source
FROM
  `bigquery-public-data`.`ga4_obfuscated_sample_ecommerce`.`events_*` AS t,
  UNNEST(t.items) AS items
WHERE
  1=1
  {% if target.name != 'prod' %}
  -- For dev/test, limit data to these specific 3 days (sample data available for these dates)
  AND _TABLE_SUFFIX IN ('20201101', '20201102', '20201103')
  {% endif %}