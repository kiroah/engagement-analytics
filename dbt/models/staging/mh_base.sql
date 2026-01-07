{{ config(
    materialized = 'view' if target.name in ['dev', 'test'] else 'table'
) }}

SELECT
    ga4.*,
    -- Therapist Details from item_mapper
    item.therapist_name,
    item.license_type,
    item.primary_modality,
    item.primary_specialty,
    item.session_rate,
    item.weekly_open_slots,
    item.accepting_new_clients,
    item.location_id AS therapist_location_id,
    
    -- Promotion Details from promotion_mapper
    promo.promo_name AS mh_promotion_name

FROM {{ ref('ga4_fields_renamed_filtered') }} ga4
LEFT JOIN {{ ref('item_mapper') }} item
    ON CAST(ga4.therapist_id AS STRING) = CAST(item.item_id AS STRING)
LEFT JOIN {{ ref('promotion_mapper') }} promo
    ON ga4.promotion_name = promo.promotion_name
