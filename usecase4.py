import sqlite3 as sql
from datetime import datetime as dt
import sys

con = sql.connect('teaterdb.sql')
cursor = con.cursor()

# Checking if the user has specified the date to be scanned as a command-line argument.
if len(sys.argv) < 2:
    print("Format: python3 usecase4.py <YYYY-MM-DD>")
    sys.exit(1)

# Extracting date and checks that date is on sql DATE-format: "YYYY-MM-DD"
try:
    date = dt.strptime(sys.argv[1], '%Y-%m-%d').date()
except ValueError:
    print("Wrong date format. Please ensure you use YYYY-MM-DD")
    sys.exit(1)
except Exception as e:
    print(f"An error occured: {e}")

# Find the shows on the specified date
cursor.execute("""
    SELECT ForestillingsID, TeaterstykkeID, Navn, SalID, Starttid
    FROM Forestilling NATURAL JOIN Teaterstykke
    WHERE Dato = :date
""", {"date": date})

shows = cursor.fetchall()
if shows != []:
    print(f"The following shows are performed on {date}:")

# Find number of sold tickets for each show
for show in shows:
    cursor.execute("""
        SELECT COUNT(*)
        FROM Billett
        WHERE ForestillingsID = :showID TeaterstykkeID = :playID AND Salgsstatus = 1
    """, {"showID": show[0], "playID": show[1]})
    soldTickets = cursor.fetchone()
    cursor.execute("""
        SELECT Navn
        FROM Sal
        WHERE SalID = :salID
    """, {"salID": show[2]})
    auditoriumName = cursor.fetchone()
    print(f"The show {show[2]}, in auditorium {auditoriumName}, performed on {date}, time: {show[4]} has {soldTickets[0]} sold tickets")

con.close()

