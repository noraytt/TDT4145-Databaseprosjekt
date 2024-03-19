/*Vi ønsker å lage et query i SQL som finner 
hvilke forestillinger som har solgt best. 
Skriv ut navn på forestilling og dato og antall solgte plasser 
sortert på antall plasser i synkende rekkefølge.*/

SELECT COUNT BillettID AS AntallSolgt, Forestilling.Dato, Teaterstykke.Navn
FROM (Billett INNER JOIN Forestilling ON Billett.ForestillingID = Forestilling.ForestillingID) INNER JOIN Teaterstykke ON Teaterstykke.TeaterstykkeID = Billett.TeaterstykkeID
WHERE Billett.Salgsstatus = 1 AND AntallSolgt > 0
GROUP BY TeaterstykkeID, ForestillingID
ORDER BY AntallSolgt DESC
