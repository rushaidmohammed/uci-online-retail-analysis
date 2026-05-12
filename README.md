# UCI Online Retail Analysis
### End-to-end analysis project | Power Query → SQL Server → Power BI

---

## Project Overview

A full analytics pipeline built on the UCI Online Retail dataset — 541,909 transactions from a UK-based e-commerce business between December 2010 and December 2011.

The goal was to answer four core business questions using real-world data, with deliberate decisions made at every stage of cleaning, analysis, and visualisation.

---

## Tools Used

| Stage | Tool |
|---|---|
| Data Cleaning | Power Query (inside Power BI Desktop) |
| Analysis | SQL Server Express + SSMS |
| Dashboard | Power BI Desktop |

---

## Dataset

**Source:** UCI Machine Learning Repository — Online Retail Dataset  
**Link:** https://archive.ics.uci.edu/ml/datasets/online+retail   
**Note:** Raw data file not included due to size. Download directly from the UCI link above.
**Size:** 541,909 transactions | 8 columns  
**Scope:** UK-based e-commerce | December 2010 – December 2011

---

## Business Questions

1. How does revenue trend over time?
2. Which countries and products drive the most revenue?
3. How can customers be segmented using RFM analysis?
4. What does the cancellation rate look like and where is it concentrated?

---

## Dashboard Pages

### Page 1 — Executive Summary
Headline KPIs, monthly revenue trend with November 2011 peak annotation, 
top 10 countries by revenue, and secondary metrics including revenue per customer.

### Page 2 — Product Analysis
Top 10 products by revenue and units sold, Pareto/revenue concentration analysis, 
full top 25 product table with conditional formatting. 
Non-product line items (POSTAGE, MANUAL, DOTCOM POSTAGE etc.) excluded for accuracy.

### Page 3 — Customer Segmentation (RFM)
Customers segmented into Champions, Loyal, Potential Loyalists, At Risk, and Lost 
using Recency, Frequency, and Monetary scoring. Includes recommended actions per segment 
and RFM metrics table with conditional formatting.

### Page 4 — Cancellation Analysis
Cancellation rate by country (minimum 10 orders threshold applied), 
monthly cancellation trend, average order value comparison between 
completed and cancelled orders, and lost revenue KPI.

---

## Key Findings

- **UK dominance:** The UK accounts for ~82% of total revenue (£7.3M). 
  The next closest market is Netherlands at £285K
- **November peak:** November 2011 was the highest revenue month, 
  likely driven by Christmas wholesale ordering cycles
- **Cancellation rate:** 16.47% overall, but the monthly trend shows 
  consistent improvement through late 2011
- **Revenue fragmentation:** Revenue is spread across ~4,000 SKUs. 
  The top product accounts for just 1.6% of total revenue — 
  a classic long tail distribution
- **Customer segmentation:** Potential Loyalists are the largest segment (27.73%) 
  and represent the biggest conversion opportunity. Champions, while smaller, 
  drive disproportionate revenue
- **Cancellation concentration:** Japan shows elevated cancellation 
  rates among markets with sufficient order volume to be statistically meaningful

---

## Screenshots

![Executive Summary](screenshots/page1_executive_summary.png)

![Product Analysis](screenshots/page2_product_analysis.png)

![Customer Segmentation](screenshots/page3_customer_segmentation.png)

![Cancellation Analysis](screenshots/page4_cancellation_analysis.png)

---

## Data Cleaning Decisions

| Decision | Rationale |
|---|---|
| Removed ~135,000 blank CustomerID rows | Guest orders — no customer-level analysis possible |
| Removed UnitPrice = 0 rows | Samples and internal transfers, not real transactions |
| Removed 5,268 duplicate rows | Confirmed via SQL DISTINCT comparison |
| Retained negative revenue for cancellations | Intentional — represents accurate revenue reversals |
| Excluded non-product line items from product page | POSTAGE, MANUAL etc. are not products — excluded for analytical accuracy |
| RFM reference date set to 2011-12-10 | One day after last transaction in dataset |
| Countries with fewer than 10 orders excluded from cancellation chart | Small samples produce misleading cancellation rates |

---

## SQL Queries

All queries in the `/sql` folder. Run against `dbo.OnlineRetail_Clean`.

| File | Description |
|---|---|
| 01_create_clean_table.sql | Creates cleaned table from raw import |
| 02_revenue_by_month.sql | Monthly revenue trend |
| 03_top_countries.sql | Top 10 countries by revenue |
| 04_top_products.sql | Top 10 products by revenue and units sold |
| 05_cancellation_analysis.sql | Cancellation rate by country |
| 06_rfm_analysis.sql | RFM scoring and segmentation |

---

## DAX Measures

Key measures used in the dashboard:

- **Gross Revenue** — completed orders only (used for all charts)
- **Total Revenue** — net including cancellations (used for headline KPI only)
- **Cancellation Rate** — cancelled invoices / total invoices × 100
- **Lost Revenue** — absolute value of cancelled order revenue
- **RFM Segments** — scored and segmented in SQL, imported as CSV, 
  linked to transactions via CustomerID

---

## Known Limitations

- No cost or margin data available — all figures are revenue only
- 2010 data covers December only, making year-over-year comparisons directional rather than precise
- RFM segmentation thresholds are based on scoring quartiles — 
  segment boundaries would ideally be validated with business context
- Customer categorisation assumes all purchases are B2B wholesale; 
  dataset contains no explicit customer type flag

---

## Project Notes

This was built as a portfolio project during a career transition into data analytics. 
Every cleaning decision, analytical choice, and visualisation decision is documented 
deliberately — the reasoning matters as much as the output.
