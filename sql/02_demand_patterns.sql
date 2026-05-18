-- Section 1: Demand Patterns

-- Overall business summary
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

-- Demand by hour
SELECT
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue,
    ROUND(AVG(final_amount_paid), 2) AS avg_final_amount_paid
FROM public.delivery_stats
GROUP BY order_hour
ORDER BY order_hour;

-- Top 5 busiest order hours
SELECT
    order_hour,
    COUNT(*) AS total_orders,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders,
    ROUND(SUM(final_amount_paid), 2) AS total_revenue
FROM public.delivery_stats
GROUP BY order_hour
ORDER BY total_orders DESC
LIMIT 5;

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