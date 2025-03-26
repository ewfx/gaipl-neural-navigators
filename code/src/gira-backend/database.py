import psycopg2
import os

# Define the RDS endpoint and database connection string
rds_endpoint = "gira-db.cbwu4gguwkk0.ap-south-1.rds.amazonaws.com:5432"
DB_URL = f"postgresql://giraadmin:SecurePassword123!@{rds_endpoint}/gira_db"

def save_incident(description, analysis):
    try:
        conn = psycopg2.connect(DB_URL)
        cur = conn.cursor()
        cur.execute("INSERT INTO incidents (description, analysis) VALUES (%s, %s)", (description, analysis))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"Database error: {e}")

