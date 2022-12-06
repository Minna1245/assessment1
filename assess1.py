import psycopg2
conn = psycopg2.connect(
    host="localhost",
    database="assessment_db",
    user="postgres",
    password="Sqlkone")

def get_data(conn):
    cur = conn.cursor()
    cur.execute("SELECT * FROM contacts;")
    rows = cur.fetchall()
    cur.close()
    return rows


def add_contact(conn, first_name, last_name, title, organization):
    cur = conn.cursor()
    cur.execute(f"INSERT INTO contacts (first_name, last_name, title, organization) VALUES ('{first_name}', '{last_name}', '{title}', '{organization}');")
    cur.close()

def delete_contact(conn, first_name):
    cur = conn.cursor()
    cur.execute(f"DELETE FROM contacts WHERE first_name = '{first_name}';")
    cur.close()



while True: 
    cmd = input("Command: ").strip().lower()
    if cmd == "list":
        for item in (get_data(conn)):
            print(item[1:])
    elif cmd == "insert":
        first_name = input("  First Name: ").strip().capitalize()
        last_name = input("  Last name: ").strip().capitalize()
        title = input("  Title: ").strip().capitalize()
        organization = input("  Organization:  ").strip().capitalize()
        add_contact(conn, first_name, last_name, title, organization)
        print(f"{first_name} added!")
    elif cmd == "delete":
        first_name = input("  First_name: ").strip().capitalize()
        delete_contact(conn, first_name)
        print(f"{first_name} deleted!")
    else:
        print("Unidentified command, please repeat")    