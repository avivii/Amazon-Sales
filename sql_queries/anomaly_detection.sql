-- איתור ימים חריגים בהם היו מכירות שיא
-- זיהוי הימים או המבצעים שהלקוחות הכי אוהבים


SELECT 
    Date,
    SUM(Amount) AS daily_revenue,
    COUNT(DISTINCT "Order ID") AS daily_orders
FROM sales_data
GROUP BY Date
ORDER BY daily_revenue DESC
LIMIT 5;