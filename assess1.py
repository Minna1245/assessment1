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


while True: 
    cmd = input("Command: ").strip().lower()
    if cmd == "list":
        for name1, name2, c, ct, cc in (get_data(conn)):
            print(name1, "\t", name2, "\t", c, "\t", ct, "\t", cc)
    elif cmd == "insert":
        first_name = input("  First Name: ").strip().capitalize()
        last_name = input("  Last name: ").strip().capitalize()
        title = input("  Title: ").strip().capitalize()
        organization = input("  Organization:  ").strip().capitalize()
        add_contact(conn, first_name, last_name, title, organization)
        print(f"{first_name} added!")
    elif cmd == "delete":
        first_name = input("  First_name: ")
        delete_contact(conn, first_name)
        print(f"{first_name} deleted!")
    else:
        print("Unidentified command, please repeat")    