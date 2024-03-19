import sqlite3 as sql
from datetime import datetime as dt
import sys

con = sql.connect('teaterdb.sql')
cursor = con.cursor()

# # Checking if the user has specified the date to be scanned as a command-line argument.
# if len(sys.argv) < 2:
#     print("Format: python3 usecase5.py <YYYY-MM-DD>")
#     sys.exit(1)

cursor.execute("""
    SELECT DISTINCT Ansatt.Navn AS Navn, Rolle.Navn AS RolleNavn, Teaterstykke.Navn AS Teater
    FROM ((Skuespillere INNER JOIN Rolle ON Skuespillere.RolleID = Rolle.RolleID) INNER JOIN Ansatt ON Ansatt.Identifikator = Skuespillere.SkuespillerID)
			    INNER JOIN AktRolle ON Rolle.RolleID = AktRolle.RolleID
			    INNER JOIN Teaterstykke ON AktRolle.TeaterstykkeID = Teaterstykke.TeaterstykkeID              
  """)

actors = cursor.fetchall()


kongsemnene = []
stoerst = []

for i in actors:
  if actors[2] == "Kongsemnene":
    kongsemnene.append([i[0],i[1]])
  else:
    stoerst.append([i[0],i[1]])

print("The following roles and actors are in Kongsemnene:")
for actor in kongsemnene:
  print(actor)

print("The following roles and actors are in Størst av alt er Kjærligheten:")
for actor in stoerst:
  print(actor)


con.close()

