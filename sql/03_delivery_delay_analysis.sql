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

-- 3. Delay rate by delivery distance bucket
-- Evaluates whether longer delivery distances are associated with higher delay risk.

WITH distance_groups AS (
    SELECT
        CASE
            WHEN delivery_distance_km < 10 THEN 'Under 10 km'
            WHEN delivery_distance_km >= 10 AND delivery_distance_km < 20 THEN '10-19.99 km'
            WHEN delivery_distance_km >= 20 AND delivery_distance_km < 30 THEN '20-29.99 km'
            ELSE '30+ km'
        END AS distance_bucket,
        delayed_delivery_flag,
        delivery_time_minutes,
        estimated_delivery_time,
        customer_rating,
        refund_flag
    FROM public.delivery_stats
)

SELECT
    distance_bucket,
    COUNT(*) AS total_orders,
    ROUND(100.0 * AVG(delayed_delivery_flag::int), 2) AS delay_rate_pct,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct
FROM distance_groups
GROUP BY distance_bucket
ORDER BY
    CASE distance_bucket
        WHEN 'Under 10 km' THEN 1
        WHEN '10-19.99 km' THEN 2
        WHEN '20-29.99 km' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- Average delivery time increased sharply as distance increased, from 56.31 minutes for orders under 10 km to 131.77 minutes for orders 30+ km.
-- Delay rate increased only modestly, from 8.79% for orders under 10 km to 10.26% for orders 30+ km.
-- Average minutes over estimate remained close to zero across distance buckets.
-- Distance increases delivery duration but does not appear to be a major delay-risk driver by itself.


-- 4. Delay rate by preparation time bucket
-- Evaluates whether longer restaurant preparation times are associated with higher delay risk.

WITH prep_groups AS (
    SELECT
        CASE
            WHEN preparation_time_minutes < 20 THEN 'Under 20 min'
            WHEN preparation_time_minutes >= 20 AND preparation_time_minutes < 30 THEN '20-29.99 min'
            WHEN preparation_time_minutes >= 30 AND preparation_time_minutes < 40 THEN '30-39.99 min'
            ELSE '40+ min'
        END AS prep_time_bucket,
        delayed_delivery_flag,
        delivery_time_minutes,
        estimated_delivery_time,
        customer_rating,
        refund_flag
    FROM public.delivery_stats
)

SELECT
    prep_time_bucket,
    COUNT(*) AS total_orders,
    ROUND(100.0 * AVG(delayed_delivery_flag::int), 2) AS delay_rate_pct,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct
FROM prep_groups
GROUP BY prep_time_bucket
ORDER BY
    CASE prep_time_bucket
        WHEN 'Under 20 min' THEN 1
        WHEN '20-29.99 min' THEN 2
        WHEN '30-39.99 min' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- Average delivery time increased as preparation time increased, from 77.18 minutes for orders under 20 minutes to 108.34 minutes for orders with 40+ minutes of prep time.
-- Delay rate increased only slightly, from 9.26% for orders under 20 minutes to 9.95% for orders with 40+ minutes of prep time.
-- Average minutes over estimate remained close to zero across preparation-time buckets.
-- Preparation time increases total delivery duration but does not appear to be a major delay-risk driver by itself.

-- 5. Delay rate by traffic level
-- Evaluates whether traffic severity is associated with higher delay risk.

WITH traffic_groups AS (
    SELECT
        CASE
            WHEN traffic_level_score < 3 THEN 'Low Traffic'
            WHEN traffic_level_score >= 3 AND traffic_level_score < 7 THEN 'Moderate Traffic'
            ELSE 'High Traffic'
        END AS traffic_bucket,
        delayed_delivery_flag,
        delivery_time_minutes,
        estimated_delivery_time,
        customer_rating,
        refund_flag
    FROM public.delivery_stats
)

SELECT
    traffic_bucket,
    COUNT(*) AS total_orders,
    ROUND(100.0 * AVG(delayed_delivery_flag::int), 2) AS delay_rate_pct,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct
FROM traffic_groups
GROUP BY traffic_bucket
ORDER BY
    CASE traffic_bucket
        WHEN 'Low Traffic' THEN 1
        WHEN 'Moderate Traffic' THEN 2
        ELSE 3
    END;

-- Result Summary:
-- Average delivery time increased from 86.89 minutes in low traffic to 100.79 minutes in high traffic.
-- Delay rate changed only slightly, from 9.15% in low traffic to 9.58% in high traffic.
-- Average minutes over estimate remained close to zero across traffic groups.
-- Traffic increases delivery duration but does not appear to be a major delay-risk driver by itself.