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

-- 5. Demand by weekend/festival flag
-- Compares order volume, revenue, average spend, tips, discounts, and item count
-- between regular days and weekend/festival periods.

SELECT
    festival_or_weekend_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(tip_amount), 2) AS avg_tip,
    ROUND(AVG(discount_amount), 2) AS avg_discount
FROM public.delivery_stats
GROUP BY festival_or_weekend_flag
ORDER BY festival_or_weekend_flag;

-- Result Summary:
-- Regular days accounted for 11,913 orders, or 79.42% of total order volume.
-- Weekend/festival periods accounted for 3,087 orders, or 20.58% of total order volume.
-- Weekend/festival orders had a higher average final amount paid: $126.73 vs $117.10.
-- This represents a $9.63 increase per order, or roughly 8.22% higher average customer spend.
-- Tips, discounts, and item counts were relatively similar between the two groups.


-- 6. Demand by city tier
-- Compares order volume, revenue, average spend, basket size, tips, and delivery fees by market tier.

SELECT
    city_tier,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(tip_amount), 2) AS avg_tip,
    ROUND(AVG(delivery_fee), 2) AS avg_delivery_fee
FROM public.delivery_stats
GROUP BY city_tier
ORDER BY city_tier;

-- Result Summary:
-- City Tier 3 accounted for 7,520 orders, or 50.13% of total order volume.
-- City Tier 1 accounted for 3,723 orders, or 24.82%.
-- City Tier 2 accounted for 3,757 orders, or 25.05%.
-- City Tier 3 generated the highest total revenue at $896,562.86.
-- Average final amount paid was nearly identical across city tiers, ranging from $118.64 to $119.25.
-- City Tier 3 appears to drive revenue through higher order volume rather than higher spend per order.



-- 7. Demand by premium customer status
-- Compares order volume, revenue, average spend, basket size, tips, and loyalty score
-- between premium and non-premium customers.

SELECT
    premium_customer_flag,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(number_of_items), 2) AS avg_items_per_order,
    ROUND(AVG(tip_amount), 2) AS avg_tip,
    ROUND(AVG(customer_loyalty_score), 2) AS avg_loyalty_score
FROM public.delivery_stats
GROUP BY premium_customer_flag
ORDER BY premium_customer_flag;

-- Result Summary:
-- Premium customers accounted for 4,221 orders, or 28.14% of total order volume.
-- Non-premium customers accounted for 10,779 orders, or 71.86% of total order volume.
-- Premium customers had a higher average final amount paid: $128.80 vs $115.28.
-- This represents a $13.52 increase per order, or approximately 11.73% higher average spend.
-- Average items per order and average tip amounts were nearly identical between premium and non-premium customers.