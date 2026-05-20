-- =========================================================
-- Section 5: Tableau Dashboard Views
-- Project: Food Delivery Operations Analysis
-- Purpose:
-- Create cleaned, analysis-ready SQL views for Tableau dashboards.
-- These views include calculated fields for demand patterns,
-- delivery performance, lateness buckets, refund risk, and segments.
-- =========================================================

CREATE OR REPLACE VIEW public.food_delivery_dashboard_view AS
SELECT
    order_id,
    city_tier,
    customer_age,
    customer_loyalty_score,
    order_hour,
    order_day_of_week,
    order_month,
    delivery_distance_km,
    preparation_time_minutes,
    delivery_time_minutes,
    estimated_delivery_time,
    delivery_time_minutes - estimated_delivery_time AS minutes_over_estimate,
    traffic_level_score,
    weather_severity_score,
    restaurant_rating,
    delivery_partner_rating,
    customer_rating,
    order_value,
    delivery_fee,
    discount_amount,
    tip_amount,
    final_amount_paid,
    number_of_items,
    cancellation_flag,
    delayed_delivery_flag,
    refund_flag,
    promo_code_used,
    premium_customer_flag,
    festival_or_weekend_flag,
    delivery_partner_experience_years,
    delivery_efficiency_score,

    CASE
        WHEN delayed_delivery_flag = true THEN 'Delayed'
        ELSE 'Not Delayed'
    END AS delivery_status,

    CASE
        WHEN delivery_time_minutes - estimated_delivery_time <= 0 THEN 'On Time / Early'
        WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 1 AND 10 THEN '1-10 min late'
        WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 11 AND 20 THEN '11-20 min late'
        ELSE '20+ min late'
    END AS lateness_bucket,

    CASE
        WHEN delivery_distance_km < 10 THEN 'Under 10 km'
        WHEN delivery_distance_km >= 10 AND delivery_distance_km < 20 THEN '10-19.99 km'
        WHEN delivery_distance_km >= 20 AND delivery_distance_km < 30 THEN '20-29.99 km'
        ELSE '30+ km'
    END AS distance_bucket,

    CASE
        WHEN preparation_time_minutes < 20 THEN 'Under 20 min'
        WHEN preparation_time_minutes >= 20 AND preparation_time_minutes < 30 THEN '20-29.99 min'
        WHEN preparation_time_minutes >= 30 AND preparation_time_minutes < 40 THEN '30-39.99 min'
        ELSE '40+ min'
    END AS prep_time_bucket,

    CASE
        WHEN traffic_level_score < 3 THEN 'Low Traffic'
        WHEN traffic_level_score >= 3 AND traffic_level_score < 7 THEN 'Moderate Traffic'
        ELSE 'High Traffic'
    END AS traffic_bucket,

    CASE
        WHEN weather_severity_score < 3 THEN 'Low Weather Severity'
        WHEN weather_severity_score >= 3 AND weather_severity_score < 7 THEN 'Moderate Weather Severity'
        ELSE 'High Weather Severity'
    END AS weather_bucket,

    CASE
        WHEN premium_customer_flag = true THEN 'Premium'
        ELSE 'Non-Premium'
    END AS customer_type,

    CASE
        WHEN promo_code_used = true THEN 'Promo Used'
        ELSE 'No Promo'
    END AS promo_status,

    CASE
        WHEN festival_or_weekend_flag = true THEN 'Weekend/Festival'
        ELSE 'Regular Day'
    END AS day_type,

    CASE
        WHEN number_of_items = 1 THEN '1 item'
        WHEN number_of_items BETWEEN 2 AND 3 THEN '2-3 items'
        WHEN number_of_items BETWEEN 4 AND 5 THEN '4-5 items'
        ELSE '6+ items'
    END AS order_size_group,

    CASE
        WHEN final_amount_paid < 75 THEN 'Low Value'
        WHEN final_amount_paid >= 75 AND final_amount_paid < 125 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_group,

    CASE
        WHEN refund_flag = true THEN 'Refunded'
        ELSE 'Not Refunded'
    END AS refund_status,

    CASE
        WHEN cancellation_flag = true THEN 'Canceled'
        ELSE 'Not Canceled'
    END AS cancellation_status,

    CASE
        WHEN delivery_time_minutes - estimated_delivery_time > 10 THEN 'High Refund Risk'
        ELSE 'Normal Refund Risk'
    END AS refund_risk_group

FROM public.delivery_stats;

-- View check:
-- SELECT COUNT(*) AS total_rows
-- FROM public.food_delivery_dashboard_view;
--
-- Expected result:
-- 15,000 rows