# Food Delivery Operations Analysis - Portfolio Draft

## Project Overview

This project analyzes 15,000 food delivery orders to identify demand patterns, delivery delay drivers, and the impact of delayed deliveries on customer satisfaction and business outcomes.

## Business Problem

Food delivery platforms rely on efficient operations, accurate delivery estimates, and strong customer satisfaction. Delayed deliveries can affect customer ratings, tips, refunds, cancellations, and overall revenue performance.

## Section 1: Demand Patterns

I began the analysis by examining demand patterns across order timing, city tier, customer segment, promo usage, and order size. This helped establish a baseline understanding of when and where orders occur before investigating delivery delays and refund-related business impact.

### 1.1 Overall Business Summary

The dataset contains 15,000 food delivery orders and represents $1,786,255.27 in total customer payments. The average final amount paid per order was $119.08, with an average base order value of $113.95. Orders contained an average of 6.49 items, while the average delivery fee was $7.49, the average discount was $14.93, and the average tip amount was $12.57.

This initial summary provides a baseline view of order value and customer purchasing behavior before examining demand patterns by hour, city tier, customer segment, and delivery performance.

### 1.2 Demand by Hour

Order volume was relatively evenly distributed across the 24-hour period, with each hour accounting for roughly 3.8% to 4.4% of total orders. The highest-volume hour was 00:00 with 659 orders, while the lowest-volume hour was 12:00 with 574 orders.

Because no single hour showed a major demand spike, hourly order volume does not appear to be a major source of demand concentration in this dataset. This suggests that later delivery performance analysis should focus less on simple order volume by hour and more on operational factors such as preparation time, delivery distance, traffic, weather, and delivery partner performance.

### 1.3 Demand by Day of Week

Order volume showed a much stronger pattern by day of week than by hour. Day 1 accounted for 4,306 orders, representing 28.71% of all orders in the dataset. In contrast, Days 2 through 6 each accounted for roughly 14% of total orders.

This suggests that demand is concentrated heavily on Day 1, which may require additional operational capacity if this pattern reflects a real recurring business cycle. However, the dataset only includes day values from 1 to 6, so I avoided assigning specific weekday names without supporting documentation.

Day 6 had the highest average final amount paid at $126.48, compared to approximately $117–$118 across most other days. This indicates that Day 1 generated the most order volume, while Day 6 produced the highest average customer spend.