-- לא תמיד נרצה להסתכל על מספרים יבשים כמו כמה בשקלים קטגוריה מכניסה
-- בשאילתא הזו אנחנו מקבלים את המשקל היחסי שלה מתוך כלל מחזור המכירות של אמזון

WITH category_amount_total AS (
    SELECT Category, SUM(Amount) AS category_revenue
    FROM sales_data
    GROUP BY Category
)

SELECT
    Category,ROUND((category_revenue * 100.0 / SUM(category_revenue) OVER ()), 2) AS revenue_share_pct
FROM category_amount_total
ORDER BY category_revenue DESC;