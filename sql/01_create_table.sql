DROP TABLE IF EXISTS public.delivery_stats;

CREATE TABLE public.delivery_stats (
    order_id UUID PRIMARY KEY,
    city_tier INT,
    customer_age INT,
    customer_loyalty_score NUMERIC,
    order_hour INT,
    order_day_of_week INT,
    order_month INT,
    delivery_distance_km NUMERIC,
    preparation_time_minutes INT,
    delivery_time_minutes INT,
    estimated_delivery_time INT,
    traffic_level_score NUMERIC,
    weather_severity_score NUMERIC,
    restaurant_rating NUMERIC,
    delivery_partner_rating NUMERIC,
    customer_rating NUMERIC,
    order_value NUMERIC,
    delivery_fee NUMERIC,
    discount_amount NUMERIC,
    tip_amount NUMERIC,
    final_amount_paid NUMERIC,
    number_of_items INT,
    cancellation_flag BOOLEAN,
    delayed_delivery_flag BOOLEAN,
    refund_flag BOOLEAN,
    promo_code_used BOOLEAN,
    premium_customer_flag BOOLEAN,
    festival_or_weekend_flag BOOLEAN,
    delivery_partner_experience_years INT,
    delivery_efficiency_score NUMERIC
);

-- Import command used in psql:
-- \copy public.delivery_stats FROM '/Users/antonjackson/Desktop/Datasets/food_delivery_analytics_cleaned.csv' WITH (FORMAT csv, HEADER true);