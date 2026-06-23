-- ============================================================
-- ECOMMERCE SQL ANALYSIS
-- Dataset: bigquery-public-data.thelook_ecommerce
-- Author: Brandon Muchenje
-- ============================================================


-- ============================================================
-- 01. EXPLORE ORDER ITEMS
-- Preview the order_items table structure and contents
-- ============================================================

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;


-- ============================================================
-- 02. REVENUE BY PRODUCT ID
-- Find total revenue generated per product
-- ============================================================

-- Finding the total revenue for each product id listed
SELECT 
  product_id, 
  SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 03. EXPLORE PRODUCTS TABLE
-- Preview the products table structure and contents
-- ============================================================

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 10;


-- ============================================================
-- 04. TOP REVENUE CATEGORIES
-- Find the top 10 revenue-generating product categories
-- using a JOIN between order_items and products tables
-- ============================================================

SELECT 
  p.category,
  SUM(oi.sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
  ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 05. EXPLORE USERS TABLE
-- Preview the users table structure and contents
-- ============================================================

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 10;


-- ============================================================
-- 06. ORDERS BY COUNTRY
-- Count total users per country to identify key markets
-- Note: Spain appears as both 'Spain' and 'España' due to data quality issue
-- Brasil may also be a duplicate of Brazil
-- ============================================================

SELECT 
  country, 
  COUNT(country) AS total_users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country
ORDER BY total_users DESC;


-- ============================================================
-- 07. EXPLORE ORDER ITEMS (FULL)
-- Full scan of order_items table
-- ============================================================

SELECT * 
FROM `bigquery-public-data.thelook_ecommerce.order_items`;


-- ============================================================
-- 08. MONTHLY REVENUE TREND
-- Assess total revenue over the past 12 months
-- ============================================================

SELECT 
  FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
  SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 365 DAY)
GROUP BY month
ORDER BY month ASC;


-- ============================================================
-- 09. ORDER STATUS BREAKDOWN
-- Calculate the percentage of orders by status
-- ============================================================

SELECT 
  COUNTIF(status = 'Cancelled') / COUNT(*) * 100 AS percentage_cancelled,
  COUNTIF(status = 'Returned') / COUNT(*) * 100 AS percentage_returned,
  COUNTIF(status = 'Complete') / COUNT(*) * 100 AS percentage_completed,
  COUNTIF(status = 'Processing') / COUNT(*) * 100 AS percentage_processing,
  COUNTIF(status = 'Shipped') / COUNT(*) * 100 AS percentage_shipped
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- ============================================================
-- 10. EXPLORE ORDER STATUSES
-- Identify all distinct order status values in the dataset
-- ============================================================

SELECT DISTINCT status
FROM `bigquery-public-data.thelook_ecommerce.orders`;


-- ============================================================
-- 11. EXPLORE ORDER ITEMS (RAW)
-- Raw full scan of order_items for data exploration
-- ============================================================

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`;


-- ============================================================
-- 12. TOP CUSTOMERS BY LIFETIME VALUE (LTV)
-- Identify the top 10 customers by total spend across all orders
-- ============================================================

SELECT 
  CONCAT(u.first_name, ' ', u.last_name) AS customer_name, 
  SUM(oi.sale_price) AS total_revenue 
FROM `bigquery-public-data.thelook_ecommerce.users` u
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON u.id = oi.user_id
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 13. RANK CUSTOMERS BY COUNTRY (WINDOW FUNCTION: RANK)
-- Rank customers by total spend within each country
-- Uses RANK() window function with PARTITION BY
-- ============================================================

SELECT 
  CONCAT(u.first_name, ' ', u.last_name) AS customer_name,
  u.country, 
  SUM(oi.sale_price) AS total_revenue,
  RANK() OVER (PARTITION BY u.country ORDER BY SUM(oi.sale_price) DESC) AS customer_rank
FROM `bigquery-public-data.thelook_ecommerce.users` u
JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
  ON u.id = oi.user_id
GROUP BY customer_name, u.country
ORDER BY u.country, customer_rank ASC
LIMIT 10;


-- ============================================================
-- 14. MONTH-ON-MONTH REVENUE GROWTH (WINDOW FUNCTION: LAG)
-- Calculate revenue growth compared to the previous month
-- Uses LAG() window function to reference prior month revenue
-- ============================================================

SELECT 
  month,
  total_revenue,
  LAG(total_revenue, 1) OVER (ORDER BY month) AS previous_month_revenue,
  total_revenue - LAG(total_revenue, 1) OVER (ORDER BY month) AS revenue_growth
FROM (
  SELECT 
    FORMAT_DATE('%Y-%m', DATE(created_at)) AS month,
    SUM(sale_price) AS total_revenue
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE created_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 365 DAY)
  GROUP BY month
  ORDER BY month ASC
)
ORDER BY month;
