SELECT COUNT(BillettID) AS AntallSolgt, Forestilling.Dato, Teaterstykke.Navn
FROM (Billett INNER JOIN Forestilling ON Billett.ForestillingID = Forestilling.ForestillingID) INNER JOIN Teaterstykke ON Teaterstykke.TeaterstykkeID = Billett.TeaterstykkeID
WHERE Billett.Salgsstatus = 1
GROUP BY Forestilling.TeaterstykkeID, Forestilling.ForestillingID
HAVING COUNT(BillettID) > 0
ORDER BY AntallSolgt DESC;
