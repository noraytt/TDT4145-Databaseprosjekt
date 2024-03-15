import sqlite3 as sql
from datetime import datetime as dt

con = sql.connect('teaterdb.sql')
cursor = con.cursor()

# This function buys 9 adult tickets to the show: "Størst av alt er kjærligheten", on february 3rd 2024
def buyAdultTickets():

    # Find all available seats for the show
    cursor.execute("""
        SELECT Stol.StolId, Stol.RadNR, Stol.Typen
        FROM Stol LEFT JOIN Billett 
                  ON Stol.StolId = Billett.StolId AND Billett.TeaterstykkeID = 2 AND Billett.ForestillingsId = 1 AND Billett.Salgsstatus = 0
    """)

    availableSeats = cursor.fetchall()  
    
    # Sort the available seats by type, and find the first 9 seats in the same row
    seatsByRowGalleri = {}
    seatsByRowBalkong = {}
    seatsByRowParkett = {}

    for stolId, radNr, typen in availableSeats:
        if typen == "Galleri":
            if radNr not in seatsByRowGalleri:
                seatsByRowGalleri[radNr] = []
            seatsByRowGalleri[radNr].append(stolId)
        elif typen == "Balkong":
            if radNr not in seatsByRowBalkong:
                seatsByRowBalkong[radNr] = []
            seatsByRowBalkong[radNr].append(stolId)
        elif typen == "Parkett":
            if radNr not in seatsByRowParkett:
                seatsByRowParkett[radNr] = []
            seatsByRowParkett[radNr].append(stolId)

    nineSeatsGalleri = findNineSeatsInARow(seatsByRowGalleri)
    nineSeatsBalkong = findNineSeatsInARow(seatsByRowBalkong)
    nineSeatsParkett = findNineSeatsInARow(seatsByRowParkett)
    if nineSeatsGalleri:
        purchaseTickets(nineSeatsGalleri)
        calculateTotalPrice()
    elif nineSeatsBalkong:
        purchaseTickets(nineSeatsBalkong)
        calculateTotalPrice()
    elif nineSeatsParkett:
        purchaseTickets(nineSeatsParkett)
        calculateTotalPrice()
    else:
        print("No 9 seats in a row available")


# Helper function to calculate the total price of the tickets
def calculateTotalPrice():
    cursor.execute("""
        SELECT OrdinaerP
        FROM Billettpris 
        WHERE Billettpris.TeaterstykkeID = 2
    """)
    price = cursor.fetchone()
    totalPrice = price * 9
    print(f"Totalprice for the 9 tickets is: {totalPrice}")


# Helper function to update the database with the purchased tickets
def purchaseTickets(chosenSeats):
    now = dt.now()
    dateString = now.strftime("%Y-%m-%d")
    timeString = now.strftime("%H:%M:%S")

    for seatId in chosenSeats:
        cursor.execute("""
            UPDATE Billett 
            SET Salgsstatus = 1 
            WHERE (Billett.StolID = :seatId AND Billett.TeaterstykkeID = 2 AND Billett.ForestillingsID = 1)
        """, {"seatId": seatId})
        cursor.execute("""
            INSERT INTO Billettkjoep (BillettID, KundeID, Dato, Tidspunkt)
            VALUES ((SELECT BillettID
                    FROM Billett
                    WHERE (Billett.StolID = :seatId AND Billett.Teaterstykke = 2 AND Billett.ForestillingsID = 1)), KUNDEID, :dateString, :timeString)
            """, {"seatId": seatId, "dateString": dateString, "timeString": timeString})
    con.commit()
    print("Purchase successful")

# Helper function to find 9 seats in a row
def findNineSeatsInARow(seatsByRow):
    for row in seatsByRow:
        if len(seatsByRow[row]) >= 9:
            return seatsByRow[row][:9]
    return None

con.close()