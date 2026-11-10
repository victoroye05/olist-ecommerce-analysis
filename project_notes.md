# Olist E-commerce Analysis: Project Notes

Working log for the SQL, Excel and Power BI project. Source data: Olist Brazilian E-commerce dataset (Kaggle), about 100k orders from 2016 to 2018.

## 1. Setup

- Database: MySQL (Workbench), database name `olist_project`
- Loaded 8 of the 9 CSVs (geolocation skipped, not needed)
- Tables: customers, orders, order_items, order_payments, order_reviews, products, sellers, category_translation

## 2. Import issues and fixes

| Problem | Cause | Fix |
|---|---|---|
| Import wizard stuck at 0% | A cancelled earlier import left the session hanging | I had to Close Workbench, reconnected, then re-imported one file at a time |
| `LOAD DATA INFILE` error 1290 | MySQL only reads from its `secure_file_priv` folder (Uploads) | Switched to the Table Data Import Wizard |
| Error 1366 on `products` | Blank cells in number columns cannot go into INT columns | Created every column as text (VARCHAR), converted later in SQL |
| All tables suddenly empty | Re-running the setup script (which starts with DROP DATABASE) wiped the data | Used a fresh empty query tab for every new query |
| `order_reviews` loaded only 279 rows | Line breaks inside review comments were read as new rows | Removed the two comment columns in Excel, saved as clean CSV, re-imported |

Lesson: import raw data as text first, then clean it into new tables so the raw tables stay untouched.

## 3. Data cleaning decisions

- Created `orders_clean`: text dates converted to real dates with `STR_TO_DATE`, blanks turned into NULL.
- Created `order_items_clean`: price and freight converted to DECIMAL.
- Created `products_clean`: English category names joined from `category_translation`, with fallback to the Portuguese name, then 'unknown'.
- Created `reviews_clean`: one review score per order (some orders have several reviews).
- Revenue analysis uses only orders with status `delivered`.

## 4. Quality checks

- Row counts compared with the expected numbers after every import.
- Order statuses checked: the large majority are `delivered`.
- Duplicate orders checked: total rows vs distinct order_id.
- Missing delivery dates checked: blanks are expected for canceled or unshipped orders.
- Excel total revenue was compared with the SQL total: the two matched.

## 5. Results

### Monthly revenue (delivered orders)
- Data runs from Sep 2016 to Aug 2018.
- Revenue rose from about 40k (Oct 2016) to about 988k (Nov 2017, 7,289 orders), the Black Friday peak.
- 2018 stayed between roughly 826k and 978k per month, so growth plateaued.

### Categories
| Category | Orders | Revenue | Avg revenue per order |
|---|---|---|---|
| health_beauty | 8,647 | 1,233,132 | 142.61 |
| watches_gifts | 5,495 | 1,166,177 | 212.23 |
| bed_bath_table | 9,272 | 1,023,435 | 110.38 |
| sports_leisure | 7,530 | 954,853 | 126.81 |
| computers_accessories | 6,530 | 888,725 | 136.10 |

- health_beauty leads on revenue.
- bed_bath_table has the most orders but a low value per order.
- watches_gifts has the highest value per order.

### Delivery
- Delivered orders analyzed: 96,470
- Average days to deliver: 12.5
- Average days promised: 24.4
- Late orders: 7,826 (8.1%)

### Delivery vs reviews
| Delivery status | Orders | Avg review score |
|---|---|---|
| On time | 88,163 | 4.29 |
| Late | 7,661 | 2.57 |

- Late orders score about 1.7 stars lower.
- 7,661 is lower than 7,826 because some late orders have no review.

### Revenue by state
| State | Orders | Revenue | % of revenue |
|---|---|---|---|
| SP | 40,501 | 5,067,633 | 38.3% |
| RJ | 12,350 | 1,759,651 | 13.3% |
| MG | 11,354 | 1,552,482 | 11.7% |
| RS | 5,345 | 728,897 | 5.5% |
| PR | 4,923 | 666,064 | 5.0% |

- São Paulo alone is 38.3% of revenue; the top 3 states are about 63%.

### Repeat customers
- Total customers: 93,358
- Repeat customers: 2,801 (3.0%)
- Counted by `customer_unique_id`, because `customer_id` changes with every order in this dataset.

## 6. Excel work

- Monthly revenue line chart.
- Sheets holding every SQL result (Monthly, Categories, Delivery, LateVsReview, States, Repeat).
- Pivot table and chart of revenue by state.
- Validation: SUM of monthly revenue in Excel matched the SQL total.
- Note: the Excel "Line" button under Sparklines is not the chart button and causes a "reference for location invalid" error. Use Insert, then Recommended Charts.

## 7. Power BI work

- Built from the exported CSVs (not linked to MySQL).
- Page "Overview": 4 KPI cards (avg days to deliver, late %, repeat %, delivered orders), monthly revenue line chart, revenue by state bar chart, review score on time vs late.
- Page "Categories": revenue by category and average revenue per order by category.
- Fix: the line chart first grouped months into years (date hierarchy); changed the axis to use `order_month` directly.

## 8. Limitations

- Category totals count an order once per category it contains, so they do not add up to total revenue.
- Review comparison covers fewer late orders than the delivery summary (orders without reviews drop out).
- Dashboard visuals are separate CSV tables with no relationships, so there are no cross-filtering slicers.
- Data ends in August 2018.

