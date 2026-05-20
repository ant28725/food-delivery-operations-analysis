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

### 1.8 Demand by Promo Code Usage

Promo-code orders accounted for 42.31% of total order volume, while non-promo orders accounted for 57.69%. Despite the high usage rate, promo-code orders did not show a meaningful difference in average customer spend.

The average final amount paid was $119.01 for promo-code orders compared to $119.14 for non-promo orders, a difference of only $0.13. Average order value, discount amount, item count, and tip amount were also nearly identical between the two groups.

This suggests that promo-code usage was common, but it did not appear to materially increase average order value or final customer payment in this dataset. A deeper analysis would require customer acquisition, retention, and repeat-order data to determine whether promos improved long-term customer behavior.

### 1.9 Demand by Order Size

Orders with 6 or more items represented the largest share of demand, accounting for 8,759 orders, or 58.39% of total order volume. Smaller orders were less common, with 1-item orders representing only 8.35% of all orders.

Despite the difference in item count, average final amount paid was very similar across order-size groups. The average final amount paid ranged from $118.84 for 6+ item orders to $119.93 for 2-3 item orders. Average delivery time also remained relatively stable, ranging from 93.76 to 94.27 minutes across item-count groups.

This suggests that while larger item-count orders dominate order volume, item count alone does not appear to meaningfully increase average customer spend or delivery time in this dataset.

### Section 1 Summary: Demand Patterns

The demand analysis showed that order volume was relatively stable by hour and month, but more concentrated by day of week, city tier, premium customer status, and order size.

The strongest demand concentration appeared on Day 1, which accounted for 28.71% of all orders. City Tier 3 also represented a major share of the business, generating 50.13% of total order volume and roughly half of total revenue. Premium customers made up only 28.14% of orders but had an average final amount paid of $128.80, which was 11.73% higher than non-premium customers.

Weekend/festival orders represented 20.58% of total volume but had a higher average final amount paid than regular-day orders. Promo-code usage was common, appearing in 42.31% of orders, but promo-code orders did not show a meaningful difference in average final amount paid compared to non-promo orders.

Overall, this section established that demand is not heavily concentrated by hour or month, but is meaningfully segmented by day, city tier, premium customer status, and order size. These demand patterns provide context for the next section, which investigates delayed deliveries and their impact on customer and business outcomes.

## Section 2: Delivery Delay Analysis

After establishing demand patterns, I analyzed delivery performance to understand how often orders were delayed and which operational factors were associated with delay risk. This section compares delayed and non-delayed orders across actual delivery time, estimated delivery time, preparation time, distance, traffic, weather, and delivery partner characteristics.

### 2.1 Overall Delay Summary

The dataset contains 15,000 total orders, of which 1,420 were flagged as delayed. This represents an overall delay rate of 9.47%.

The average actual delivery time and average estimated delivery time were both 94.14 minutes across the full dataset, resulting in an average minutes-over-estimate value of 0.00. This suggests that overall averages alone may hide important differences between delayed and non-delayed orders. To better understand delay patterns, I next compared delayed and non-delayed orders directly.

### 2.2 Delayed vs Non-Delayed Orders

Delayed orders represented 9.47% of total orders, while non-delayed orders represented 90.53%. When comparing the two groups directly, delayed orders had an average delivery time of 110.49 minutes compared to 92.43 minutes for non-delayed orders. This means delayed orders took approximately 18.06 minutes longer on average.

Delayed orders also exceeded their estimated delivery time by an average of 14.31 minutes, while non-delayed orders arrived 1.50 minutes earlier than estimated on average. This confirms that the delay flag captures a meaningful difference in delivery performance.

However, the average preparation time, delivery distance, traffic score, and weather score were only slightly higher for delayed orders. This suggests that the drivers of delay may not be obvious from simple averages alone and should be investigated using grouped/bucketed analysis.

### 2.3 Delay Rate by Delivery Distance

Delivery distance had a strong relationship with actual delivery time. Orders under 10 km averaged 56.31 minutes, while orders 30 km or farther averaged 131.77 minutes.

However, delay rate only increased modestly across distance buckets. Orders under 10 km had an 8.79% delay rate, while orders 30 km or farther had a 10.26% delay rate. Average minutes over estimate remained close to zero across all distance groups.

