/* Sette inn:
-saler - GOOD
-stoler - NOT GOOD
-teaterstykker - GOOD
-forestillinger - GOOD
-akter
-roller
-skuespillere
-medvirkende
 */

INSERT INTO Ansatt (Identifikator, Navn, Epost, Ansattstatus)
VALUES (1, 'Arturo Scotti', NULL, 'Fast'),
      (2, 'Ingunn Beate Strige Øyen', NULL, 'Fast'),
      (3, 'Hans Petter Nilsen', NULL, 'Fast'),
      (4, 'Madeleine Brandtzæg Nilsen', NULL, 'Fast'),
      (5, 'Synnøve Fossum Eriksen', NULL, 'Fast'),
      (6, 'Emma Caroline Deichmann', NULL, 'Fast'),
      (7, 'Thomas Jensen Takyi', NULL, 'Fast'),
      (8, 'Per Bogstad Gulliksen', NULL, 'Fast'),
      (9, 'Isak Holmen Sørensen', NULL, 'Fast'),
      (10, 'Fabian Heidelberg Lunde', NULL, 'Fast'),
      (11, 'Emil Olafsson', NULL, 'Fast'),
      (12, 'Snorre Ryen Tøndel', NULL, 'Fast'),
      (13, 'Yury Butusov', NULL, 'Fast'),
      (14, 'Aleksandr Shishkin-Hokusai', NULL, 'Fast'),
      (15, 'Eivind Myren', NULL, 'Fast'),
      (16, 'Mina Rype Stokke', NULL, 'Fast'),
      (17, 'Randi Andersen Gafseth', NULL, 'Fast'),
      (18, 'Emily F. Luthentun', NULL, 'Fast'),
      (19, 'Ann Eli Aasgård', NULL, 'Fast'),
      (20, 'Marianne Aunvik', NULL, 'Fast'),
      (21, 'Martin Didrichsen', NULL, 'Fast'),
      (22, 'Are Skarra Kvitnes', NULL, 'Fast'),
      (23, 'Roger Indgul', NULL, 'Fast'),
      (24, 'Anders Schille', NULL, 'Fast'),
      (25, 'Oliver Løding', NULL, 'Fast'),
      (26, 'Karl-Martin Hoddevik', NULL, 'Fast'),
      (27, 'Geir Dyrdal', NULL, 'Fast'),
      (28, 'Trine Bjørhusdal', NULL, 'Fast'),
      (29, 'Renee Desmond', NULL, 'Fast'),
      (30, 'Charlotta Winger', NULL, 'Fast'),
      (31, 'Egil Buseth', NULL, 'Fast'),
      (32, 'Per Arne Johansen', NULL, 'Fast'),
      (33, 'Toril Skipnes', NULL, 'Fast'),
      (34, 'Anita Gundersen', NULL, 'Fast'),

      (35, 'Sunniva Du Mond Nordal', NULL, 'Fast'),
      (36, 'Jo Saberniak', NULL, 'Fast'),
      (37, 'Marte M. Steinholt', NULL, 'Fast'),
      (38, 'Tor Ivar Hagen', NULL, 'Fast'),
      (39, 'Trond-Ove Skrødal', NULL, 'Fast'),
      (40, 'Natalie Grøndahl Tangen', NULL, 'Fast'),
      (41, 'Åsmund Flaten', NULL, 'Fast'),
      (42, 'Jonas Corell Petersen', NULL, 'Fast'),
      (43, 'David Gehrt', NULL, 'Fast'),
      (44, 'Gaute Tønder', NULL, 'Fast'),
      (45, 'Magnus Mikaelsen', NULL, 'Fast'),
      (46, 'Kristoffer Spender', NULL, 'Fast'),
      (47, 'Line Åmli', NULL, 'Fast'),
      (48, 'Lars Magnus Krogh Utne', NULL, 'Fast'),
      (49, 'Livinger Ferner Diesen', NULL, 'Fast'),
      (50, 'Espen Høyem', NULL, 'Fast'),
      (51, 'Kjersti Eckhoff', NULL, 'Fast'),
      (52, 'Ida Marie Brønstad', NULL, 'Fast'),
      (53, 'Jan Magne Høynes', NULL, 'Fast'),
      (54, 'Siril Gaare', NULL, 'Fast'),
      (55, 'Stein Jørgen Øien', NULL, 'Fast'),
      (56, 'Steffen Telstad', NULL, 'Fast'),
      (57, 'Erik Chan', NULL, 'Fast'),
      (58, 'Olav Rui', NULL, 'Fast'),

      (59, 'Elisabeth Egseth Hansen', NULL, 'Fast');

INSERT INTO Teater (Navn, DirektoerID)
VALUES ('Trondelag Teater', (SELECT Identifikator FROM ANSATT WHERE Ansatt.Navn = 'Elisabeth Egseth Hansen'));

INSERT INTO Sal (Navn, Kapasitet, TeaterID)
VALUES ('Hovedscenen', 516, (SELECT TeaterID FROM Teater WHERE Teater.Navn = 'Trondelag Teater')),
      ('Gamle Scene', 332, (SELECT TeaterID FROM Teater WHERE Teater.Navn = 'Trondelag Teater'));




/* Inserting the two plays*/
INSERT INTO Teaterstykke (Navn, Starttid, SalID)
VALUES ('Kongsemnene', '19:00:00', 
        (SELECT SalID FROM Sal WHERE Sal.Navn = 'Hovedscenen')),
        ('Stoerst av alt er kjaerligheten', '18:30:00', 
        (SELECT SalID FROM Sal WHERE Sal.Navn = 'Gamle Scene'));

