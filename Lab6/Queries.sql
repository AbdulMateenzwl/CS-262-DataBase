select *
from orders

select *
from Products ,Suppliers
where Suppliers.SupplierID in ( select distinct SupplierID from Products)

select o.OrderID , (select ContactName from Customers where O.CustomerID = Customers.CustomerID )
from orders O
where o.CustomerID in (select CustomerID from Customers)
--1
SELECT c.CustomerID, o.OrderID, o.OrderDate
FROM Customers c, (
    SELECT OrderID, CustomerID, OrderDate
    FROM Orders
) o
WHERE c.CustomerID = o.CustomerID
ORDER BY c.CustomerID, o.OrderID;

--2
select CustomerID
from Customers
where CustomerID not in (select customerid from orders)


--3
select *
from orders
where orders.CustomerID in (
	select O.CustomerID
	from Orders O
	where year(O.OrderDate) = 1997 and MONTH(O.OrderDate) = 7
)

---4
select CustomerID, ( select count(OrderID) from Orders group by orders.CustomerID having orders.CustomerID = Customers.CustomerID )
from Customers

--5
select p.ProductName
from Products P
where p.UnitPrice > ( select AVG(UnitPrice)
					from Products
				)

--
SELECT ShipAddress AS Address, ShipCity AS City, ShipCountry AS Country
FROM Orders
WHERE EmployeeID = (SELECT EmployeeID FROM Employees WHERE LastName = 'Anne')
AND ShippedDate > RequiredDate
--
SELECT DISTINCT ShipCountry AS Country
FROM Orders
WHERE OrderID IN (
    SELECT OrderID
    FROM [Order Details]
    WHERE ProductID IN (
        SELECT ProductID
        FROM Products
        WHERE CategoryID = (
            SELECT CategoryID
            FROM Categories
            WHERE CategoryName = 'Beverages'
        )
    )
) 
