-- 1 PERFORM JOIN ON ANY TABLE IN NORTH WIND SCHEMA
SELECT ORDERS.OrderID, ORDERS.CustomerID,[Order Details].UnitPrice
FROM ORDERS
JOIN [Order Details]
ON [Order Details].OrderID = ORDERS.OrderID


-- 2 PERFORM SELF AND CROSS JOIN
SELECT E.FirstName,M.FirstName
FROM Employees E
JOIN Employees M
ON E.ReportsTo = M.EmployeeID

-- 3 -- RETURN CUSTOMERS WITH THEIR ORDERS INCLUDING CUSTOMERS WHICH HAVE PLACED NO ORDERS
SELECT C.CompanyName,ORDERS.OrderID,Orders.OrderDate
FROM Customers C
LEFT JOIN Orders
ON C.CustomerID = ORDERS.CustomerID

-- 4 -- REPORT ONLY THOSE CUSTOMERS WHO NEVER PLACED ANY ORDER
SELECT C.CompanyName,ORDERS.OrderID,Orders.OrderDate
FROM Customers C
LEFT JOIN Orders
ON C.CustomerID = ORDERS.CustomerID
WHERE ORDERS.OrderID IS NULL

-- 5 -- Report those customers who have placed order on July,1997
SELECT C.CompanyName,ORDERS.OrderID,Orders.OrderDate
FROM Customers C
JOIN Orders
ON C.CustomerID = ORDERS.CustomerID
WHERE YEAR(OrderDate) = 1997 AND 
	MONTH(OrderDate) = 7

-- 6 -- REPORT TOTAL ORDERS OF EACH CUSTOMER
SELECT C.CustomerID,COUNT(ORDERS.OrderID)
FROM Customers C
JOIN Orders
ON C.CustomerID = ORDERS.CustomerID
GROUP BY C.CustomerID

--7 -- WRITE A QUERY TO GENERATE FIVE COPIES OF EACH EMPLOYEE
SELECT E.EmployeeID,E.FirstName,E.LastName
FROM Employees AS E,(SELECT TOP(5) Employees.EmployeeID
	FROM  Employees) AS M

-- 8 -- SELECT EMPLOYEES WITH DAY IN GIVEN YEAR
DECLARE @dStart DATE,
        @dEnd DATE
SET @dStart = CAST('1996-07-04' AS datetime)
SET @dEnd = CAST('1997-08-04' AS datetime)
;WITH CTE AS
(
    SELECT @dStart AS dDay
    UNION ALL
    SELECT DATEADD (DAY, 1, dDay)
    FROM CTE
    WHERE dDay < @dEnd
)
SELECT Employees.EmployeeID,dDAY 
FROM CTE,Employees
OPTION (MaxRecursion 32767)

-- 9 Return total all USA customers with with total number of orders and total quantity
select C.CustomerID,COUNT(O.OrderID) AS TOTAL_ORDERS,COUNT(OD.Quantity) AS QUANTITY
from Customers C
JOIN Orders O
ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
WHERE C.Country = 'US'
GROUP BY C.CustomerID

-- 10 List the name of Employees with age who are older there manager
SELECT E.FirstName,YEAR(GETDATE()) - YEAR(E.BirthDate) AS [EMPLOYEE AGE],
YEAR(GETDATE()) - YEAR(M.BirthDate) AS [MANAGER AGE]
FROM Employees E
Join Employees M
on E.EmployeeID = M.ReportsTo
where E.BirthDate < M.BirthDate

-- 11 Product which are ordered on July 4,1997
select P.ProductName
FROM [Order Details] OD
JOIN ORDERS O
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
WHERE O.OrderDate = CAST('1997-08-08' AS datetime)

-- 12 all orders which were serviced by Anne and were shipped late
SELECT Address,CITY,Country
FROM ORDERS O
JOIN Employees E
ON O.EmployeeID = E.EmployeeID
WHERE E.FirstName ='ANNE' AND
	O.ShippedDate > RequiredDate

--13 LIST NAME OF COUNTRY TO WHICH BEVERAGES HAVE BEEN SHIPPED 
SELECT DISTINCT O.ShipCountry
FROM ORDERS O
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
JOIN Categories C
ON C.CategoryID = P.CategoryID
WHERE C.CategoryName = 'BEVERAGES'
