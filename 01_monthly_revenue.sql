USE olist_project;

SELECT
    DATE_FORMAT(o.purchase_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price), 2) AS revenue
FROM orders_clean o
JOIN order_items_clean i ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.purchase_date, '%Y-%m')
ORDER BY order_month;