INSERT INTO Billettpris(BillettklasseID, OrdinaerP, HonnoerP, StudentP, BarneP, Gruppe10P, Gruppe10HonnoerP, TeaterstykkeID)
VALUES (1, 450, 380, 280, NULL, 320, 270, (SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene')),
      (2, 350, 300, 220, 220, 320, 270, (SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Stoerst av alt er kjaerligheten'));



/* Insert the different times of the playes*/
INSERT INTO Forestilling (TeaterstykkeID, ForestillingID, Dato)
VALUES ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 
        1, '2024-02-01'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 
        2, '2024-02-02'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 
        3, '2024-02-03'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 
        4, '2024-02-05'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 
        5, '2024-02-06');

INSERT INTO Forestilling (TeaterstykkeID, ForestillingID, Dato)
VALUES ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        1, '2024-02-03'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        2, '2024-02-06'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        3, '2024-02-07'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        4, '2024-02-12'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        5, '2024-02-13'),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 
        6, '2024-02-14');


/* Insert acts */
INSERT INTO Akt (TeaterstykkeID, AktNR, Navn)
VALUES ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene'), 
        1, NULL),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene'), 
        2, NULL),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene'), 
        3, NULL),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene'), 
        4, NULL),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Kongsemnene'), 
        5, NULL),
        ((SELECT TeaterstykkeID FROM Teaterstykke WHERE Teaterstykke.Navn = 'Stoerst av alt er kjaerligheten'), 
        1, NULL);

/* Inserting roles for Kongsemnd*/
INSERT INTO Rolle (Navn)
VALUES ('Håkon Håkonsen'),
      ('Dagfinn Bonde'),
      ('Jatgeir Skald'),
      ('Sigrid'),
      ('Ingeborg'),
      ('Skule Jarl'),
      ('Inga frå Vartejg'),
      ('Paal Flida'),
      ('Ragnhild'),
      ('Gregorius Jonsson'),
      ('Margrete'),
      ('Biskop Nikolas'),
      ('Peter'),
      /*Stoerst av alt*/
      ('Sunniva Du Mond Nordal'),
      ('Jo Saberniak'),
      ('Marte M. Steinholt'),
      ('Tor Ivar Hagen'),
      ('Trond-Ove Skrødal'),
      ('Natalie Grøndahl Tangen'),
      ('Åsmund Flaten');




/* Inserting akt- for Kongsemd */
INSERT INTO AktRolle (RolleID, TeaterstykkeID, AktNR)
VALUES ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Håkon Håkonsen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Håkon Håkonsen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Håkon Håkonsen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Håkon Håkonsen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Håkon Håkonsen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Dagfinn Bonde'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Dagfinn Bonde'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Dagfinn Bonde'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Dagfinn Bonde'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Dagfinn Bonde'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Jatgeir Skald'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Sigrid'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Sigrid'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Sigrid'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Ingeborg'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Skule Jarl'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Skule Jarl'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Skule Jarl'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Skule Jarl'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Skule Jarl'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Inga frå Vartejg'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Inga frå Vartejg'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Paal Flida'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Paal Flida'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Paal Flida'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Paal Flida'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Paal Flida'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Ragnhild'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Ragnhild'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Gregorius Jonsson'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Gregorius Jonsson'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Gregorius Jonsson'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Gregorius Jonsson'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Gregorius Jonsson'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Margrete'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Margrete'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Margrete'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Margrete'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Margrete'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Biskop Nikolas'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Biskop Nikolas'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 2),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Biskop Nikolas'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),

      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Peter'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 3),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Peter'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 4),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Peter'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Kongsemnene'), 5);


/* Inserting akt-rolle for Stoerst av alt */
INSERT INTO AktRolle (RolleID, TeaterstykkeID, AktNR)
VALUES ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Sunniva Du Mond Nordal'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Jo Saberniak'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Marte M. Steinholt'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Tor Ivar Hagen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Trond-Ove Skrødal'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Natalie Grøndahl Tangen'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1),
      ((SELECT RolleID FROM Rolle WHERE Rolle.Navn = 'Åsmund Flaten'), (SELECT TeaterstykkeID FROM Teaterstykke WHERE Navn = 'Stoerst av alt er kjaerligheten'), 1);




INSERT INTO Skuespillere (RolleID, SkuespillerID)
VALUES (1,1),
      (2,11),
      (3, 11),
      (4, 6),
      (5, 6),
      (7, 3),
      (8, 2),
      (9, 9),
      (10, 4),
      (11, 8),
      (12, 5),
      (13, 7),
      (14, 12),
      (15, 35),
      (16, 36),
      (17, 37),
      (18, 38),
      (19, 39),
      (20, 40),
      (21, 41);


INSERT INTO Arbeidsoppgave (Navn, TeaterstykkeID, Identifikator) 
VALUES ('Regi og musikkutvelgelse', 1, 13),
      ('Scenografi og kostymer', 1, 14),
      ('Lysdesign', 1, 15),
      ('Dramaturg', 1, 16),
      ('Regi', 2, 42),
      ('Scenografi og kostymer', 2, 43),
      ('Musikalsk ansvarlig', 2, 44),
      ('Lysdesign', 2, 45),
      ('Dramaturg', 2, 46);



INSERT INTO Kunde (KundeID, Navn, Mobilnummer, Adresse) 
VALUES (1, 'DummyUser', 00000000, 'Prisens Gate 1');
