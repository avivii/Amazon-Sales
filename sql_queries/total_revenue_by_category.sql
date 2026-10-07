-- השוואה ישירה: הצגה מידית של הקטגוריות המובילות והקטגוריות שמוכרות מעט מאוד
-- זיהוי מגמות: ניתן לראות האם ירידת המכירות שהייתה בתאריך מסוים קשורה לירידה במכירות כללית בכל הקטגוריות או שרק קטגוריה אחת ספציפית ירדה 

SELECT 
    Date,
    Category,
    SUM(Amount) AS total_revenue,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales_data
GROUP BY Date, Category
ORDER BY Date ASC, total_revenue DESC;