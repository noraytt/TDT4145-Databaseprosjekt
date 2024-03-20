import sys
import sqlite3 as sql
from datetime import datetime as dt

con = sql.connect('teater.sqlite')
cursor = con.cursor()

# Checking if the user has specified the textfile to be scanned as a command-line argument
if len(sys.argv) < 2:
    print("Format: python3 scan-seats-hovedscenen.py <path_to_file>")
    sys.exit(1)

# Extracting file path to the textfile
filePath = sys.argv[1]

# Open textfile in read-mode and scan the contents of the file, one line at a time 
try:
    with open(filePath, 'r') as file:
        type = None
        now = dt.now()
        dateString = now.strftime("%Y-%m-%d")
        timeString = now.strftime("%H:%M:%S")
        lineNo = 19
        for line in file:
            
            if "Dato" in line:
                words = line.split()
                for word in words:
                    if len(word) == 10 and word[4] == "-" and word[7] == "-":
                        date = word
                continue
            
            if "Galleri" in line:
                typen = 'Galleri' 
                seatNo = 524
            elif "Parkett" in line:
                typen = 'Parkett'
                seatNo = 504
            
            else:   
                stringLength = len(line)
                slicedLine = line[stringLength::-1].strip()
                if stringLength < 7:
                    lineNo = 19
                else:
                    lineNo = lineNo - 1

                for seat in slicedLine:
                    if seat == '1': 
                        cursor.execute('''
                            UPDATE Billett           
                            SET Salgsstatus = 1
                            WHERE StolId = (SELECT StolID FROM Stol where Stol.StolNR = :seatNo AND Stol.RadNR = :lineNo AND Stol.Typen = :plassering)
                                   AND Billett.ForestillingID =  (SELECT ForestillingID FROM Forestilling WHERE Forestilling.Dato = :dato)
                                   AND Billett.TeaterstykkeID = 1   
                                       
                            ''', {'seatNo': seatNo,  "lineNo": lineNo, "plassering": typen, 'dato': date })

                        cursor.execute('''
                            INSERT INTO Billettkjoep (BillettID, KundeID, Dato, Tidspunkt)
                            SELECT BillettID, 1, :date, :time 
                            FROM Billett WHERE Billett.StolId = (SELECT StolID FROM Stol where Stol.StolNR = :seatNo AND Stol.RadNR = :lineNo AND Stol.Typen = :plassering)
                                    AND Billett.ForestillingID =  (SELECT ForestillingID FROM Forestilling WHERE Forestilling.Dato = :dato)
                                    AND Billett.TeaterstykkeID = 1                               
                            ;
                            ''', {'seatNo': seatNo,  "lineNo": lineNo, "plassering": typen, 'dato':date, 'date': (dateString), 'time': (timeString) })
                        
             

                    seatNo = seatNo-1
        print('All purchases were successfylly added')


# Error handling
except FileNotFoundError:
    print(f"The file {filePath} was not found.")
except Exception as e:
    print(f"An error occured: {e}")

con.commit()
con.close()