# Food Delivery Operations Analysis

## Project Overview

This project analyzes 15,000 food delivery orders to identify demand patterns, delivery delay drivers, and the impact of delayed deliveries on customer satisfaction, refunds, cancellations, tips, and revenue.

The goal of the project is to answer a practical business question:

**What factors are driving delayed deliveries, and how do those delays affect customer satisfaction and business outcomes?**

## Business Problem

Food delivery platforms depend on speed, reliability, and customer satisfaction. Delayed deliveries can lead to lower customer ratings, reduced tips, higher refund rates, and increased customer dissatisfaction.

This analysis uses SQL and Tableau to investigate order demand patterns, delivery performance, and refund-related business impact.

## Tools Used

- PostgreSQL
- SQL
- VS Code
- Tableau Public
- GitHub

## Dataset

The dataset contains 15,000 food delivery orders with fields related to:

- Order timing
- City tier
- Customer information
- Delivery distance
- Preparation time
- Delivery time
- Estimated delivery time
- Traffic and weather scores
- Restaurant and delivery partner ratings
- Customer ratings
- Order value, discounts, tips, and final amount paid
- Refund, cancellation, promo, premium customer, and delay flags

## Key Business Questions

1. When does customer demand peak?
2. Which city tiers and customer segments generate the most revenue?
3. What factors are associated with delayed deliveries?
4. How do delayed deliveries affect customer ratings, tips, refunds, and cancellations?
5. What recommendations can reduce delay-related business risk?

## Repository Structure

```text
sql/
  01_create_table.sql
  02_demand_patterns.sql
  03_delivery_delay_analysis.sql
  04_refund_and_customer_impact.sql
  05_dashboard_views.sql

images/
  dashboard screenshots and visual exports

exports/
  cleaned or aggregated CSV outputs for Tableau

notes/
  project planning and portfolio draft notes

data/
  dataset information or sample data
```

## Analysis Sections

### 1. Demand Patterns

This section examines order volume, revenue, and customer demand patterns across hour of day, day of week, month, city tier, weekend/festival periods, premium customer status, promo-code usage, and order size.

#### Key Demand Findings

- The dataset contains **15,000 orders** and **$1,786,255.27** in total customer payments.
- The average final amount paid per order was **$119.08**, with an average base order value of **$113.95**.
- Hourly demand was relatively evenly distributed, with each hour accounting for roughly **3.8% to 4.4%** of total orders.
- Day 1 accounted for **28.71%** of all orders, making it the strongest day-of-week demand concentration.
- Monthly demand was stable, with each month accounting for roughly **8% to 9%** of total orders.
- Weekend/festival orders represented **20.58%** of total order volume but had a higher average final amount paid than regular-day orders.
- City Tier 3 accounted for **50.13%** of total orders and generated **$896,562.86** in revenue.
- Premium customers represented **28.14%** of orders but spent approximately **11.73% more per order** than non-premium customers.
- Promo-code orders accounted for **42.31%** of orders but had nearly identical average final payment compared to non-promo orders.
- Orders with **6+ items** represented **58.39%** of order volume, although average final amount paid remained similar across item-count groups.

#### Demand Pattern Takeaway

The demand analysis showed that order volume was not heavily concentrated by hour or month, but it was meaningfully segmented by day of week, city tier, premium customer status, weekend/festival periods, and order size. These patterns provide important context for the next phase of analysis, which investigates delayed deliveries and their impact on customer and business outcomes.

### 2. Delivery Delay Analysis

This section compares delayed and non-delayed orders and investigates which operational factors are associated with higher delay risk.

#### Key Delay Findings

- **1,420 orders** were flagged as delayed, representing an overall delay rate of **9.47%**.
- Delayed orders averaged **110.49 minutes**, compared to **92.43 minutes** for non-delayed orders.
- Delayed orders exceeded estimated delivery time by an average of **14.31 minutes**, while non-delayed orders arrived **1.50 minutes earlier than estimated** on average.
- Delivery distance, preparation time, traffic level, and weather severity all increased actual delivery duration, but each had only a modest effect on delay rate when analyzed individually.
- City Tier 3 accounted for **50.13%** of total orders and had the highest city-tier delay rate at **9.75%**, creating the greatest operational exposure due to volume.
- Delivery partner experience did not show a clear linear relationship with delay rate.
- The strongest delay patterns appeared when combining factors. City Tier 3 orders traveling **30+ km** with **40+ minutes** of preparation time had a **12.05%** delay rate across **722 orders** and an average delivery time of **145.87 minutes**.

