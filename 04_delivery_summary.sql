USE olist_project;

SELECT
    COUNT(*) AS delivered_orders,
    ROUND(AVG(DATEDIFF(delivered_date, purchase_date)), 1) AS avg_days_to_deliver,
    ROUND(AVG(DATEDIFF(estimated_date, purchase_date)), 1) AS avg_days_promised,
    SUM(CASE WHEN delivered_date > estimated_date THEN 1 ELSE 0 END) AS late_orders,
    ROUND(100 * SUM(CASE WHEN delivered_date > estimated_date THEN 1 ELSE 0 END) / COUNT(*), 1) AS late_pct
FROM orders_clean
WHERE order_status = 'delivered'
  AND delivered_date IS NOT NULL;