import sys
import sqlite3 as sql

con = sql.connect('teaterdb.sql')
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
        for line in file:
            seatNo = 1
            
            if "Dato" in line:
                words = line.split()
                for word in words:
                    if len(word) == 10 and word[4] == "-" and word[7] == "-":
                        date = word
            
            if "Galleri" in line:
                type = "Galleri"    
                lineNo = 3
            if "Balkong" in line:
                type = "Balkong"
                lineNo = 4
            if "Parkett" in line:
                type = "Parkett"
                lineNo = 10
            
            else:  
                stringLength = len(line)
                slicedLine = line[stringLength::-1]
                for seat in slicedLine:
                    if seat == 1: #HER MÅ JEG FORTSATT HA RIKTIG FORESTILLING SOM DENNE BILLETTEN HØRER TIL
                        cursor.execute("UPDATE Billett SET Billettstatus = 1 WHERE (Billett.StolID = (SELECT StolID FROM Stol WHERE StolNR = :seatNo AND RadNR = :lineNo AND Typen = :plassering)) AND Billett.ForestillingsID = ()", {"seatNo": seatNo, "lineNo": lineNo, "plassering": type})
                    seatNo += 1
                lineNo -= 1

# Error handling
except FileNotFoundError:
    print(f"The file {filePath} was not found.")
except Exception as e:
    print(f"An error occured: {e}")

con.close()