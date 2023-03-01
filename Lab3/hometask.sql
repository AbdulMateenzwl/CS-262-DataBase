select * 
from orders
where requiredDate < shippedDate


select distinct country
from employees


select *
from products
where discontinued = 1


select OrderID
from [order details]
where discount = 0



select contactName
from customers
where region is NULL


select contactName
from customers
where country = 'UK' or country = 'USA'


-- missing


select shipCountry
from orders
where year(shippedDate) = 1997


select customerid
from orders
where shippeddate is NULL


select supplierid,companyname,country
from suppliers



select * 
from employees
where city = 'London'


select productname 
from products
where discontinued = 0



select productid
from [order details]
where discount <= 0.1



select employeeid,concat(firstname,' ',lastname) as employeeName, homephone
from employees
where region is NULL
