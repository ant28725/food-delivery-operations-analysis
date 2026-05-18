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