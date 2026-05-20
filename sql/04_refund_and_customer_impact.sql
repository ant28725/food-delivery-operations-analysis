-- =========================================================
-- Section 3: Customer and Business Impact
-- Project: Food Delivery Operations Analysis
-- Purpose:
-- Analyze how delayed deliveries relate to customer ratings,
-- tips, refunds, cancellations, and estimated revenue exposure.
-- =========================================================

-- 1. Delayed vs non-delayed customer and business outcomes
-- Compares customer ratings, tips, final amount paid, refund rate,
-- and cancellation rate between delayed and non-delayed orders.

SELECT
    delayed_delivery_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(AVG(tip_amount), 2) AS avg_tip_amount,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct,
    ROUND(100.0 * AVG(cancellation_flag::int), 2) AS cancellation_rate_pct
FROM public.delivery_stats
GROUP BY delayed_delivery_flag
ORDER BY delayed_delivery_flag;

-- Result Summary:
-- Non-delayed orders accounted for 13,580 orders, or 90.53% of total orders.
-- Delayed orders accounted for 1,420 orders, or 9.47% of total orders.
-- Delayed orders had a refund rate of 12.61%, compared to 3.23% for non-delayed orders.
-- This represents a 9.38 percentage-point increase in refund rate.
-- Delayed orders were nearly 4x more likely to result in a refund.
-- Customer ratings were nearly identical: 4.01 for delayed orders vs 3.99 for non-delayed orders.
-- Average tips were nearly identical: $12.60 for delayed orders vs $12.57 for non-delayed orders.
-- Cancellation rates were similar: 13.10% for delayed orders vs 13.38% for non-delayed orders.
-- The clearest business impact of delays in this dataset is higher refund risk.

-- 2. Estimated delay-related refund exposure
-- Estimates the number of excess refunded orders and refund-related revenue exposure
-- associated with delayed deliveries by using the non-delayed refund rate as a baseline.

WITH refund_summary AS (
    SELECT
        delayed_delivery_flag,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN refund_flag = true THEN 1 ELSE 0 END) AS refunded_orders,
        AVG(refund_flag::int) AS refund_rate,
        AVG(final_amount_paid) AS avg_final_amount_paid,
        SUM(final_amount_paid) AS total_sales
    FROM public.delivery_stats
    GROUP BY delayed_delivery_flag
),

rates AS (
    SELECT
        MAX(CASE WHEN delayed_delivery_flag = true THEN total_orders END) AS delayed_orders,
        MAX(CASE WHEN delayed_delivery_flag = true THEN refunded_orders END) AS delayed_refunded_orders,
        MAX(CASE WHEN delayed_delivery_flag = false THEN refunded_orders END) AS nondelayed_refunded_orders,
        MAX(CASE WHEN delayed_delivery_flag = true THEN refund_rate END) AS delayed_refund_rate,
        MAX(CASE WHEN delayed_delivery_flag = false THEN refund_rate END) AS nondelayed_refund_rate,
        MAX(CASE WHEN delayed_delivery_flag = true THEN avg_final_amount_paid END) AS avg_delayed_order_value,
        MAX(CASE WHEN delayed_delivery_flag = true THEN total_sales END) AS delayed_order_sales
    FROM refund_summary
)

SELECT
    delayed_orders,
    delayed_refunded_orders,
    nondelayed_refunded_orders,
    ROUND(delayed_refund_rate * 100, 2) AS delayed_refund_rate_pct,
    ROUND(nondelayed_refund_rate * 100, 2) AS nondelayed_refund_rate_pct,
    ROUND((delayed_refund_rate - nondelayed_refund_rate) * 100, 2) AS excess_refund_rate_pct,
    ROUND(avg_delayed_order_value, 2) AS avg_delayed_order_value,
    ROUND(delayed_orders * (delayed_refund_rate - nondelayed_refund_rate), 0) AS estimated_excess_refunded_orders,
    ROUND(
        delayed_orders * (delayed_refund_rate - nondelayed_refund_rate) * avg_delayed_order_value,
        2
    ) AS estimated_delay_related_refund_loss,
    ROUND(delayed_order_sales, 2) AS delayed_order_sales
FROM rates;

-- Result Summary:
-- Delayed orders had a 12.61% refund rate compared to 3.23% for non-delayed orders.
-- This created an excess refund rate of 9.37 percentage points.
-- Using the non-delayed refund rate as a baseline, approximately 133 refunded orders were associated with excess delay risk.
-- The average delayed order value was $118.39.
-- Estimated delay-related refund exposure was $15,756.80.
-- Delayed orders represented $168,109.51 in total sales.
-- This estimate represents refund exposure associated with delays, not proven causal loss.

-- 3. Refund attribution: delays vs other factors
-- Estimates what percentage of total refunds are associated with excess delay risk
-- by comparing delayed refund behavior to the non-delayed refund baseline.

WITH refund_rates AS (
    SELECT
        delayed_delivery_flag,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN refund_flag = true THEN 1 ELSE 0 END) AS refunded_orders,
        AVG(refund_flag::int) AS refund_rate
    FROM public.delivery_stats
    GROUP BY delayed_delivery_flag
),

