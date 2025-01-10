USE WideWorldImporters;
SELECT * FROM Sales.Customers;
SELECT CustomerName, DeliveryAddressLine1 FROM Sales.Customers;

-- Beispiel mit originalem Spaltennamen
SELECT CustomerName, PhoneNumber Telefonnummer 
FROM Sales.Customers;

SELECT CountryName + ' ('+ IsoAlpha3Code + ')' AS 'Land' FROM Application.Countries ORDER BY CountryName DESC

SELECT DISTINCT Continent FROM Application.Countries;

-- alle Bestellungen sortiert nach Bestelldatum (die ältesten zuerst)
SELECT TOP 3 * FROM Sales.Orders ORDER BY OrderDate ASC;