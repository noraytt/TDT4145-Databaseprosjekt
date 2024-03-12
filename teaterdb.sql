CREATE TABLE Teater (
	TeaterID 	INTEGER NOT NULL,
	Navn 		VARCHAR (30) NOT NULL,
	DirektoerID 	INTEGER NOT NULL,

	CONSTRAINT Teater_PK PRIMARY KEY (TeaterID),
	CONSTRAINT Teater_FK FOREIGN KEY (DirektoerID) REFERENCES Ansatt(Identifikator)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



CREATE TABLE Sal (
	SalID 		INTEGER NOT NULL,
	Navn 		VARCHAR (30)NOT NULL,
	Kapasitet	INTEGER NOT NULL,
	TeaterID 	INTEGER NOT NULL,

	CONSTRAINT Sal_PK PRIMARY KEY (SalID),
	CONSTRAINT Sal_FK FOREIGN KEY (TeaterID) REFERENCES Teater(TeaterID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



		

CREATE TABLE Teaterstykke (
	TeaterstykkeID		INTEGER NOT NULL,
	Navn 				VARCHAR (100) NOT NULL,
	Starttid			TIME NOT NULL,
	SalID 				INTEGER NOT NULL,
	BillettklasseID		INTEGER NOT NULL,

	CONSTRAINT Teaterstykke_PK PRIMARY KEY (TeaterstykkeID),
	CONSTRAINT Teaterstykke_FK FOREIGN KEY (SalID) REFERENCES Sal(SalID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT Teaterstykke_FK FOREIGN KEY (BillettklasseID) REFERENCES Billettpris(BillettklasseID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



CREATE TABLE Ansatt (
	Identifikator	INTEGER NOT NULL,
	Navn 			VARCHAR (30) NOT NULL,
	Epost			VARCHAR (30) NOT NULL,
	Ansattstatus	VARCHAR (20) DEFAULT “Fast” CHECK (Ansattstatus IN ('Fast', 'Midlertidig', 'Innleid', 'Frivillig/Statist')),

	CONSTRAINT Ansatt_PK PRIMARY KEY (Identifikator));





CREATE TABLE Akt (
	TeaterstykkeID	INTEGER NOT NULL,
	AktNR			INTEGER NOT NULL,
	Navn			VARCHAR (30),

	CONSTRAINT Akt_PK PRIMARY KEY (TeaterstykkeID, AktNR),
	CONSTRAINT Akt_FK FOREIGN KEY (TeaterstykkeID) REFERENCES Teaterstykke(TeaterstykkeID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);

		

CREATE TABLE Rolle (
	RolleID			INTEGER NOT NULL,
	Navn			VARCHAR (50)NOT NULL,

	CONSTRAINT Rolle_PK PRIMARY KEY (RolleID));
		
CREATE TABLE AktRolle (
	RolleID			INTEGER NOT NULL,
	TeaterstykkeID	INTEGER NOT NULL,
	AktNR			INTEGER NOT NULL,
	
	CONSTRAINT AktRolle_PK PRIMARY KEY (RolleID, TeaterstykkeID, AktNR),
	CONSTRAINT AktRolle_FK FOREIGN KEY (TeaterstykkeID, AktNR) REFERENCES Akt(TeaterstykkeID, AktNR)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT AktRolle_FK FOREIGN KEY (RolleID) REFERENCES Rolle(RolleID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);
		

CREATE TABLE Forestilling (
	TeaterstykkeID		INTEGER NOT NULL,
	ForestillingID		INTEGER NOT NULL,
	Dato				DATE NOT NULL,

	CONSTRAINT Forestilling_PK PRIMARY KEY (TeaterstykkeID, ForestillingID),
	CONSTRAINT Forestilling_FK FOREIGN KEY (TeaterstykkeID) REFERENCES Teaterstykke(TeaterstykkeID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);

CREATE TABLE Stol (
	StolID			INTEGER NOT NULL,
	StolNR			INTEGER NOT NULL,
	RadNR			INTEGER NOT NULL,
	Type			VARCHAR (20) CHECK (Type IN ('Parkett', 'Balkong', 'Galleri')) NOT NULL,
	SalID			INTEGER NOT NULL,

	CONSTRAINT Stol_PK PRIMARY KEY (StolID),
	CONSTRAINT Stol_FK FOREIGN KEY (SalID) REFERENCES Sal(SalID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



CREATE TABLE Billett (
	BillettID		INTEGER NOT NULL,
	StolID			INTEGER NOT NULL,
	Prisklasse 		VARCHAR (20) DEFAULT 'Ordinaer' CHECK (Prisklasse IN ('Ordinaer', 'Honnoer', 'Student', 'Barn', 'Over10Ordinaer', 'Over10Honnoer')),
	Salgsstatus		BOOLEAN DEFAULT 0,
	TeaterstykkeID 	INTEGER NOT NULL,
	ForestillingID	INTEGER NOT NULL,


	CONSTRAINT Billett_PK PRIMARY KEY (BillettID),
	CONSTRAINT BillettT_FK FOREIGN KEY (StolID) REFERENCES Stol(StolID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT Billett_FK FOREIGN KEY (TeaterstykkeID, ForestillingID) REFERENCES Forestilling(TeaterstykkeID, ForestillingID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



		

CREATE TABLE Kunde (
	KundeID			INTEGER NOT NULL,
	Navn			VARCHAR (50) NOT NULL,
	Mobilnummer		INTEGER NOT NULL,
	Adresse			VARCHAR (100) NOT NULL,

	CONSTRAINT Kunde_PK PRIMARY KEY (KundeID));

	



CREATE TABLE Billettpris (
	BillettklasseID		INTEGER NOT NULL,
	OrdinaerP			INTEGER NOT NULL,
	HonnoerP				INTEGER,
	StudentP			INTEGER,
	BarneP				INTEGER,
	Gruppe10P			INTEGER,
	Gruppe10HonnoerP		INTEGER,
	TeaterstykkeID		INTEGER NOT NULL,

	CONSTRAINT Billettpris_PK PRIMARY KEY (BillettklasseID),
	CONSTRAINT Billettpris_FK FOREIGN KEY (TeaterstykkeID) REFERENCES Teaterstykke(TeaterstykkeID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);





CREATE TABLE Arbeidsoppgave (
	OppgaveNR			INTEGER NOT NULL,
	Navn				VARCHAR (200) NOT NULL,
	TeaterstykkeID		INTEGER NOT NULL,
	Identifikator		INTEGER NOT NULL,


	CONSTRAINT Arbeidsoppgave_PK PRIMARY KEY (OppgaveNR),
	CONSTRAINT Arbeidsoppgave_FK FOREIGN KEY (TeaterstykkeID) REFERENCES Teaterstykke(TeaterstykkeID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT Arbeidsoppgave_FK FOREIGN KEY (Identifikator) REFERENCES Ansatt(Identifikator)
		ON UPDATE CASCADE
		ON DELETE NO ACTION);



		

CREATE TABLE Skuespillere (
	RolleID 			INTEGER NOT NULL,
	SkuespillerID		INTEGER NOT NULL,

	CONSTRAINT Skuespillere_PK PRIMARY KEY (RolleID, SkuespillerID),
	CONSTRAINT Skuespillere_FK FOREIGN KEY (RolleID) REFERENCES Roller(RolleID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT Rolle_FK FOREIGN KEY (SkuespillerID) REFERENCES Ansatt(Identifikator)
		ON UPDATE CASCADE
		ON DELETE NO ACTION );

		

		

CREATE TABLE Billettkjoep (
	BillettID 	INTEGER NOT NULL,
	KundeID		INTEGER NOT NULL,
	Dato		DATE NOT NULL,
	Tidspunkt	TIME NOT NULL,

	CONSTRAINT Billettkjoep_PK PRIMARY KEY (BillettID, KundeID),
	CONSTRAINT Billettkjoep_FK FOREIGN KEY (BillettID) REFERENCES Billett(BillettID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	CONSTRAINT BKundebillett_FK FOREIGN KEY (KundeID) REFERENCES Kunde(KundeID)
		ON UPDATE CASCADE
		ON DELETE NO ACTION );

		