This suggests that while longer delivery distances naturally lead to longer delivery times, distance alone does not appear to be a major delay driver in this dataset. Estimated delivery times may already account for distance reasonably well.

### 2.4 Delay Rate by Preparation Time

Preparation time showed a clear relationship with total delivery duration. Orders with preparation times under 20 minutes averaged 77.18 minutes, while orders with preparation times of 40 minutes or more averaged 108.34 minutes.

However, delay rates remained relatively similar across preparation-time groups. Orders under 20 minutes had a 9.26% delay rate, while orders with 40+ minutes of preparation time had a 9.95% delay rate.

This suggests that longer preparation times increase total delivery duration, but they do not appear to substantially increase delay risk by themselves. Similar to delivery distance, estimated delivery times may already account for preparation time reasonably well.

### 2.5 Delay Rate by Traffic Level

Traffic level was associated with longer delivery times. Low-traffic orders averaged 86.89 minutes, while high-traffic orders averaged 100.79 minutes.

However, delay rates were relatively similar across traffic groups. Low-traffic orders had a 9.15% delay rate, moderate-traffic orders had a 9.61% delay rate, and high-traffic orders had a 9.58% delay rate.

This suggests that higher traffic conditions increased delivery duration, but did not dramatically increase the likelihood of an order being flagged as delayed. Similar to distance and preparation time, the estimated delivery time may already account for traffic conditions reasonably well.

### 2.6 Delay Rate by Weather Severity

Weather severity was associated with longer delivery times. Low-severity weather orders averaged 88.43 minutes, while high-severity weather orders averaged 99.48 minutes.

However, delay rates remained relatively close across weather groups. Low-severity weather orders had a 9.46% delay rate, moderate-severity weather orders had a 9.04% delay rate, and high-severity weather orders had a 10.02% delay rate.

This suggests that more severe weather conditions increased delivery duration, but did not dramatically increase delay risk by themselves. As with distance, preparation time, and traffic, estimated delivery times may already account for weather-related delivery conditions reasonably well.

### 2.7 Delay Rate by City Tier

City Tier 3 accounted for 50.13% of total orders, making it the largest demand segment in the dataset. It also had the highest delay rate at 9.75%, compared to 9.32% for City Tier 1 and 9.05% for City Tier 2.

Although City Tier 3 had the highest delay rate, the difference between city tiers was relatively small. Average delivery time, preparation time, delivery distance, traffic score, and weather score were also very similar across city tiers.

This suggests that City Tier 3 carries the greatest operational exposure because it handles the most order volume, but it does not appear dramatically less efficient than the other city tiers. The business risk is more about scale than a major difference in delivery performance.

### 2.8 Delay Rate by Delivery Partner Experience

Delivery partner experience did not show a clear linear relationship with delay rate. Some experience levels had lower delay rates, such as 7 years at 8.36%, 9 years at 8.47%, and 15 years at 8.39%. However, other higher-experience groups still had elevated delay rates, including 14 years at 11.23%.

Average delivery times were also relatively similar across experience levels, generally ranging from about 92 to 96 minutes. Delivery partner ratings were nearly identical across groups, staying close to 4.2.

This suggests that delivery partner experience alone does not appear to be a strong predictor of delayed deliveries in this dataset. Delays may be influenced more by a combination of factors rather than partner experience by itself.

### 2.9 High-Risk Operational Segments

After analyzing individual delay factors, I grouped orders by city tier, delivery distance bucket, and preparation-time bucket to identify higher-risk operational segments. This helped determine whether combinations of factors produced stronger delay patterns than any single variable alone.

The highest delay-rate segment was City Tier 1 orders traveling 30+ km with under 20 minutes of preparation time, which had a 12.50% delay rate across 232 orders. However, the more operationally important segment was City Tier 3 orders traveling 30+ km with 40+ minutes of preparation time. This segment had a 12.05% delay rate across 722 orders and an average delivery time of 145.87 minutes.

This suggests that delay risk is better understood through multi-factor order profiles rather than isolated variables. While distance, preparation time, traffic, and weather each increased actual delivery duration, the highest-risk delay segments appeared when multiple operational conditions were combined.

### Section 2 Summary: Delivery Delay Analysis

