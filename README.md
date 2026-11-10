# Olist E-commerce Analysis: SQL, Excel and Power BI

> Late deliveries cut customer review scores by about 1.7 stars across 96k delivered orders.

## Business problem

Olist is a Brazilian online marketplace. This project analyzes about 100,000 orders (2016 to 2018) to answer:

- Where does revenue come from?
- How well does delivery perform?
- Does delivery performance affect customer satisfaction and loyalty?

## Dashboard preview

![Overview](powerbi/dashboard_overview.png)

![Categories](powerbi/dashboard_categories.png)

## Tools

- **MySQL:** data loading, cleaning and analysis (joins, subqueries, window functions, CASE logic)
- **Excel:** validation of SQL totals, a pivot table and a trend chart
- **Power BI:** a two-page dashboard

## Data

Olist Brazilian E-commerce Public Dataset (Kaggle). Raw CSVs are not included in this repository because of their size.

## Data cleaning

- All columns were imported as text, then converted to proper dates and numbers in new `_clean` tables, leaving the raw tables untouched.
- Reviews were reduced to one score per order. The free-text comment columns were removed because line breaks in the CSV corrupted the import.
- Only **delivered** orders were used for revenue analysis, so canceled orders do not inflate results.
- Customers were counted with `customer_unique_id`, because `customer_id` changes with every order in this dataset.
- The Excel total revenue was checked against the SQL total, and the two matched.

## Key insights

1. **Revenue grew fast, then plateaued.** Monthly revenue rose from about 40k (Oct 2016) to nearly 1M (Nov 2017, the Black Friday peak) and stayed around 830k to 980k through 2018. The data ends in August 2018.
2. **Revenue is concentrated geographically.** São Paulo alone generates 38.3% of revenue, and the top three states (SP, RJ, MG) generate about 63%.
3. **Volume and value differ by category.** health_beauty leads revenue (1.23M). bed_bath_table has the most orders (9,272) but a low average order value (110). watches_gifts has the highest average order value (212).
4. **Delivery is usually early.** Average delivery takes 12.5 days against 24.4 promised, and 8.1% of orders arrive late.
5. **Late delivery hurts satisfaction.** On-time orders average 4.29 stars versus 2.57 for late orders, a gap of about 1.7 stars.
6. **Loyalty is very low.** Only 3.0% of customers (2,801 of 93,358) bought more than once.

## Recommendations

- **Fix late deliveries first.** Late orders cost almost 1.7 review stars, so even a small cut in the 8.1% late rate would lift satisfaction. Start by identifying the sellers and states with the most late orders.
- **Build a retention program.** With 97% one-time buyers, follow-up offers, loyalty rewards or post-purchase emails could add revenue without new acquisition spend.
- **Grow outside the southeast.** Most states contribute 5.5% of revenue or less. Test regional marketing, and check whether slow delivery is holding those states back.
- **Protect high-value categories.** watches_gifts earns the most per order, so seller quality and delivery reliability there matter most.

## Limitations

- Category figures count an order once in each category it contains, so category totals do not add up to total revenue.
- The 7,661 late orders in the review comparison are fewer than the 7,826 in the delivery summary, because some late orders have no review.
- The dashboard was built from exported CSVs, so its visuals are not linked to each other or to the database.

## Repository structure

```
sql/        01_monthly_revenue.sql ... 07_repeat_customers.sql
excel/      olist_analysis.xlsx
powerbi/    olist_dashboard.pbix, dashboard screenshots
docs/       project_notes.md
```

