import sys
import sqlite3 as sql

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
        lineNo = 19
        for line in file:
            
            if "Dato" in line:
                words = line.split()
                for word in words:
                    if len(word) == 10 and word[4] == "-" and word[7] == "-":
                        date = word
                print(date)
                continue
            
            if "Galleri" in line:
                typen = 'Galleri'    #HVORDAN BLIR DET MED RADNR HER EGT? TRODDE VI IKKE GA DISSE SETENE RADNR... I SÅ FALL, HVA GJØR JEG I "UPDATE"-SETNINGEN
                seatNo = 524
                print(typen)
            elif "Parkett" in line:
                typen = 'Parkett'
                seatNo = 504
                print(typen)
            
            else:   
                stringLength = len(line)
                slicedLine = line[stringLength::-1].strip()
                print(line)
                if stringLength < 7:
                    lineNo = 19
                else:
                    lineNo = lineNo - 1
                print(seatNo, lineNo)

                for seat in slicedLine:
                    if seat == '1': #HER MÅ JEG FORTSATT HA RIKTIG FORESTILLING SOM DENNE BILLETTEN HØRER TIL
                        cursor.execute('''
                            INSERT INTO Billett (StolID, Salgsstatus, TeaterstykkeID, ForestillingID)
                            VALUES ((SELECT StolID 
                                       FROM Stol
                                       WHERE Stol.StolNR = :seatNo AND Stol.RadNR = :lineNo AND Stol.Typen = :plassering),
                                       1, 2, (SELECT ForestillingID 
                                                FROM Forestilling JOIN Teaterstykke ON Forestilling.TeaterstykkeID = Teaterstykke.TeaterstykkeID
                                                WHERE Forestilling.Dato = :dato AND Teaterstykke.TeaterstykkeID = 1));
                                       ''', {'seatNo': seatNo,  "lineNo": lineNo, "plassering": typen, 'dato': date })
                        print(f"Sete {seatNo} {lineNo} satt inn")
                    elif seat == '0':
                        cursor.execute('''
                            INSERT INTO Billett (StolID, Salgsstatus, TeaterstykkeID, ForestillingID)
                            VALUES ((SELECT StolID 
                                       FROM Stol 
                                       WHERE Stol.StolNR = :seatNo AND Stol.RadNR = :lineNo AND Stol.Typen = :plassering),
                                       0, 2, (SELECT ForestillingID 
                                                FROM Forestilling JOIN Teaterstykke ON Forestilling.TeaterstykkeID = Teaterstykke.TeaterstykkeID
                                                WHERE Forestilling.Dato = :dato AND Teaterstykke.TeaterstykkeID = 1));
                                       ''', {'seatNo': seatNo,  "lineNo": lineNo, "plassering": typen, 'dato': date })
                        print(f"Sete {seatNo} {lineNo} satt inn")                        

                    seatNo = seatNo-1
                # if type == "Parkett":
                #     lineNo -= 1
                #     seatNo -= 55
                # if type == "balkong":
                #     seatNo -= 9

# Error handling
except FileNotFoundError:
    print(f"The file {filePath} was not found.")
except Exception as e:
    print(f"An error occured: {e}")

con.commit()
con.close()