summary AS (
    SELECT
        SUM(total_orders) AS all_orders,
        SUM(refunded_orders) AS all_refunds,

        MAX(CASE WHEN delayed_delivery_flag = true THEN total_orders END) AS delayed_orders,
        MAX(CASE WHEN delayed_delivery_flag = true THEN refunded_orders END) AS delayed_refunds,
        MAX(CASE WHEN delayed_delivery_flag = true THEN refund_rate END) AS delayed_refund_rate,

        MAX(CASE WHEN delayed_delivery_flag = false THEN total_orders END) AS nondelayed_orders,
        MAX(CASE WHEN delayed_delivery_flag = false THEN refunded_orders END) AS nondelayed_refunds,
        MAX(CASE WHEN delayed_delivery_flag = false THEN refund_rate END) AS nondelayed_refund_rate
    FROM refund_rates
),

attribution AS (
    SELECT
        all_orders,
        all_refunds,
        delayed_orders,
        delayed_refunds,
        nondelayed_orders,
        nondelayed_refunds,
        delayed_refund_rate,
        nondelayed_refund_rate,
        delayed_orders * nondelayed_refund_rate AS expected_delayed_refunds_at_baseline,
        delayed_refunds - (delayed_orders * nondelayed_refund_rate) AS estimated_delay_attributable_refunds
    FROM summary
)

SELECT
    all_orders,
    all_refunds,

    delayed_orders,
    delayed_refunds,
    ROUND(delayed_refund_rate * 100, 2) AS delayed_refund_rate_pct,

    nondelayed_orders,
    nondelayed_refunds,
    ROUND(nondelayed_refund_rate * 100, 2) AS nondelayed_refund_rate_pct,

    ROUND((delayed_refund_rate - nondelayed_refund_rate) * 100, 2) AS excess_refund_rate_pct,

    ROUND(expected_delayed_refunds_at_baseline, 0) AS expected_delayed_refunds_if_no_delay_effect,
    ROUND(estimated_delay_attributable_refunds, 0) AS estimated_delay_attributable_refunds,

    ROUND(
        100.0 * estimated_delay_attributable_refunds / NULLIF(all_refunds, 0),
        2
    ) AS pct_of_all_refunds_attributed_to_delays,

    ROUND(
        100.0 * (all_refunds - estimated_delay_attributable_refunds) / NULLIF(all_refunds, 0),
        2
    ) AS pct_of_all_refunds_attributed_to_other_factors
FROM attribution;

-- Result Summary:
-- Total refunds: 618
-- Delayed refunds: 179
-- Non-delayed refunds: 439
-- Delayed refund rate: 12.61%
-- Non-delayed refund rate: 3.23%
-- Expected delayed refunds at non-delayed baseline: 46
-- Estimated delay-attributable refunds: 133
-- Estimated percentage of all refunds attributed to delays: 21.54%
-- Estimated percentage of all refunds attributed to other factors: 78.46%
-- Delays are an important refund driver, but most refunds appear associated with other variables.

-- 4. Other potential refund drivers
-- Compares refunded and non-refunded orders across customer, operational,
-- pricing, promo, and delivery performance variables.

SELECT
    refund_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(AVG(delayed_delivery_flag::int) * 100, 2) AS delayed_order_rate_pct,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(AVG(restaurant_rating), 2) AS avg_restaurant_rating,
    ROUND(AVG(delivery_partner_rating), 2) AS avg_partner_rating,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_time,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate,
    ROUND(AVG(preparation_time_minutes), 2) AS avg_prep_time,
    ROUND(AVG(delivery_distance_km), 2) AS avg_distance_km,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(discount_amount), 2) AS avg_discount,
    ROUND(AVG(number_of_items), 2) AS avg_items,
    ROUND(AVG(promo_code_used::int) * 100, 2) AS promo_usage_rate_pct,
    ROUND(AVG(premium_customer_flag::int) * 100, 2) AS premium_customer_rate_pct
FROM public.delivery_stats
GROUP BY refund_flag
ORDER BY refund_flag;

-- Result Summary:
-- Refunded orders represented 618 orders, or 4.12% of total orders.
-- Refunded orders had a delayed-order rate of 28.96%, compared to 8.63% for non-refunded orders.
-- Refunded orders averaged 3.26 minutes over estimate, while non-refunded orders averaged 0.14 minutes earlier than estimated.
-- Refunded orders had a slightly lower average customer rating: 3.92 vs 4.00.
-- Restaurant rating, partner rating, prep time, distance, order value, discounts, item count, and promo usage were very similar between refunded and non-refunded orders.
-- Delay-related performance is the clearest observed difference between refunded and non-refunded orders.
-- Additional refund reason data would be needed to explain the remaining refund activity more precisely.

-- 5. Refund rate by lateness bucket
-- Groups orders by minutes over estimated delivery time to identify
-- whether refund risk increases at specific lateness thresholds.

