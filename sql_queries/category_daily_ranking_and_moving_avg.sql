-- חשבתי על שאלות תפעוליות עמוקות יותר, ואז חשבתי, איך אני יכולה לדעת אם המגמה שקיבלתי היא אמיתית? או שקרה משהו חריג בימים האלה?
-- השאילתא הזו מדגימה את הפתרון היא מציגה איזו קטגוריית מוצרים מובילה בכל יום מחדש
-- ומנטרלת את רעשי הרקע באמצעות חישוב ממוצע נע כדי לקבל מגמות אמינות

WITH DailyCategoryRevenue AS (
    SELECT 
        Date,
        Category,
        SUM(Amount) AS daily_revenue,
        COUNT(DISTINCT "Order ID") AS total_orders
    FROM sales_data
    WHERE Status != 'Cancelled'
    GROUP BY Date, Category
),
MovingAvg AS (
    SELECT 
        Date,
        Category,
        daily_revenue,
        AVG(daily_revenue) OVER (
            PARTITION BY Category 
            ORDER BY Date 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS moving_avg_7d
    FROM DailyCategoryRevenue
)
-- עכשיו מדרגים לפי הממוצע הנע ולא לפי ההכנסה היומית!
SELECT 
    Date,
    Category,
    daily_revenue,
    ROUND(moving_avg_7d, 2) AS moving_avg_7d,
    RANK() OVER (PARTITION BY Date ORDER BY moving_avg_7d DESC) AS revenue_rank
FROM MovingAvg
ORDER BY Date DESC, revenue_rank ASC;