# TDT4145-Databaseprosjekt

Endringer i SQL skjema:

- Fjernet BillettklasseID fra Teaterstykke siden Billettpris refererer til TeaterstykkeID
- Endret måten å kunnngjøre Primary Key
- Mer

## Oppskrift: _hvordan kjøre programmet_

Den tomme databasefilen til prosjektets SQLite-database heter **'teater.sqlite'**.

Databaseappliksjonen har et tekstbasert brukergrensesnitt som kjøres i et terminalvindu. Kommandoene under er skrevet med utgangspunkt i en windows-terminal. Vennligst gjør eventuelle tilpasninger for MacOS- og Linux-baserte terminaler.

### Oppsett og initialisering:

1. I terminalvinduet, etter å ha beveget deg inn i prosjektmappa, skriv følgende for å gå inn i databasefilen:

   **sqlite3 teater.sqlite**

   følgende bør nå dukke opp i terminalvinduet:

   ![output_terminal](images/steg1.png)

2. For å deklarere alle tabellene i databasefilen, skriv følgende:

   **.read teaterdb.sql**

3. For å initialisere databasefilen med oppgitte data, skriv følgende:

   **.read initation.sql**

4. Du skal nå exite ut av databasefilen. Skriv følgende:

   **.exit**

5. For å sette inn seter og billetter, skriv følgende:

   **python3 add-seats.py**

6. For å lese inn og registrere forhåndskjøpte billetter, skriv følgende:

   **python3 scan-seats-gamle-scene.py files-needed\gamle-scene.txt**

   **python3 scan-seats-hovedscenen.py files-needed\hovedscenen.txt**

Nå er databaseapplikasjonen ferdig satt opp og initialisert.

### Utførelse av brukerhistorier:

1. For å kjøre brukerhistorie 3, kjøpe 9 voksenbilletter, skriv følgende:

   **python3 usecase3.py**

2. For å kjøre brukerhistorie 4, forestillingsinfo for en spesifikk dato, skriv følgende:

   **python3 usecase4.py**

3. For å kjøre brukerhistorie 5, skuespillere som opptrer i teaterstykkene, skriv følgende:

   **sqlite3 usecase5.sql**

4. For å kjøre brukerhistorie 6, hvilke forestillinger som har solgt best, skriv følgende:

   **sqlite3 usecase6.sql**

5. For å kjøre brukerhistorie 7, hvilke skuespillere en oppgitt skuespiller har i spilt i samme akt som, skriv følgende:

   **python3 usecase7.py <Name (Middlename) Surname>**

   eksempel med skuespilleren Arturo Scotti:

   _python3 usecase7.py Arturo Scotti_

## Tekstlige resultater fra spørringene over

- "Kjøp 9 voksenbilletter til forestillingen for Størst av alt er
  kjærligheten 3. februar, hvor det er 9 ledige billetter og hvor stolene er på
  samme rad. Stolene trenger ikke være ved siden av hverandre. Vi ønsker å få
  summert hva det koster å kjøpe disse billettene."

  Billettkjøpet knyttes til dummy-kunden som ble lagt inn ved initialiseringen.

- "Ta inn en dato og skriv ut hvilke forestillinger som finnes på denne datoen, og hvor mange billetter som er solgt til hver av disse. Ta også med forestillinger hvor det ikke er solgt noen billetter."

- "Hvilke skuespillere opptrer i de ulike teaterstykkene? Skriv ut navn på teaterstykke, navn på skuespiller og rolle."

- "Hvilke forestillinger har solgt best? Skriv ut navn på forestilling og dato, og antall solgte plasser. Sorter i synkende rekkefølge etter antall plasser solgt."

- "Lag et program som tar inn et skuespillernavn og finner hvilke skuespillere de har spilt med i samme akt. Skriv ut navn på begge skuespillerne og hvilket skuespill det skjedde."