WITH lateness_groups AS (
    SELECT
        CASE
            WHEN delivery_time_minutes - estimated_delivery_time <= 0 THEN 'On Time / Early'
            WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 1 AND 10 THEN '1-10 min late'
            WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 11 AND 20 THEN '11-20 min late'
            ELSE '20+ min late'
        END AS lateness_bucket,
        refund_flag,
        customer_rating,
        tip_amount,
        final_amount_paid,
        cancellation_flag
    FROM public.delivery_stats
)

SELECT
    lateness_bucket,
    COUNT(*) AS total_orders,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(AVG(tip_amount), 2) AS avg_tip_amount,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(100.0 * AVG(cancellation_flag::int), 2) AS cancellation_rate_pct
FROM lateness_groups
GROUP BY lateness_bucket
ORDER BY
    CASE lateness_bucket
        WHEN 'On Time / Early' THEN 1
        WHEN '1-10 min late' THEN 2
        WHEN '11-20 min late' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- On-time or early orders had a 3.33% refund rate.
-- Orders 1-10 minutes late had a 3.10% refund rate.
-- Orders 11-20 minutes late had a 12.33% refund rate.
-- Orders more than 20 minutes late had a 17.57% refund rate.
-- Refund risk appears to increase sharply once orders are more than 10 minutes late.
-- Customer ratings, tips, and cancellation rates did not show the same clear worsening pattern.

-- 6. Refund exposure by lateness bucket
-- Calculates refunded order value by lateness bucket to identify which
-- late-order groups create the greatest financial exposure.

WITH lateness_groups AS (
    SELECT
        CASE
            WHEN delivery_time_minutes - estimated_delivery_time <= 0 THEN 'On Time / Early'
            WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 1 AND 10 THEN '1-10 min late'
            WHEN delivery_time_minutes - estimated_delivery_time BETWEEN 11 AND 20 THEN '11-20 min late'
            ELSE '20+ min late'
        END AS lateness_bucket,
        refund_flag,
        final_amount_paid
    FROM public.delivery_stats
)

SELECT
    lateness_bucket,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN refund_flag = true THEN 1 ELSE 0 END) AS refunded_orders,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct,
    ROUND(SUM(final_amount_paid), 2) AS total_sales,
    ROUND(SUM(CASE WHEN refund_flag = true THEN final_amount_paid ELSE 0 END), 2) AS refunded_order_value,
    ROUND(
        100.0 * SUM(CASE WHEN refund_flag = true THEN final_amount_paid ELSE 0 END)
        / NULLIF(SUM(final_amount_paid), 0),
        2
    ) AS refunded_value_pct_of_sales
FROM lateness_groups
GROUP BY lateness_bucket
ORDER BY
    CASE lateness_bucket
        WHEN 'On Time / Early' THEN 1
        WHEN '1-10 min late' THEN 2
        WHEN '11-20 min late' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- On-time or early orders had a 3.33% refund rate and $31,703.21 in refunded order value.
-- Orders 1-10 minutes late had a 3.10% refund rate and $21,403.50 in refunded order value.
-- Orders 11-20 minutes late had a 12.33% refund rate and $19,713.05 in refunded order value.
-- Orders more than 20 minutes late had the highest refund rate at 17.57%, but only $1,673.60 in refunded order value due to low order volume.
-- The 11-20 minute late group is more operationally important than the 20+ minute group because it combines elevated refund risk with much higher order volume.

-- 7. Refund and delay patterns by customer rating group
-- Groups orders by customer rating level to evaluate whether lower-rated orders
-- are associated with higher refund rates, delay rates, cancellations, or lower tips.

WITH rating_groups AS (
    SELECT
        CASE
            WHEN customer_rating >= 4.5 THEN 'High Rating'
            WHEN customer_rating >= 3.5 THEN 'Medium Rating'
            ELSE 'Low Rating'
        END AS rating_group,
        refund_flag,
        delayed_delivery_flag,
        cancellation_flag,
        tip_amount,
        final_amount_paid,
        delivery_time_minutes,
        estimated_delivery_time
    FROM public.delivery_stats
)

SELECT
    rating_group,
    COUNT(*) AS total_orders,
    ROUND(100.0 * AVG(refund_flag::int), 2) AS refund_rate_pct,
    ROUND(100.0 * AVG(delayed_delivery_flag::int), 2) AS delay_rate_pct,
    ROUND(100.0 * AVG(cancellation_flag::int), 2) AS cancellation_rate_pct,
    ROUND(AVG(tip_amount), 2) AS avg_tip_amount,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(delivery_time_minutes - estimated_delivery_time), 2) AS avg_minutes_over_estimate
FROM rating_groups
GROUP BY rating_group
ORDER BY
    CASE rating_group
        WHEN 'High Rating' THEN 1
        WHEN 'Medium Rating' THEN 2
        ELSE 3
    END;

-- Result Summary:
-- Low-rated orders had the highest refund rate at 5.12%.
-- High-rated orders had a 3.80% refund rate, and medium-rated orders had a 3.96% refund rate.
-- Customer rating groups did not show a clear relationship with delay rate.
-- Low-rated orders had a slightly lower delay rate at 8.80%.
-- Cancellation rates, tips, and final amount paid were relatively similar across rating groups.
-- Customer rating may have some relationship with refunds, but lateness is the clearer refund-risk signal.