import psycopg2
conn = psycopg2.connect(
    host="localhost",
    database="assessment_db",
    user="postgres",
    password="Sqlkone")

def get_data(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM view_contacts;")
    rows = cur.fetchall()
    cur.close()
    return rows


