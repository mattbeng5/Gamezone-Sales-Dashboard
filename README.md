# Gamezone Sales Dashboard

### Table of Contents
- [Project Overview](#project-overview)
- [Executive Summary](#executive-summary)
- [Objectives](#objectives)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [PostgreSQL Analysis](#postgresql-analysis)
- [Power BI Dashboard](#power-bi-dashboard)

### Project Overview
Gamezone is a digital retailer for new and refurbished video game products. This project analyzes customer purchases to uncover revenue patterns, order behavior, and product category performance. The result is a fully interactive dashboard that surfaces insights across time, geography, and value metrics.

### Executive Summary
#### Gamezone Sales Dashboard 3-Year Performance Overview
This dashboard analyzes over 21,000 customer transactions from GameZone, an e-commerce retailer specializing in new and refurbished video game products. Over a three-year period, total revenue exceeded $6.15M, driven by flagship products such as the 27in 4K gaming monitor, which alone generated nearly $2M.

Interactive visuals uncover patterns across product lines, geographic regions, and purchase timing. Direct marketing channels proved highly effective, and consistent seasonality trends—with December as the top-performing month—highlighted opportunities for targeted campaigns. The EMEA and North America (NA) regions contributed the bulk of sales volume.

With additional layers of analysis, including product performance rankings, year-over-year comparisons, and regional heatmaps, this dashboard equips stakeholders with actionable insights. It serves as a strategic tool for both marketing and finance teams to uncover growth opportunities and optimize campaign strategies.


### Objectives
- Visualize total revenue, order count, and average order value (AOV) over time
- Analyze geographic sales distribution using map-based visuals
- Deliver actionable insights to marketing and finance teams through interactive dashboards

### Tools
- Microsoft Excel: data cleaning and inital exploratory data analysis.
- PostgreSQL: stratification by region, product, marketing channel, account creation metod, and over time. 
- Power BI: create interactive sales dashboard visualizing KPIs
  
### Data Cleaning
This project involved a relatively clean e-commerce dataset consisting of 21,854 records. A detailed review of the Orders and Region tables surfaced 12 data quality issues, most of which were low in magnitude. Only one inconsistency impacted more than 1% of records (specifically, 9.17%). These anomalies were addressed methodically to uphold data integrity.
Following the cleaning process, five new columns were computed and added to the Orders table: purchase_ts_clean, product_name_clean, marketing_channel_clean, account_creation_method_clean, and region. The region column was derived by cross-referencing the country_code column in the Orders table with the region column in the Region table. Consolidating the dataset allows for streamlined import into PostgreSQL, with only the Orders table required for deeper analysis.
   

- Orders Table
  - purchase_ts:
    - 10 rows had inconsistent date formats, these were standardized in Excel
    - 1 row has a missing date, this was left blank as we were unable to verify the date and of the low magnitude
    - clean column: purchase_ts_clean
  - purchase_ts_clean, ship_ts
    -2005 rows have the shipment timestamp at an earlier date than the purchase timestamp, I was unable to verify the correct date and these were left as is  
  - product_name:
    - 61 rows had inconsistent spelling between "27inches 4K gaming monitor" and "27in gaming monitor", standardized to "27in gaming monitor"
    - clean column: product_name_clean
  - usd_price:
    - 34 rows had missing or $0 transactions, we were unable to verify the value of these transactions and left them as is
  - marketing_channel
    - 83 rows were missing their marketing channel, replaced with the existing response "unknown"
    - clean column: marketing_channel_clean
  - account_creation_method
    - 83 rows were missing their account creation method, replaced with the existing response "unknown"
    - clean column: account_creation_method_clean
  - country_code
    - 37 rows were missing their country code, we were unable to verify the country and left these as is
  - order_id
    - 145 rows had duplicate order ids, there were left as is due to low magnitude(0.66%)  
- Region Table
  - region
    - 2 rows were missing their region, I was able to impute the correct region using the country code
    - 5 rows had inconsistent spellings, listing "North America" instead of "NA", these were standardized to "NA"
    - 2 rows had X.x listed as their region, I was able to impute the correct region using the country code

### PostgreSQL Analysis
After cleaning and structuring the orders dataset, I imported the data into PostgreSQL to analyze more thoroughly. My goal for this analysis was to uncover revenue patterns, product performance, seasonal trends and customer acquisition behavior. All query results were exported to [query_results](query_results.txt) queries are documented in [orders_queries](orders_queries.sql) for full transparency and reproducibility.

### Key Analysis Highlights
- KPIs
  - Total Orders: 21,864
  - Total Revenue: $6,151,266.49
  - Average Order Value: $281.41
- Monthly Sales Trends
  - Averaged monthly sales revenue to explore seasonality
  - Highest: December ($365,102.23)
  - Lowest: January ($166,575.09)
- Product Revenue Rankings
  - Top Product: 27in 4K gaming monitor ($1,968,565.34)
  - Bottom Product: Razer Pro Gaming Headset ($884.23)
- Revenue by Marketing Channel
  - Best method: direct marketing ($5,209,858.66)
  - Least effective method: social media($69,526.37)
 
### Power BI Dashboard

Power BI was utilized to create [orders_dashboard](https://github.com/mattbeng5/Gamezone-Sales-Dashboard/blob/main/orders_dashboard.pbix) to visualize sales performance by product, region, and over time. Please feel free to interact with this dashboard in Power BI Desktop, screenshots are below. 

![Overview Screenshot](https://github.com/mattbeng5/Gamezone-Sales-Dashboard/blob/main/Overview.png)
![Product Sales Screenshot](https://github.com/mattbeng5/Gamezone-Sales-Dashboard/blob/main/Product%20Sales.png)
![Regional Sales Screenshot](https://github.com/mattbeng5/Gamezone-Sales-Dashboard/blob/main/Regional%20Sales.png)
![Sales over Time](https://github.com/mattbeng5/Gamezone-Sales-Dashboard/blob/main/Performance%20with%20Time.png)





#### Next Steps

**Marketing Team**
  - Expand bundles in Q4 to take advantage of high sales volume
    - combine high and low revenue products(e.g. 27in 4k gaming monitor and Dell Gaming Mouse)
  - Launch targeted promotions in each region's top performing marketing channel

**Sales Strategy**
  - Reinvest in high-performing channels
    - Direct in NA, Social Media in EMEA 
  - Align sales outreach with marketing promotions

**Operations Strategy**
  - Prioritize logistics in APAC and LATAM regions to capture more market share
  - Increase data quality
    - largest data issue was shipment timestamp listed as before purchase time stamp
   
**Analytics Strategy**
  - Update dashboard with quarterly sales reports
  - Begin predictive modeling for 2026       
