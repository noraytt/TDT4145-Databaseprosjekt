'''Du skal lage et Pythonprogram (og SQL) som 
tar et skuespillernavn og 
finner hvilke skuespilllere de har spilt med i samme akt. 
Skriv ut navn på begge og hvilket skuespill det skjedde'''

import sqlite3 as sql
from datetime import datetime as dt
import sys

con = sql.connect('teaterdb.sql')
cursor = con.cursor()

if len(sys.argv) < 3:
    print("Format: python3 usecase4.py Name (MiddleName) Surname")
    sys.exit(1)

if (sys.argv[1][0].islower() or sys.argv[2][0].islower()):
    print("First letter in first name and surname has to be upper case.")
    sys.exit(1)


name = ""
for i in (len(sys.argv) - 1):
    name = name + sys.argv[i+1] + ' '

name = name[:-1]


cursor.execute("""
    SELECT DISTINCT an1.navn AS Skuespiller, 
               an2.navn AS Medskuespiller, 
               Teaterstykke.Navn AS Teaterstykke
    FROM AktRolle ar1 JOIN AktRolle ar2
              ON ar1.TeaterstykkeID = ar2.TeaterstykkeID
              AND ar1.AktNR = ar2.AktNR
              AND ar1.RolleID != ar2.RolleID
        
        JOIN Skuespillere sp1 ON sp1.RolleID = ar1.RolleID
        JOIN Ansatt an1 on an1.Identifikator = sp1.SkuespillerID
        
        JOIN Skuespillere sp2 ON sp2.RolleID = ar2.RolleID
        JOIN Ansatt an2 on an2.Identifikator = sp2.SkuespillerID
        
        JOIN Teaterstykke on (Teaterstykke.TeaterstykkeID = ar1.TeaterstykkeID AND Teaterstykke.TeaterstykkeID = ar2.TeaterstykkeID)
        
        WHERE an1.navn = :navn
     """, {'navn' : name})

coactors = cursor.fetchall()

print(f"Skuespiller {name} har spilt i {coactors[0][2]} med:")
for coactor in coactors:
    print(coactor[1])

con.close()