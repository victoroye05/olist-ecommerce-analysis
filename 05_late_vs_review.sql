USE olist_project;

SELECT
    CASE WHEN o.delivered_date > o.estimated_date THEN 'Late' ELSE 'On time' END AS delivery_status,
    COUNT(*) AS orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders_clean o
JOIN reviews_clean r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.delivered_date IS NOT NULL
GROUP BY delivery_status;