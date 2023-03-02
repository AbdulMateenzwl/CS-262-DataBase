--2
SELECT B.Bike_ID, 
       (SELECT SUM(Price) 
        FROM Repairs R 
        JOIN Bike_Status BS ON R.B_Status_ID = BS.B_Status_ID 
        WHERE BS.Bike_ID = B.Bike_ID) AS 'Repairing Cost'
FROM Bikes B;
--3
SELECT S.Location, COUNT(B.Bike_ID)
FROM Stations S
JOIN Bikes B
ON S.Station_ID = B.Station_ID
WHERE B.Bike_ID IN (
    SELECT BS.Bike_ID
    FROM Bike_Status BS
    JOIN Repairs R
    ON BS.B_Status_ID = R.B_Status_ID
)
GROUP BY S.Location
ORDER BY COUNT(B.Bike_ID) DESC;
--4
SELECT S.Location, COUNT(B.Bike_ID)
FROM Stations S
LEFT JOIN (
    SELECT Bike_ID, Station_ID
    FROM Bikes
) B
ON S.Station_ID = B.Station_ID
GROUP BY S.Location;
--5
SELECT CONCAT(Fname, ' ', Lname) CustomerFullName
FROM Customer_Details
WHERE CONCAT(Fname, ' ', Lname) NOT IN (
    SELECT CONCAT(Fname, ' ', Lname)
    FROM Customer_Details
    WHERE Customer_ID IN (
        SELECT Customer_ID
        FROM Customers
        WHERE Customer_ID NOT IN (
            SELECT Customer_ID
            FROM Bike_Rentals
        )
    )
);
--7
SELECT CONCAT(Fname, ' ', Lname) AS 'name of customers'
FROM (
    SELECT CD.Fname, CD.Lname, C.Customer_ID
    FROM Customer_Details CD
    LEFT JOIN Customers C
    ON CD.Customer_ID = C.Customer_ID
    JOIN Payments P
    ON P.Customer_ID = C.Customer_ID
    JOIN Payment_Method PM
    ON PM.Method_ID = P.Method_ID
    WHERE PM.Method <> 'MASTERCARD'
    GROUP BY CD.Fname, CD.Lname, C.Customer_ID
) AS A
WHERE CONCAT(Fname, ' ', Lname) NOT IN (
    SELECT CONCAT(Fname, ' ', Lname)
    FROM Customer_Details CD
    LEFT JOIN Customers C
    ON CD.Customer_ID = C.Customer_ID
    JOIN Payments P
    ON P.Customer_ID = C.Customer_ID
    JOIN Payment_Method PM
    ON PM.Method_ID = P.Method_ID
    WHERE PM.Method <> 'MASTERCARD'
    GROUP BY CONCAT(Fname, ' ', Lname)
);
--8
SELECT TOP (1) A.Location
FROM (
    SELECT S.Location, SUM(V.Bikes) AS TotalBikes
    FROM Stations S
    JOIN Vans V
    ON S.Station_ID = V.Station_ID
    WHERE YEAR(V.Date_stamp) = '2015'
    GROUP BY S.Location
) AS A
ORDER BY A.TotalBikes DESC;
--9
SELECT B.B_Status_ID, AVG(B.Price) AS AverageCost
FROM (
    SELECT R.B_Status_ID, AVG(R.Price) AS Price
    FROM Repairs R
    GROUP BY R.B_Status_ID
) AS B
JOIN Bike_Status BS
ON BS.B_Status_ID = B.B_Status_ID
GROUP BY B.B_Status_ID;