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

_To be completed._

### 3. Customer and Business Impact

_To be completed._

### 4. Recommendations

_To be completed._

## Tableau Dashboard

_Tableau Public link will be added here._

## Portfolio Case Study

_Portfolio website link will be added here._

## Author

Anton Jackson