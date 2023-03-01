CREATE TABLE Company(
	name VARCHAR (50), 
	city VARCHAR (50)
	)


CREATE TABLE Product_1(name VARCHAR (50),
	maker VARCHAR (50), 
	cost INT,
	year INT

)
CREATE TABLE Purchase(
	id int,
	product VARCHAR (50),
	buyer VARCHAR (50),
	price INT
)

INSERT INTO Company(name , city) VALUES('Uniliver','lahore'); 
INSERT INTO Company(name , city) VALUES('Packages','lahore'); 
INSERT INTO Company(name , city) VALUES('United','lahore'); 
INSERT INTO Company(name , city) VALUES('Engro','karachi'); 
INSERT INTO Company(name , city) VALUES('FFC','karachi'); 
INSERT INTO Company(name , city) VALUES('Netsol','karachi'); 
INSERT INTO Company(name , city) VALUES('Devinsic','karachi'); 
INSERT INTO Company(name , city) VALUES('Top Grade','swl'); 
INSERT INTO Company(name , city) VALUES('Al-Habib','sialkot'); 
INSERT INTO Company(name , city) VALUES('Fuaji','sargodah'); 

INSERT INTO Product_1(name, maker, cost,year) VALUES('Pamolive','Uniliver',100,2001); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Dove','Uniliver',150,2005); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Clean & Clear','Uniliver',120,2010); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Head & Sholders','Uniliver',120,2017); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Bright','Uniliver',120,2015); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('HAND SANITIZER','Uniliver',220,2018); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Shares','Uniliver',1200,2020);
INSERT INTO Product_1(name, maker, cost,year) VALUES('Dividend','Uniliver',1150,2020);
INSERT INTO Product_1(name, maker, cost,year) VALUES('Dividend','Uniliver',1150,2020);

--PUT 4 SAME NAME Product_1 OF UNILIVER AND OTHER MANUFACTURES

INSERT INTO Product_1(name, maker, cost,year) VALUES('Dove','Packages',140,2007); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Clean & Clear','Fuaji',140,2010); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Head & Sholders','Packages',110,2016); 

INSERT INTO Product_1(name, maker, cost,year) VALUES('Fertilizer urea 2','Engro',400,2009); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('FFC urea Nitro','FFC',400,2012); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('CD 70','United',1000,2007); 

INSERT INTO Product_1(name, maker, cost,year) VALUES('Maths1','Top Grade',700,2018);
INSERT INTO Product_1(name, maker, cost,year) VALUES('Bank','Al-Habib',400,2018); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Car','Honda',40000,2001); 

INSERT INTO Product_1(name, maker, cost,year) VALUES('Finance up','Netsol',500,2013); 
INSERT INTO Product_1(name, maker, cost,year) VALUES('Web 3.0','Devinsic',250,2014); 


--ADD 3 PRODUCTS SOLD IN LOSS

INSERT INTO Purchase(product,buyer,price) VALUES('Web 3.0','Aslam',220); 
INSERT INTO Purchase(product,buyer,price) VALUES('Finance up','Ali',480); 
INSERT INTO Purchase(product,buyer,price) VALUES('Bank','Babar',340); 

--1 PEOPLE BUT LAHORE PRODUCTS

INSERT INTO Purchase(product,buyer,price) VALUES('Dove','Aslam',220); 
INSERT INTO Purchase(product,buyer,price) VALUES('Dove','Ali',200); 

--2 PEOPLE BUY KARACHI PRODUCTS
--MORE THAN 5 CUSTOMERS BUY A SINGLE PRODUCT

INSERT INTO Purchase(product,buyer,price) VALUES('CD 70','Khadim',1200); 
INSERT INTO Purchase(product,buyer,price) VALUES('CD 70','Aslam',1150); 
INSERT INTO Purchase(product,buyer,price) VALUES('CD 70','Asad',1250); 
INSERT INTO Purchase(product,buyer,price) VALUES('CD 70','Mateen',1100); 
INSERT INTO Purchase(product,buyer,price) VALUES('CD 70','Abdullah',1500);



-- First Problem 
-- Sub Query
select name
from Product_1
where Product_1.cost > (
		Select Avg(cost)
		from Product_1
)
-- 
SELECT p.name
FROM Product_1 p
JOIN (SELECT AVG(cost) AS avgCost
	FROM Product_1) q
ON p.cost > q.avgCost
--
Select p.name
from Product_1 p,Product_1 p2
group by AVG(p.cost)
having p.cost > 5

-- Second Problem
-- join
select *
from Company
join Product_1
on Company.name = Product_1.maker
join Purchase
on Product_1.name = Purchase.product
where Purchase.buyer = 'Aslam'
-- cartasian join
select Company.name
from Company,Product_1,Purchase
where Company.name = Product_1.maker and
	Product_1.name = Purchase.product and 
	Purchase.buyer = 'Aslam'
