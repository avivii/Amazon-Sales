import os
import sqlite3
import pandas as pd

DB_PATH = "amazon_sales.db"
QUERIES_DIR = "sql_queries"
OUTPUT_DIR = "tableau_outputs"

os.makedirs(OUTPUT_DIR, exist_ok=True)

conn = sqlite3.connect(DB_PATH)

for filename in os.listdir(QUERIES_DIR):
    if filename.endswith(".sql"):
        query_path = os.path.join(QUERIES_DIR, filename)

        with open(query_path, "r", encoding="utf-8") as f:
            query_sql = f.read()

        try:
            df = pd.read_sql(query_sql, conn)

            base_name = os.path.splitext(filename)[0]
            output_csv = os.path.join(OUTPUT_DIR, f"{base_name}.csv")

            df.to_csv(output_csv, index=False)
            print(f"[V] שאילתה {filename} הורצה בהצלחה ונשמרה כ-CSV!")

        except Exception as e:
            print(f"[X] שגיאה בהרצת השאילתה {filename}: {e}")

conn.close()
print("\n כל התהליך הסתיים! כל קבצי ה-CSV מוכנים לשימוש בטאבלו וב-GitHub.")
