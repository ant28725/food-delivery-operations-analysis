-- =========================================================
-- Section 1: Demand Patterns
-- Project: Food Delivery Operations Analysis
-- Purpose:
-- Analyze order volume, revenue, and customer demand patterns
-- across time, city tier, customer type, promo usage, and order size.
-- =========================================================

-- 1. Overall business summary

-- Establishes the baseline size and value of the dataset.

SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(delivery_fee), 2) AS avg_delivery_fee,
    ROUND(AVG(discount_amount), 2) AS avg_discount,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM public.delivery_stats;

-- Result:
-- total_orders: 15,000
-- total_revenue: $1,786,255.27
-- avg_final_amount_paid: $119.08
-- avg_order_value: $113.95
-- avg_items_per_order: 6.49
-- avg_delivery_fee: $7.49
-- avg_discount: $14.93
-- avg_tip: $12.57


-- 2. Demand by hour
-- Measures how order volume and revenue are distributed across the 24-hour day.

SELECT
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid
FROM public.delivery_stats
GROUP BY order_hour
ORDER BY order_hour;

-- Result Summary:
-- Hourly demand was relatively evenly distributed.
-- Each hour accounted for approximately 3.83% to 4.39% of all orders.
-- Highest-volume hour: 00:00 with 659 orders.
-- Lowest-volume hour: 12:00 with 574 orders.
-- No major hourly demand spike was observed.

-- 3. Demand by day of week
-- Measures order volume, revenue, average order value, items per order, and tip amount by day.

SELECT
    order_day_of_week,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM public.delivery_stats
GROUP BY order_day_of_week
ORDER BY order_day_of_week;

-- Result Summary:
-- Day 1 had the highest order volume with 4,306 orders, representing 28.71% of all orders.
-- Days 2 through 6 were relatively even, each representing about 14% of total orders.
-- Day 6 had the highest average final amount paid at $126.48.
-- Because the dataset only includes day values 1 through 6, specific weekday names were not assigned.

-- 4. Demand by month
-- Measures monthly order volume, revenue, average final amount paid, discounts, and tips.

SELECT
    order_month,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(discount_amount), 2) AS avg_discount,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM public.delivery_stats
GROUP BY order_month
ORDER BY order_month;

-- Result Summary:
-- Monthly demand was relatively stable, with each month representing approximately 8% to 9% of total orders.
-- Month 8 had the highest order volume with 1,295 orders and the highest revenue at $155,567.37.
-- Month 11 had the lowest order volume with 1,198 orders and the lowest revenue at $143,693.17.
-- No strong seasonal demand pattern was observed.

-- Demand by city tier
SELECT
    city_tier,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM public.delivery_stats
GROUP BY city_tier
ORDER BY city_tier;

-- Demand by festival/weekend flag
SELECT
    festival_or_weekend_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM public.delivery_stats
GROUP BY festival_or_weekend_flag
ORDER BY festival_or_weekend_flag;

-- Premium vs non-premium customer demand
SELECT
    premium_customer_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(tip_amount), 2) AS avg_tip,
    ROUND(AVG(customer_loyalty_score), 2) AS avg_loyalty_score
FROM public.delivery_stats
GROUP BY premium_customer_flag
ORDER BY premium_customer_flag;