-- Datenbank erstellen
USE master;
CREATE DATABASE m106;
GO
-- Schema in der Datenbank erstellen
USE m106;
GO
CREATE SCHEMA verkauf;
GO

-- Tabelle kunden im Schema verkauf erstellen
CREATE TABLE verkauf.kunden (
    kundenid INT IDENTITY(1,1),
    vorname VARCHAR(30),
    nachname VARCHAR(30)
);
-- Lege zum Vergleich dieselbe Tabelle im Standardschema an

-- Tabelle bestellungen im Schema verkauf erstellen
CREATE TABLE verkauf.bestellungen (
    bestellid INT IDENTITY(1,1),
    bestelldatum DATE,
    kundenid INT
);

-- Aufruf der gespeicherten Prozedur sp_columns
EXEC sp_columns @table_name = N'kunden',  @table_owner = N'verkauf'; 


-- neue Spalte bestellwert hinzufügen
ALTER TABLE verkauf.bestellungen ADD bestellwert DECIMAL(10,2);

EXEC sp_columns @table_name = N'bestellungen',  @table_owner = N'verkauf'; 


EXEC sp_rename 'verkauf.bestellungen.bestellwert', 'bestellbetrag', 'COLUMN';

-- Länge der Spalte vornamen auf 50 ändern
ALTER TABLE verkauf.kunden ALTER COLUMN vorname VARCHAR(50);

-- Datentyp der Spalte bestelldatum zu DATETIME ändern
ALTER TABLE verkauf.bestellungen ALTER COLUMN bestelldatum DATETIME;

-- Spalte bestellbetrag aus der Tabelle löschen
ALTER TABLE verkauf.bestellungen DROP column bestellbetrag;

-- Tabelle bestellungen im Schema verkauf löschen
DROP TABLE verkauf.bestellungen;

CREATE TABLE verkauf.bestellungen(
    bestellid INT IDENTITY(1,1),
    bestelldatum DATETIME,
    kundenid INT
);

-- Primärschlüssel beim Erstellen der neuen Tabelle produkte definieren
CREATE TABLE verkauf.produkte (
    produktid INT IDENTITY(1,1) PRIMARY KEY,
    produktname VARCHAR(100),
    preis MONEY,
    energielabel CHAR(1)
);

-- Primärschlüssel auf der Tabelle kunden nachträglich definieren
ALTER TABLE verkauf.kunden ADD PRIMARY KEY (kundenid);

-- Primärschlüssel auf der Tabelle bestellungen nachträglich definieren
ALTER TABLE verkauf.bestellungen ADD PRIMARY KEY (bestellid);

/*
Fremdschlüssel auf der Tabelle bestellungen definieren, welcher auf die Primär-
schlüsselspalte der Tabelle kunden verweist
*/
ALTER TABLE verkauf.bestellungen  
ADD CONSTRAINT fk_bestellungen_kunden FOREIGN KEY (kundenid) 
REFERENCES verkauf.kunden(kundenid);

/* 
Identisches Beispiel mit dem Unterschied, dass der Constraint nicht explizit 
benannt wird
*/
ALTER TABLE verkauf.bestellungen  
ADD FOREIGN KEY (kundenid) REFERENCES verkauf.kunden(kundenid);

/* Der Fremdschlüssel wird wieder gelöscht oder ersetzt: */
ALTER TABLE verkauf.bestellungen  
DROP CONSTRAINT fk_bestellungen_kunden;


-- keine leeren Werte in der Spalte nachname zulassen
ALTER TABLE verkauf.kunden ALTER COLUMN nachname VARCHAR(30) NOT NULL;

-- Standartwert in der Spalte vorname setzen
ALTER TABLE verkauf.kunden ADD DEFAULT 'unbekannt' FOR vorname;

/* 
Regel hinzufügen, dass in der Spalte bestelldatum nur Datumswerte eingefügt werden
dürfen, welche nicht älter als 01.01.2020 sind
*/
ALTER TABLE verkauf.bestellungen ADD CHECK (bestelldatum > '31.12.2019');

-- Regel definieren, dass in der Spalte energielabel nur bestimmte Werte erlaubt sind
ALTER TABLE verkauf.produkte ADD CHECK (energielabel IN ('A','B','C','D','E'));

