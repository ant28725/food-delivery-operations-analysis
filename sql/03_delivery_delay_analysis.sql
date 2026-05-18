-- =========================================================
-- Section 2: Delivery Delay Analysis
-- Project: Food Delivery Operations Analysis
-- Purpose:
-- Identify factors associated with delayed deliveries and compare
-- delayed vs non-delayed orders across operational variables.
-- =========================================================

-- 1. Overall delay summary
-- Establishes the baseline delay rate and compares actual delivery time
-- against estimated delivery time.

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delayed_delivery_flag = true THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(100.0 * AVG(delayed_delivery_flag::int), 2) AS delay_rate_pct,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_actual_delivery_time,
    ROUND(AVG(estimated_delivery_time), 2) AS avg_estimated_delivery_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate
FROM public.delivery_stats;

-- Result Summary:
-- Total orders: 15,000
-- Delayed orders: 1,420
-- Overall delay rate: 9.47%
-- Average actual delivery time: 94.14 minutes
-- Average estimated delivery time: 94.14 minutes
-- Average minutes over estimate: 0.00
-- Overall averages may hide differences between delayed and non-delayed orders.


-- 2. Delayed vs non-delayed order comparison
-- Compares delivery timing and key operational factors between delayed and non-delayed orders.

SELECT
    delayed_delivery_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    ROUND(AVG(estimated_delivery_time), 2) AS avg_estimated_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate,
    ROUND(AVG(preparation_time_minutes), 2) AS avg_prep_time,
    ROUND(AVG(delivery_distance_km), 2) AS avg_distance_km,
    ROUND(AVG(traffic_level_score), 2) AS avg_traffic_score,
    ROUND(AVG(weather_severity_score), 2) AS avg_weather_score
FROM public.delivery_stats
GROUP BY delayed_delivery_flag
ORDER BY delayed_delivery_flag;

-- Result Summary:
-- Non-delayed orders accounted for 13,580 orders, or 90.53% of total orders.
-- Delayed orders accounted for 1,420 orders, or 9.47% of total orders.
-- Delayed orders averaged 110.49 minutes compared to 92.43 minutes for non-delayed orders.
-- Delayed orders took approximately 18.06 minutes longer on average.
-- Delayed orders exceeded estimated delivery time by 14.31 minutes on average.
-- Non-delayed orders arrived 1.50 minutes earlier than estimated on average.
-- Prep time, distance, traffic, and weather were only slightly higher for delayed orders, suggesting the need for bucketed analysis.