The delivery delay analysis showed that 1,420 out of 15,000 orders were flagged as delayed, resulting in an overall delay rate of 9.47%. Delayed orders averaged 110.49 minutes compared to 92.43 minutes for non-delayed orders, and delayed orders exceeded their estimated delivery time by an average of 14.31 minutes.

Individual operational factors such as delivery distance, preparation time, traffic level, and weather severity all increased actual delivery duration. However, these variables only modestly increased delay rates when analyzed separately. This suggests that estimated delivery times may already account for many of these operational conditions.

The strongest delay insight came from analyzing combined operational segments. Certain combinations of city tier, distance, and preparation time produced delay rates above the overall average. In particular, City Tier 3 orders traveling 30+ km with 40+ minutes of preparation time had a 12.05% delay rate across 722 orders and an average delivery time of 145.87 minutes.

Overall, delay risk appears to be driven less by one single factor and more by combinations of operational conditions. This provides a stronger foundation for targeted monitoring, staffing, and delivery management strategies.

## Section 3: Customer and Business Impact

After identifying delivery delay patterns, I analyzed whether delayed deliveries were associated with worse customer and business outcomes. This section compares delayed and non-delayed orders across customer ratings, tips, refunds, cancellations, and final amount paid.

### 3.1 Delayed vs Non-Delayed Customer and Business Outcomes

Delayed deliveries were strongly associated with higher refund risk, but they did not show a meaningful negative relationship with customer ratings, tips, cancellations, or final amount paid.

Delayed orders had a refund rate of 12.61%, compared to 3.23% for non-delayed orders. This represents a 9.38 percentage-point increase in refund rate, meaning delayed orders were nearly four times more likely to result in a refund.

However, average customer ratings were nearly identical between the two groups, with delayed orders averaging 4.01 compared to 3.99 for non-delayed orders. Average tips were also nearly identical at $12.60 for delayed orders and $12.57 for non-delayed orders. Cancellation rates were similar as well, with delayed orders at 13.10% and non-delayed orders at 13.38%.

This suggests that, in this synthetic dataset, the clearest business impact of delayed deliveries is refund risk rather than lower ratings, lower tips, or increased cancellations.

### 3.2 Estimated Delay-Related Refund Exposure

Because delayed orders had a much higher refund rate than non-delayed orders, I estimated the potential refund-related revenue exposure associated with delays.

Delayed orders had a refund rate of 12.61%, compared to 3.23% for non-delayed orders. This created an excess refund rate of 9.37 percentage points. Using the non-delayed refund rate as a baseline, I estimated that approximately 133 refunded orders were associated with excess delay risk.

The average final amount paid for delayed orders was $118.39. Multiplying the estimated excess refunded orders by the average delayed order value produced an estimated delay-related refund exposure of $15,756.80 across the 15,000-order dataset.

This estimate should be interpreted as an approximation of refund exposure associated with delays, not as a causal measurement. However, it helps translate the operational delay problem into a business-impact metric.

### 3.3 Refund Attribution: Delays vs Other Factors

To estimate how much of the refund problem was associated with delays, I used the non-delayed refund rate as a baseline. Non-delayed orders had a refund rate of 3.23%, while delayed orders had a refund rate of 12.61%.

Based on the non-delayed refund baseline, delayed orders would have been expected to generate approximately 46 refunds. Instead, delayed orders generated 179 refunds. The difference of 133 refunds represents the estimated excess refund volume associated with delayed deliveries.

Across the full dataset, there were 618 total refunds. The estimated 133 delay-attributable refunds represented 21.54% of all refunds, while the remaining 78.46% were likely associated with other factors.

This suggests that delivery delays are an important contributor to refunds, but they do not explain the majority of refund activity. Other potential refund drivers may include restaurant quality, order accuracy, customer expectations, promo behavior, order value, delivery partner performance, or issues not directly captured in the dataset.

### 3.4 Other Potential Refund Drivers

After estimating that 21.54% of refunds were associated with excess delay risk, I compared refunded and non-refunded orders to identify other possible refund drivers.

Refunded orders had a delayed-order rate of 28.96%, compared to only 8.63% for non-refunded orders. Refunded orders also averaged 3.26 minutes over the estimated delivery time, while non-refunded orders arrived 0.14 minutes earlier than estimated on average.

