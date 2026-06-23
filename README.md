# E-Commerce SQL Analysis
 
**Product analytics case study using BigQuery and the TheLook E-Commerce public dataset — covering revenue performance, customer behaviour, market analysis, and growth trends.**
 
---
 
## Business Context
 
TheLook is a fictional e-commerce retailer operating across multiple global markets. This analysis answers key product and business questions a PM or analyst team would ask when assessing platform performance, customer value, and revenue health.
 
---
 
## Objectives
 
- Identify top revenue-generating product categories
- Understand market distribution across countries
- Track monthly revenue trends and growth
- Assess order fulfilment and cancellation rates
- Surface top customers by lifetime value
- Rank customers by spend within each market
---
 
## Dataset
 
**Source:** Google BigQuery Public Dataset — `bigquery-public-data.thelook_ecommerce`
 
**Tables used:**
- `order_items` — individual line items, sale prices, statuses
- `orders` — order-level status and dates
- `users` — customer demographics and location
- `products` — product categories, brands, pricing
---
 
## Queries and Business Questions
 
| # | Query | Business Question |
|---|---|---|
| 01 | Explore order items | What does the order_items table contain? |
| 02 | Revenue by product ID | Which products generate the most revenue? |
| 03 | Explore products table | What product metadata is available? |
| 04 | Top revenue categories | Which product categories drive the most revenue? |
| 05 | Explore users table | What customer data is available? |
| 06 | Orders by country | Which markets have the most customers? |
| 07 | Explore order items full | Full data scan for quality checks |
| 08 | Monthly revenue trend | How has revenue trended over the last 12 months? |
| 09 | Order status breakdown | What percentage of orders are cancelled or returned? |
| 10 | Explore order statuses | What order status values exist in the dataset? |
| 11 | Explore order items raw | Raw data scan for exploration |
| 12 | Top customers by LTV | Who are the top 10 customers by lifetime value? |
| 13 | Rank customers by country | Who are the top spenders within each market? |
| 14 | Month-on-month revenue growth | How much did revenue grow compared to the previous month? |
 
---
 
## Key Findings
 
**Revenue**
- Outerwear and Coats is the top revenue category, generating significantly more than any other segment
- Revenue has grown consistently over the last 12 months with a notable dip in February 2026
- June 2026 shows the highest monthly revenue on record
**Orders**
- 15% of orders are cancelled and 10% are returned — roughly 1 in 4 orders represents lost revenue
- Only 25% of orders reach Complete status
**Markets**
- China and the United States are the two largest markets by user count
- Data quality issues exist — Spain appears as both Spain and España, Brasil may duplicate Brazil
**Customers**
- Top customers by lifetime value show significant concentration — the #1 customer spends nearly 50% more than #2
- Country-level ranking reveals distinct high-value customer segments per market
---
 
## SQL Concepts Demonstrated
 
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- `SUM`, `COUNT`, `COUNTIF`
- `JOIN` across multiple tables
- `FORMAT_DATE`, `TIMESTAMP_SUB`, `CURRENT_TIMESTAMP`
- `CONCAT` for string manipulation
- `DISTINCT` for deduplication
- **Window functions:** `RANK() OVER (PARTITION BY ...)`, `LAG() OVER (ORDER BY ...)`
- Subqueries
---
 
## Tools
 
`BigQuery` `SQL` `Google Cloud`
 
---
 
## Author
 
Brandon Muchenje | [LinkedIn](https://linkedin.com/in/brandon-m-muchenje) | [GitHub](https://github.com/brandonmuch)
