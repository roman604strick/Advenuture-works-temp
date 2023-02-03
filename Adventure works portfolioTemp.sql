SELECT *
FROM SALES.SalesPerson

SELECT *
FROM SALES.SalesTerritory

SELECT * 
FROM Production.Product

SELECT * 
FROM ProductioN.ProductCostHistory

SELECT * 
FROM Sales.SalesOrderDetail

SELECT * 
FROM Sales.SalesOrderHeader

-- WILL BRING BACK THE TOP 10 SALES EMPLOYEES IN NORTH AMERICA
SELECT TOP (10) sp.BusinessEntityID, 
sp.SalesLastYear, 
sp.SalesQuota,
sp.TerritoryID, 
st.Country
FROM sales.SalesPerson AS sp
INNER JOIN sales.SalesTerritory AS st
	ON sp.TerritoryID = st.TerritoryID
WHERE country = 'North America'
ORDER BY sp.SalesLastYear DESC

-- return total sales from all countries
SELECT SUM(saleslastyear) AS TotalSales, country
FROM sales.SalesTerritory
GROUP BY COUNTRY
--HAVING SUM(saleslastyear) < 25096493 -- will filter out options below number listed (SUM is the aggregate function)
ORDER BY Totalsales DESC

-- will return certain products with their standing cost and list price
SELECT DISTINCT A.Name, b.StandardCost, a.ListPrice
FROM Production.Product AS a
LEFT JOIN Production.ProductCostHistory AS b
ON a.StandardCost = b.StandardCost
WHERE Name = 'Road-150 Red, 62'
OR Name = 'Road-250 Black, 44'
OR Name = 'Road-250 Red, 44'
OR Name = 'ML Mountain Seat Assembly'
OR Name = 'LL Mountain Handlebars'
AND b.StandardCost IS NOT NULL
ORDER BY StandardCost DESC

-- SHOW CUSTOMER ORDER INFORMATION ALONG WITH THE TERRITORY NUMBER IT WAS BOUGHT FROM
SELECT DISTINCT a.salesordernumber,
b.salesorderID,
a.CustomerID,
c.TerritoryID,
c.Country,
a.purchaseordernumber
FROM Sales.SalesOrderHeader AS a
INNER JOIN Sales.SalesOrderHeader AS b
ON a.salesorderID = b.salesorderid
INNER JOIN Sales.SalesTerritory AS c
ON a.TerritoryID = c.TerritoryID
WHERE a.PurchaseOrderNumber IS NOT NULL
AND country = 'North America'
ORDER BY TerritoryID DESC
