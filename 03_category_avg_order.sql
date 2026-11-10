USE olist_project;

SELECT
    pc.category,
    COUNT(DISTINCT i.order_id) AS total_orders,
    ROUND(SUM(i.price), 2) AS revenue,
    ROUND(SUM(i.price) / COUNT(DISTINCT i.order_id), 2) AS avg_revenue_per_order
FROM order_items_clean i
JOIN orders_clean o ON i.order_id = o.order_id
JOIN products_clean pc ON i.product_id = pc.product_id
WHERE o.order_status = 'delivered'
GROUP BY pc.category
ORDER BY revenue DESC
LIMIT 10;