Customer ratings were slightly lower for refunded orders, averaging 3.92 compared to 4.00 for non-refunded orders. However, other variables such as restaurant rating, delivery partner rating, preparation time, delivery distance, order value, discount amount, item count, and promo usage were very similar between refunded and non-refunded orders.

This suggests that delay-related performance is the clearest observed difference between refunded and non-refunded orders in the available data. However, because most refunds were not attributed to delay-related excess risk, additional variables would likely be needed to explain the remaining refund activity. Useful missing data could include missing-item complaints, incorrect orders, food quality issues, customer support tickets, refund reason codes, and customer reorder behavior.

### 3.5 Refund Rate by Lateness Bucket

To better understand the relationship between lateness and refunds, I grouped orders by how far actual delivery time exceeded estimated delivery time.

Refund rates remained low for orders that were on time, early, or only slightly late. On-time or early orders had a refund rate of 3.33%, while orders that were 1-10 minutes late had a refund rate of 3.10%.

However, refund risk increased sharply once orders were more than 10 minutes late. Orders that were 11-20 minutes late had a refund rate of 12.33%, and orders that were more than 20 minutes late had a refund rate of 17.57%.

This suggests that the most important operational threshold may be preventing orders from crossing the 10-minute late mark. While minor lateness did not appear to increase refund risk, more substantial lateness was associated with a much higher likelihood of refund activity.

### 3.6 Refund Exposure by Lateness Bucket

I also analyzed refunded order value by lateness bucket to understand which lateness groups created the greatest financial exposure.

Orders more than 20 minutes late had the highest refund rate at 17.57%, but this group contained only 74 orders and represented $1,673.60 in refunded order value. In contrast, orders that were 11-20 minutes late had a lower refund rate of 12.33%, but this group contained 1,346 orders and represented $19,713.05 in refunded order value.

This suggests that the 11-20 minute late group is more operationally important than the 20+ minute late group because it combines elevated refund risk with much higher order volume. From a business perspective, preventing orders from crossing the 10-minute late threshold could reduce a larger portion of refund-related exposure.

### 3.7 Refund and Delay Patterns by Customer Rating Group

I grouped orders into high, medium, and low customer-rating categories to determine whether lower-rated orders showed worse refund, delay, cancellation, or revenue outcomes.

Low-rated orders had a higher refund rate at 5.12%, compared to 3.80% for high-rated orders and 3.96% for medium-rated orders. However, the difference was much smaller than the refund-rate increase observed for late deliveries.

Customer rating groups did not show a clear relationship with delay rate. Low-rated orders actually had a slightly lower delay rate at 8.80%, compared to 9.28% for high-rated orders and 9.70% for medium-rated orders. Cancellation rates, average tip amounts, and final amount paid were also relatively similar across rating groups.

This suggests that customer ratings may have some relationship with refund behavior, but they are not the strongest signal in this dataset. Lateness remained the clearer indicator of elevated refund risk.

### Section 3 Summary: Customer and Business Impact

The customer and business impact analysis showed that delayed deliveries were strongly associated with higher refund risk, but not with lower ratings, lower tips, higher cancellations, or lower final payment.

Delayed orders had a refund rate of 12.61%, compared to 3.23% for non-delayed orders. Using the non-delayed refund rate as a baseline, I estimated that 133 refunds were associated with excess delay risk, representing approximately $15,756.80 in delay-related refund exposure.

Refund attribution analysis suggested that 21.54% of all refunds were associated with delay-related excess risk, while 78.46% were likely connected to other factors not fully captured in the dataset. When comparing refunded and non-refunded orders, the clearest observed difference was lateness: refunded orders had a delayed-order rate of 28.96%, compared to 8.63% for non-refunded orders.

The strongest threshold finding came from grouping orders by lateness. Refund rates remained near 3% for on-time/early orders and orders 1-10 minutes late, but increased to 12.33% for orders 11-20 minutes late and 17.57% for orders more than 20 minutes late. This suggests that preventing orders from crossing the 10-minute late threshold could reduce refund-related exposure.

Overall, lateness was the clearest business-impact signal in the available data. However, because this is a synthetic dataset and most refunds were not fully explained by delay-related risk, additional data such as refund reason codes, missing item complaints, food quality issues, support tickets, and customer reorder behavior would be needed for a more complete refund analysis.