#### Delivery Delay Takeaway

Delay risk was not strongly explained by any single operational factor. Instead, the highest-risk segments appeared when multiple conditions were combined, such as longer delivery distance, longer preparation time, and high-volume city tiers. This suggests that operational monitoring should focus on multi-factor risk profiles rather than isolated variables alone.

### 3. Customer and Business Impact

This section analyzes how delayed deliveries relate to customer ratings, tips, refunds, cancellations, and estimated refund-related revenue exposure.

#### Key Customer and Business Impact Findings

- Delayed orders had a refund rate of **12.61%**, compared to **3.23%** for non-delayed orders.
- Delayed orders were nearly **4x more likely** to result in a refund.
- Customer ratings were nearly identical between delayed and non-delayed orders: **4.01** for delayed orders vs **3.99** for non-delayed orders.
- Average tips were nearly identical: **$12.60** for delayed orders vs **$12.57** for non-delayed orders.
- Cancellation rates were also similar: **13.10%** for delayed orders vs **13.38%** for non-delayed orders.
- Using the non-delayed refund rate as a baseline, approximately **133 refunds** were associated with excess delay risk.
- Estimated delay-related refund exposure was **$15,756.80** across the 15,000-order dataset.
- Refund attribution analysis estimated that **21.54%** of all refunds were associated with delay-related excess risk, while **78.46%** were likely tied to other factors.
- Refund risk increased sharply once orders were more than **10 minutes late**.
- Orders **11-20 minutes late** had a **12.33%** refund rate, while orders **20+ minutes late** had a **17.57%** refund rate.
- The 11-20 minute late group represented the more important operational target because it combined elevated refund risk with much higher order volume than the 20+ minute group.

#### Customer and Business Impact Takeaway

Delayed deliveries did not meaningfully reduce ratings, tips, cancellations, or final payment in this synthetic dataset, but they were strongly associated with higher refund risk. The clearest business-impact threshold appeared when orders were more than 10 minutes late, suggesting that operational monitoring should focus on preventing orders from crossing that lateness threshold.
### 4. Recommendations

This section translates the SQL findings into business recommendations focused on reducing delay-related refund exposure and improving operational monitoring.

#### Key Recommendations

- **Monitor orders approaching the 10-minute late threshold.** Refund rates stayed near 3% for on-time/early orders and orders 1-10 minutes late, but increased to 12.33% for orders 11-20 minutes late and 17.57% for orders more than 20 minutes late.
- **Focus on multi-factor delay risk profiles.** Individual factors like distance, preparation time, traffic, and weather did not strongly explain delays on their own, but combined operational profiles revealed higher-risk segments.
- **Prioritize City Tier 3 for operational monitoring.** City Tier 3 accounted for 50.13% of total orders and had the greatest operational exposure due to volume.
- **Investigate refund reasons beyond delivery delays.** Delay-related excess risk explained an estimated 21.54% of all refunds, meaning most refund activity likely involved other factors not captured in the dataset.

#### Recommendation Takeaway

The strongest operational opportunity is to prevent orders from crossing the 10-minute late threshold, especially in high-volume or high-risk segments. However, because most refunds were not fully explained by delay-related risk, future analysis should include refund reason codes, missing-item complaints, food quality issues, support tickets, and customer reorder behavior.

## Tableau Dashboard

A Tableau dashboard will be created using the SQL view `public.food_delivery_dashboard_view`.

The dashboard will focus on:

- Demand patterns by hour, day, month, city tier, customer type, and order size
- Delivery delay rates by operational segment
- Lateness buckets and refund risk
- Refund exposure and business impact
- Recommended operational monitoring points

_Tableau Public link will be added here._

## Portfolio Case Study

_Portfolio website link will be added here._

## Author

Anton Jackson