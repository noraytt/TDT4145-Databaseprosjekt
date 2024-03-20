SELECT DISTINCT Ansatt.Navn AS Navn, Rolle.Navn AS RolleNavn, Teaterstykke.Navn AS Teater
    FROM ((Skuespillere INNER JOIN Rolle ON Skuespillere.RolleID = Rolle.RolleID) INNER JOIN Ansatt ON Ansatt.Identifikator = Skuespillere.SkuespillerID)
			    INNER JOIN AktRolle ON Rolle.RolleID = AktRolle.RolleID
			    INNER JOIN Teaterstykke ON AktRolle.TeaterstykkeID = Teaterstykke.TeaterstykkeID  