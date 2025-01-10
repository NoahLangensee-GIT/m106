USE WideWorldImporters
-- Länderinfos 
SELECT CountryID, FormalName, SubRegion FROM Application.Countries WHERE CountryName = 'Switzerland';

SELECT * FROM Application.People WHERE FullName NOT LIKE 'a%' ;

SELECT * FROM Sales.Orders 
WHERE OrderDate BETWEEN '2016-01-01' and '2016-01-31' 
ORDER BY OrderDate DESC