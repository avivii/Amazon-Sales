import sqlite3
import pandas as pd

df = pd.read_csv('Amazon Sale Report.csv')

conn = sqlite3.connect('amazon_sales.db')
df.to_sql('sales_data', conn, if_exists='replace', index=False)
conn.close()

print("מסד הנתונים נוצר והנתונים נטענו בהצלחה!")