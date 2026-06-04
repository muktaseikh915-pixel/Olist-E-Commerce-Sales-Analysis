-- ====================================================================================

-- >>>>>>>>>>>>>>>>>> OLIST E-COMMERCE ANALYTICS PROJECTS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<

-- ====================================================================================
-- TOOLS USED : MySQL, Power BI
-- DATASET : Olist E-commerce Dataset

-- ====================================================================================
-- SELECT DATABASE
USE ecommerce_analytics;

-- ====================================================================================
-- DATA PREVIEW
-- ====================================================================================
-- Preview Customer data
SELECT * FROM olist_customers_dataset LIMIT 10;
-- Preview Orders data
SELECT * FROM olist_orders_dataset LIMIT 10;
-- Preview Payments data
SELECT * FROM olist_order_payments_dataset LIMIT 10;
-- Preview Product data
SELECT * FROM olist_product_dataset LIMIT 10;
-- Preview Order_iteams data
SELECT * FROM olist_order_items_dataset LIMIT 10;
-- ====================================================================================
-- DATA CLEANING & QUALITY ASSESSMENT
-- ====================================================================================
-- OBJECTIVE:
-- Check data quality before analysis 
-- Identify missing values,duplicates and inconsistencies
-- ====================================================================================
-- Check Missing Customer IDs
SELECT*FROM olist_customers_dataset WHERE customer_id IS NULL;
-- Check Missing Unique Customer IDs
SELECT*FROM olist_customers_dataset WHERE customer_unique_id IS NULL;
-- Check Missing order IDs
SELECT*FROM olist_orders_dataset WHERE order_id IS NULL;
-- Check Duplicate Orders
SELECT order_id ,COUNT(*) AS diplicae_count FROM olist_orders_dataset
GROUP BY order_id HAVING COUNT(*) > 1;
-- Check Missing Delivery Dates
SELECT*FROM olist_orders_dataset WHERE order_delivered_customer_date IS NULL;
-- Check Missing Payment Values
SELECT*FROM olist_order_payments_dataset WHERE payment_value  IS NULL;
-- Check Invalid Payment Values 
SELECT * FROM olist_order_payments_dataset WHERE payment_value <=0;
-- Check Missing Product Categories
SELECT*FROM olist_products_dataset WHERE product_category_name  IS NULL;

-- ====================================================================================
-- KPI ANALYSIS
-- ====================================================================================
-- KPI 1: Total Customer
SELECT COUNT(*) AS total_customers FROM olist_customers_dataset;
-- KPI 2: Total Orders
SELECT COUNT(*) AS total_orders FROM olist_orders_dataset;
-- KPI 3: Total Orders Items
SELECT COUNT(*) AS total_orders_items FROM olist_orders_items_dataset;
-- KPI 4: Total Revenue
SELECT SUM(payment_value) AS total_revenue FROM olist_order_payments_dataset;
-- KPI 5:  Average Order Value 
SELECT ROUND(AVG(Payment_value),2) AS avg_order_value FROM olist_order_payments_dataset;
-- KPI 6: Total Unique Customers
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers FROM olist_customers_dataset;
-- ====================================================================================
-- CUSTOMER ANALYSIS
-- ====================================================================================
-- Top Custmer States
SELECT customer_state,COUNT(*) AS total_customers FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC LIMIT 10;

-- Top 10 Customer Cities
SELECT customer_city,COUNT(*) AS total_customers FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- Unique customers
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset;

-- ====================================================================================
-- ORDER ANALYSIS
-- ====================================================================================
-- Order Status Distribution
SELECT order_status,COUNT(*) AS total_orders FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- Orders by Year
SELECT YEAR(order_purchase_timestamp) AS year,
COUNT(*) AS total_orders FROM olist_orders_dataset
GROUP BY year
ORDER BY year;
-- ====================================================================================
-- PAYMENT ANALYSIS
-- ===================================================================================-- Payment Type Distribution
-- Payment Type Distribution
SELECT payment_type,COUNT(*) AS total_payments FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_payments DESC;

-- ====================================================================================
-- REVENUE ANALYSIS
-- ====================================================================================
-- Monthly Revenue Trend
SELECT YEAR(o.order_Purchase_timestamp) AS year,
MONTH(o.order_Purchase_timestamp) AS month,
ROUND(SUM(p.payment_value),2) AS total_revenue
FROM olist_orders_dataset o JOIN olist_order_payments_dataset p 
ON o.order_id = p.order_id
GROUP BY year,month
ORDER BY year,month;

-- Top Revenue States
SELECT c.customer_state, ROUND(SUM(p.payment_value),2) AS revenue
FROM olist_customers_dataset c JOIN olist_orders_dataset o ON
c.customer_id = o.customer_id  JOIN olist_order_payments_dataset p ON
o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- ====================================================================================
-- DELIVERY ANALYSIS
-- ====================================================================================
-- Average Delivery Days
SELECT ROUND(AVG(DATEDIFF
(order_delivered_customer_date,order_Purchase_timestamp)),2) 
AS avg_delivery_days FROM olist_orders_dataset 
WHERE order_delivered_customer_date IS NOT NULL;

-- ====================================================================================
-- SALES PERFORMANCE ANALYSIS
-- ====================================================================================
-- Top 10 Highest Revenue Orders
SELECT order_id,SUM(payment_value) AS revenue FROM olist_order_payments_dataset
GROUP BY order_id
ORDER BY revenue DESC
LIMIT 10;

-- ====================================================================================
-- PRODUCT ANALYSIS
-- ====================================================================================
-- Top 10 product categories by total orders
SELECT p.product_category_name,COUNT(oi.order_id) AS total_orders 
FROM olist_products_dataset p JOIN olist_order_items_dataset
oi ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_orders DESC LIMIT 10;

-- ====================================================================================
-- PROJECT CONCLUSION
-- ====================================================================================

-- Key Insights:
-- 1. Analyzed customer, order, payment and product data.
-- 2. Identified total revenue, total orders and customer metrics.
-- 3. Evaluated monthly revenue trends and top-performing states.
-- 4. Analyzed payment methods and delivery performance.
-- 5. Generated business insights for decision-making.

-- End of Olist E-Commerce Analytics Project
-- Tools Used: MySQL, Power BI

-- ====================================================================================
-- THANK YOU
-- ====================================================================================
