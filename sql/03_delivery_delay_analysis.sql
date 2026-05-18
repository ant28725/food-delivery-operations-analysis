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