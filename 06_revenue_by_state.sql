USE olist_project;

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(i.price), 2) AS revenue,
    ROUND(100 * SUM(i.price) / SUM(SUM(i.price)) OVER (), 1) AS pct_of_revenue
FROM orders_clean o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items_clean i ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;