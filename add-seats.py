import sqlite3 as sql

con = sql.connect('teaterdb.sql')
cursor = con.cursor()

# Inserting chairs for "Hovedscenen"
for i in range (505,525):
    cursor.execute(
        '''INSERT INTO Stol (StolNR, RadNR, Typen, SalID)
        VALUES (:nr, 19, 'Gallery', 1);''', {'nr':i})
for i in range (1, 505):
    lineNo = i //24 + 1
    if i < 467 or (i > 470 and i<495) or i>498:
        cursor.execute(
            '''INSERT INTO Stol(StolNR, RadNR, Typen, SalID)
            VALUES (:nr, :rad, 'Parkett', 1)''', {'nr':i,'rad':lineNo })


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
            cursor.execute(query, (i, 2, type, 2))
        elif i < 52:
            cursor.execute(query, (i, 3, type, 2))
        elif i < 70:
            cursor.execute(query, (i, 4, type, 2))      
        elif i < 88:
            cursor.execute(query, (i, 5, type, 2))
        elif i < 105:
            cursor.execute(query, (i, 6, type, 2))
        elif i < 123:
            cursor.execute(query, (i, 7, type, 2))
        elif i < 140:
            cursor.execute(query, (i, 8, type, 2))
        elif i < 157:
            cursor.execute(query, (i, 9, type, 2))
        elif i < 171:
            cursor.execute(query, (i, 10, type, 2))
    elif i < 265:
        type = 'Balkong'
        if i < 199:
            cursor.execute(query, (i, 1, type, 2))
        if i < 225:
            cursor.execute(query, (i, 2, type, 2))
        if i < 248:
            cursor.execute(query, (i, 3, type, 2))
        if i < 265:
            cursor.execute(query, (i, 4, type, 2))
    else: 
        type = 'Galleri'
        if i < 298:
            cursor.execute(query, (i, 1, type, 2))        
        if i < 316:
            cursor.execute(query, (i, 2, type, 2))
        if i < 33:
            cursor.execute(query, (i, 3, type, 2))



con.commit()
con.close()