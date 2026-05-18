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

### 1.4 Demand by Month

Monthly order volume was relatively stable across the year. Each month accounted for roughly 8% to 9% of total orders, with Month 8 having the highest order volume at 1,295 orders and Month 11 having the lowest order volume at 1,198 orders.

Revenue followed a similar pattern. Month 8 generated the highest total revenue at $155,567.37, while Month 11 generated the lowest total revenue at $143,693.17. However, the difference between the highest and lowest months was relatively small, suggesting that this dataset does not show a strong seasonal demand pattern.

Because demand was evenly distributed across months, later analysis should focus more on operational factors such as delivery distance, preparation time, traffic, weather, and customer/order characteristics rather than seasonality.

### 1.5 Weekend/Festival Demand

Weekend and festival orders represented 20.58% of total order volume, while regular days accounted for 79.42% of orders. Although weekend/festival orders made up a smaller share of total demand, they had a higher average final amount paid.

The average final amount paid on weekend/festival orders was $126.73 compared to $117.10 on regular days, a difference of $9.63 per order. This suggests that special demand periods may generate higher-value transactions even if they do not represent the majority of total order volume.

Average tips, discounts, and item counts were relatively similar between the two groups, which suggests the higher final amount paid may be driven by other pricing or order-value factors rather than a major difference in basket size.

### 1.6 Demand by City Tier

City Tier 3 represented the largest share of demand, accounting for 7,520 orders, or 50.13% of total order volume. City Tiers 1 and 2 were nearly evenly split, with 3,723 orders and 3,757 orders respectively.

Revenue followed the same pattern. City Tier 3 generated $896,562.86 in total revenue, compared to $443,957.37 for City Tier 1 and $445,735.04 for City Tier 2. However, average final amount paid was very similar across all three city tiers, ranging from $118.64 to $119.25.

This suggests that City Tier 3 drives more revenue primarily because of higher order volume rather than higher customer spend per order. From an operational perspective, City Tier 3 may require greater delivery capacity and closer monitoring in later delay analysis because it accounts for roughly half of all orders.

### 1.7 Demand by Premium Customer Status

Premium customers represented 28.14% of total orders, while non-premium customers represented 71.86%. Although premium customers made up a smaller share of order volume, they generated higher average customer spend.

Premium customers had an average final amount paid of $128.80, compared to $115.28 for non-premium customers. This is a difference of $13.52 per order, or approximately 11.73% higher average spend.

Average items per order and average tip amounts were nearly identical between the two groups, suggesting that the higher premium customer spend may be driven by higher base order values or different pricing/discount behavior rather than larger baskets or higher tipping.