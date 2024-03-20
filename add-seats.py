import sqlite3 as sql

con = sql.connect('teater.sqlite')
cursor = con.cursor()

# Inserting chairs for "Hovedscenen"
for i in range (505,525):
    cursor.execute(
        '''INSERT INTO Stol (StolNR, RadNR, Typen, SalID)
        VALUES (:nr, 19, 'Galleri', 1);
        ''', {'nr':i})
for i in range (1, 505):
    if i % 28 == 0:
        lineNo = i // 28
    else: 
        lineNo = i //28 + 1
    if i < 467 or (i > 470 and i<495) or i>498:
        cursor.execute(
            '''INSERT INTO Stol(StolNR, RadNR, Typen, SalID)
            VALUES (:nr, :rad, 'Parkett', 1)''', {'nr':i,'rad':lineNo })


cursor.execute('''SELECT TeaterstykkeID, ForestillingID FROM Forestilling WHERE Forestilling.TeaterstykkeID = 1''')
forestillinger = cursor.fetchall()
cursor.execute('''SELECT StolID FROM Stol WHERE Stol.StolID < 517''')
stoler = cursor.fetchall()


#Add tickets to Hovedscene
for teaterstykkeID, forestillingID in forestillinger:
    for stol in stoler:
            cursor.execute('''INSERT INTO Billett (StolID, Salgsstatus, TeaterstykkeID,  ForestillingID)
                       VALUES (:s, 0, :teater, :forestilling);
                       ''', {'s':stol[0], 'teater':teaterstykkeID, 'forestilling':forestillingID})


# Inserting chairs for "Gamle Scene"
query = '''
    INSERT INTO Stol (StolNR, RadNR, Typen, SalID)
    VALUES (?, ?, ?, ?)
'''

for i in range(1,333):
    if i < 171:
        type = 'Parkett'
        if i < 19:
            cursor.execute(query, (i, 1, type, 2))
        elif i < 35:
            cursor.execute(query, (i-18, 2, type, 2))
        elif i < 52:
            cursor.execute(query, (i-34, 3, type, 2))
        elif i < 70:
            cursor.execute(query, (i-51, 4, type, 2))      
        elif i < 88:
            cursor.execute(query, (i-69, 5, type, 2))
        elif i < 105:
            cursor.execute(query, (i-87, 6, type, 2))
        elif i < 123:
            cursor.execute(query, (i-104, 7, type, 2))
        elif i < 140:
            cursor.execute(query, (i-122, 8, type, 2))
        elif i < 157:
            cursor.execute(query, (i-139, 9, type, 2))
        elif i < 171:
            cursor.execute(query, (i-156, 10, type, 2))
    elif i < 265:
        type = 'Balkong'
        if i < 199:
            cursor.execute(query, (i-170, 1, type, 2))
        elif i < 226:
            cursor.execute(query, (i-198, 2, type, 2))
        elif i < 248:
            cursor.execute(query, (i-225, 3, type, 2))
        elif i < 265:
            cursor.execute(query, (i-247, 4, type, 2))
    else: 
        type = 'Galleri'
        if i < 298:
            cursor.execute(query, (i-264, 1, type, 2))        
        elif i < 316:
            cursor.execute(query, (i-297, 2, type, 2))
        elif i < 333:
            cursor.execute(query, (i-315, 3, type, 2))

# Add tickets to gamle scene
cursor.execute('''SELECT TeaterstykkeID, ForestillingID FROM Forestilling WHERE Forestilling.TeaterstykkeID = 2''')
forestillinger = cursor.fetchall()
cursor.execute('''SELECT StolID FROM Stol WHERE Stol.StolID > 516''')
stoler = cursor.fetchall()

for teaterstykkeID, forestillingID in forestillinger:
    for stol in stoler:
            cursor.execute('''INSERT INTO Billett (StolID, Salgsstatus, TeaterstykkeID,  ForestillingID)
                       VALUES (:s, 0, :teater, :forestilling);
                       ''', {'s':stol[0], 'teater':teaterstykkeID, 'forestilling':forestillingID})





con.commit()
con.close()