## 🛒 UK Tesbury Retail Sales Performance Analysis -- tell me later to update
#### SQL | Retail Analytics | Business Intelligence

# 📌 Project Overview

This project analyses UK retail sales performance for Tesbury, using anonymised and synthetic transactional data structured to reflect real-world UK retail operations.

The analysis focuses on evaluating sales performance, product efficiency, store and city performance, pricing effectiveness, promotion impact, and time-based revenue trends, with the objective of producing actionable, business-oriented insights.

🔍 SQL Queries? Check them out here : [4_Analysis folder](/4_Analysis/)


# 🎯 Business Objectives

- Measure overall retail performance using core KPIs

- Identify top and underperforming products, stores, and cities

- Detect pricing inefficiencies (high volume vs low revenue products)

- Analyse revenue trends over time (Monthly, MoM, YoY, Yearly)

- Assess whether promotions improve performance

- Translate SQL outputs into clear business insights and recommendations

# 🧮 Headline KPIs (Overall Performance)
### KPI	Value
```
- Total Revenue                   £4,718,972 
- Total Units Sold                £600,612 
- Total Transactions              £200,000 
- Average Transaction Value (ATV) £23.59
```
### Insight:
- Tesbury operates a high-volume, mid-value retail model, where revenue is driven primarily by transaction frequency rather than premium pricing.

# 📊 Revenue Contribution by Category
### Category Revenue Share
```
- Household	        31.78%
- Grocery	        24.08%
- Health & Beauty	23.13%
- Bakery	        21.01%
```
### Insight:
- Revenue is well balanced across categories, reducing dependency on a single segment. Household and Grocery represent the strongest revenue contributors.

# 🏆 Product Performance Analysis
### 🔝 Top Revenue-Generating Products

- Revenue is distributed across multiple products

- No single “hero product” dominates sales

- Strong performance is driven by consistent demand across SKUs

### 💸 High-Volume, Low-Revenue Products (Pricing Risk)

- Several products sell 2,400–2,600+ units but generate disproportionately low revenue due to very low net prices (£1–£1.50 per unit).

### Insight:
These products show strong demand but weak monetisation, indicating:

- Potential over-discounting

- Underpricing

- Loss-leader pricing strategies

- This represents a clear opportunity for pricing optimisation.

# 🏬 Store Performance Analysis
### 🔝 Top Performing Stores

- Top 10 stores generate very similar revenue levels

- Indicates strong operational consistency across Tesbury locations

### 🔻 Bottom Performing Stores

- Revenue gap between bottom stores is relatively small

- No evidence of severe structural underperformance

### Insight:
- Store-level underperformance is likely local or operational, not systemic, and can be improved through targeted actions.

# 🏙️ City Performance Analysis
### 🚩 Underperforming Cities

### London

- Lowest revenue and transaction volume

- Highest Average Transaction Value (ATV)

### Manchester

- Lower transaction count with healthy ATV

### Insight:
- City underperformance is volume-driven rather than pricing-driven, suggesting demand generation and store reach as primary levers.

# 📈 Time-Based Revenue Trends
### 📅 Monthly Revenue Trend

- Monthly revenue remains stable (£183k–£206k)

- Clear seasonality observed:

- February dip

- Mid-year uplift (May–August)

### 📉 Month-over-Month (MoM) Growth

- Normal retail volatility ( −8% to +10%)

- Seasonal declines followed by recoveries

- No sustained upward or downward trend

### 📊 Year-over-Year (YoY) Growth

- YoY growth mostly ranges between **−3%** and **+3%**

- Indicates a mature and stable retail business

### 📆 Yearly Revenue Trend

|Year|Revenue|
|----|-------|
|2023| £2.36M|
|2024| £2.36M|

### Insight:
- Yearly revenue increased by only **0.24%**, confirming flat growth and market maturity.

# 🎯 Promotion Effectiveness Analysis

All transactions in the dataset are marked as Promotion.

### Conclusion:
- A direct promotion vs non-promotion comparison cannot be performed due to the absence of a control group.

### Insight:
- This highlights a data limitation, not a business conclusion. Proper promotional uplift analysis requires non-promotional sales data.

# 💡 Key Business Recommendations

- Optimise Pricing for High-Volume Products
Small unit price increases could materially improve revenue without significantly impacting demand.

- Increase Transaction Volume in Underperforming Cities
Focus on London and Manchester through targeted marketing and improved store coverage.

- Replicate Best Practices from Top Stores
Use high-performing Tesbury stores as operational benchmarks.

- Increase ATV via Bundling & Cross-Selling
Particularly during seasonal low-demand periods.

- Improve Promotion Measurement Framework
Introduce non-promotional control periods to measure true promotional uplift.

# 🛠️ Tools & Skills Demonstrated
### 🗄️ Databases & Query Languages

### SQL

- Advanced aggregations, joins, CTEs

- Window functions (MoM, YoY analysis)

- Time-series and KPI calculations

- PostgreSQL

- Relational schema design

- Date functions and performance-oriented querying

- Analytical queries on large transactional datasets

### 💻 Development & Version Control

### Visual Studio Code (VS Code)

- SQL development and query execution

- Project-based workflow and file organisation

### Git

- Version control for queries, schema, and documentation

- Incremental commits and change tracking

### GitHub

- Project publishing and portfolio presentation

- Repository structure, README documentation, and insight sharing

### 📊 Analytics & Business Skills

- Retail Performance Analysis

- KPI design (Revenue, Units, Transactions, ATV)

- Product, store, and city benchmarking

- Pricing & Promotion Analysis

- High-volume vs low-revenue product detection

- Promotion effectiveness assessment and data limitation handling

- Time-Series Analysis

- Monthly trends

- Month-over-Month (MoM) growth

- Year-over-Year (YoY) growth

### 🧠 Data Storytelling

- Translating SQL outputs into business insights

- Structuring analysis for executive and recruiter audiences

- Identifying data limitations and communicating them clearly

# 📁 Project Structure

- This project follows a numbered, stage-based structure to clearly reflect the end-to-end data analytics workflow — from raw data to final business insights.

- uk-tesbury-retail-sales-analysis/
```
├── 1_Retail_datasets_csv/ 
│   └── retail_sales.csv
│
├── 2_Schema/
│   └── create_tables.sql
│
├── 3_Cleaning/
│   └── data_cleaning.sql
│
├── 4_Analysis/
│   ├── 1 business_questions.sql
│   ├── 2 kpi_queries.sql
│   ├── 3 advanced_analysis.sql
│
├── 5_Insights/
│   └── findings.md
│
├── README.md
```