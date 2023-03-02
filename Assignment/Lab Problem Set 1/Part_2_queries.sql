--1
SELECT CustomerID,ContactName
FROM Customers
WHERE CustomerID IN (
  SELECT CustomerID
  FROM Orders
  WHERE ShippedDate > RequiredDate
)
--2
SELECT Products.ProductName,Suppliers.ContactName
FROM Products
JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.SupplierID IN (
  SELECT DISTINCT SupplierID
  FROM Products
)
--3
SELECT P.ProductName, TotalRevenue
FROM Products P
INNER JOIN (
  SELECT ProductID, SUM(Quantity*UnitPrice) AS TotalRevenue
  FROM [Order Details] OD
  INNER JOIN Orders O ON OD.OrderID = O.OrderID
  WHERE YEAR(OrderDate) = '1998'
  GROUP BY ProductID
) AS Subquery ON P.ProductID = Subquery.ProductID
ORDER BY TotalRevenue DESC;
--4 
SELECT CONCAT(E.FIRSTNAME,E.LASTNAME) EmployeeName, 
(SELECT CONCAT(E1.FirstName, E1.LastName) ManagerName 
FROM Employees E1 
WHERE E.ReportsTo=E1.EmployeeID)
FROM Employees E

--5
SELECT EmployeeID, FirstName, ReportCount
FROM (
  SELECT E2.EmployeeID, E2.FirstName, COUNT(E1.EmployeeID) AS ReportCount
  FROM Employees E1
  JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
  GROUP BY E2.EmployeeID, E2.FirstName
) AS Subquery
WHERE ReportCount < 4;


--6
SELECT *
FROM Products P
WHERE P.UnitPrice > (
  SELECT AVG(UnitPrice)
  FROM Products
);
--7
SELECT MAX(UnitPrice)
FROM (
  SELECT *
  FROM Products
  WHERE UnitPrice NOT IN (
    SELECT MAX(UnitPrice)
    FROM Products
  )
) AS Subquery;



--8 
SELECT 
    e1.LastName + ', ' + e1.FirstName AS EmployeeName,
    e2.LastName + ', ' + e2.FirstName AS ManagerName,
    YEAR(GETDATE()) - YEAR(e1.BirthDate) AS EmployeeAge,
    YEAR(GETDATE()) - YEAR(e2.BirthDate) AS ManagerAge
FROM 
    Employees e1
    INNER JOIN Employees e2 ON e1.ReportsTo = e2.EmployeeID
WHERE 
    YEAR(GETDATE()) - YEAR(e1.BirthDate) > YEAR(GETDATE()) - YEAR(e2.BirthDate)



--9
SELECT P.ProductName
FROM Products P
WHERE P.ProductID IN (SELECT ProductID FROM [Order Details] WHERE OrderID IN 
(SELECT OrderID FROM Orders WHERE OrderDate='19970808'))

--10
SELECT ContactName
FROM Suppliers
WHERE SupplierID IN (
  SELECT SupplierID
  FROM Products
  WHERE ProductID IN (
    SELECT ProductID
    FROM [Order Details]
    WHERE OrderID IN (
      SELECT OrderID
      FROM Orders
      WHERE YEAR(OrderDate) = '1997'
    )
  )
)


--11
SELECT COUNT(DISTINCT EmployeeID)
FROM EmployeeTerritories
WHERE TerritoryID IN(
	SELECT TerritoryID
	FROM Territories
	WHERE RegionID IN (
		SELECT RegionID
		FROM Region
		WHERE RegionDescription='Eastern '
	)
)


--12
SELECT P.ProductName
FROM Products P
WHERE P.ProductID IN (
	SELECT ProductID 
	FROM [Order Details] 
	WHERE OrderID IN 
		(SELECT OrderID 
		FROM Orders
		WHERE YEAR(OrderDate)<>'1996'
	)
)