-- Nested Query
select c.name
from Company c
where c.name in (
	Select p.maker
	from Product_1 p
	where p.name in (
		select product
		from Purchase
		where buyer='Aslam'
	)
)

-- Third Problem
-- Nested Query
select name
from Product_1
where cost > (
	select SUM(cost)
	from Product_1
	where maker = 'Uniliver'
)
-- 
SELECT p.name
FROM Product_1 p
JOIN (
	SELECT MAX(cost) maxcost
	FROM Product_1
	WHERE maker = 'Uniliver'
) q
ON p.cost > q.maxcost
-- 
SELECT p.name
FROM Product_1 AS p,(
	SELECT MAX(cost) maxcost
	FROM Product_1
	WHERE maker = 'Uniliver'
) q
where p.cost > q.maxcost

-- Fourth Problem
-- 
select name,MAKER
from Product_1 AS P
where P.maker = 'UNILIVER'
EXCEPT
SELECT DISTINCT NAME
FROM Product_1 AS PR
WHERE PR.maker ='UNILIVER'
--
SELECT NAME,MAKER
FROM Product_1 AS P
WHERE P.MAKER = 'UNILIVER' AND NAME NOT IN (
	SELECT DISTINCT NAME
	FROM Product_1 AS PR
	WHERE MAKER = 'UNILIVER'
)
--
SELECT p.name, p.maker
FROM Product_1 p
JOIN (SELECT name
	FROM Product_1
	WHERE maker = 'UNILIVER'
) q
ON p.name = q.name
WHERE p.maker <> 'UNILIVER'
--
SELECT p.name, p.maker
FROM Product_1 p ,(
	SELECT name
	FROM Product_1
	WHERE maker = 'UNILIVER'
) q
WHERE p.maker <> 'UNILIVER' and p.name = q.name


-- 5th problem
--
select buyer
from Purchase
where product in (
	select name 
	from Product_1
	where maker in (
		select name
		from Company
		where city = 'Lahore'
	)
)
--
select buyer
from Purchase
join Product_1
on Purchase.product = Product_1.name
join Company
on Company.name= Product_1.maker
where Company.city ='Lahore'
--
select buyer
from Purchase,(
	select name,maker
	from Product_1
) AS q,(
	select name,city
	from Company
) AS p
where p.city= 'Lahore' and q.maker=p.name and q.name = Purchase.product


-- Sixth Problem
--
select Purchase.buyer
from Purchase
EXCEPT 
select Purchase.buyer
from Product_1 product
join company
on Product.maker= Company.name
join Purchase
on product.name = Purchase.product
where city<>'karachi'
--
select Purchase.buyer
from Product,company ,Purchase
where product.name = Purchase.product and
 Product.maker= Company.name
EXCEPT 
select Purchase.buyer
from Product, company , Purchase
where product.name = Purchase.product AND 
	Product.maker= Company.name AND city<>'karachi'

--
select Purchase.buyer
from Product,company ,Purchase
where product.name = Purchase.product and
 Product.maker= Company.name AND Purchase.buyer NOT IN(
	select Purchase.buyer
	from Product, company , Purchase
	where product.name = Purchase.product AND 
		Product.maker= Company.name AND city<>'karachi'
	)

-- SEVENTH PROBLEM
--
SELECT P.product,P.price
FROM Purchase P
GROUP BY P.product,P.price
HAVING P.product IN(
	SELECT product
	FROM Purchase
	GROUP BY product
	HAVING COUNT(product) > 5
	)
--
SELECT P.product,P.price
FROM Purchase P
GROUP BY P.product,P.price
HAVING COUNT(P.product) > 5

--
SELECT P.product,AVG(P.PRICE) AS PRICE
FROM Purchase P
GROUP BY P.product
HAVING COUNT(P.product) > 5

-- EIGHTH PROBLEM
--
SELECT Company.name, MAX(PRODUCT_1.cost) AS [MAX PRICE PRODUCT]
FROM Product_1
JOIN Company
ON Product_1.maker = Company.name
WHERE YEAR < 2015
GROUP BY Company.name
--
SELECT Company.name, MAX(PRODUCT_1.cost) AS [MAX PRICE PRODUCT]
FROM Product_1 ,Company
WHERE Product_1.maker = Company.name AND YEAR < 2015
GROUP BY Company.name
--


--NINTH PROBLEM
--
SELECT COMPANY.NAME
FROM COMPANY
EXCEPT
SELECT C.NAME
FROM COMPANY C
JOIN Product_1 P
on C.NAME = P.MAKER
JOIN PURCHASE PR
ON PR.PRODUCT = P.NAME
WHERE PR.PRICE - P.COST > 0
--
SELECT COMPANY.NAME
FROM COMPANY
EXCEPT
SELECT C.NAME
FROM COMPANY C , Product_1 P , PURCHASE PR
WHERE C.NAME = P.MAKER AND
	PR.PRODUCT = P.NAME AND
	PR.PRICE - P.COST > 0
-- TENTH PROBLEM

 






