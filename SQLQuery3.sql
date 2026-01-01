CREATE DATABASE Restaurant;
GO

USE Restaurant;
GO


CREATE TABLE Meals (
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
GO


CREATE TABLE Tables (
    Id INT PRIMARY KEY IDENTITY,
    [No] INT NOT NULL
);
GO


CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY,
    MealId INT NOT NULL,
    TableId INT NOT NULL,
    DateTimeData DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MealId) REFERENCES Meals(Id),
    FOREIGN KEY (TableId) REFERENCES Tables(Id)
);
GO

INSERT INTO Meals ([Name], Price) VALUES
('Pizza', 20.00),
('Steyk', 35.00),
('Pasta', 15.00);
GO


INSERT INTO Tables ([No]) VALUES
(100), (101), (102);
GO


INSERT INTO Orders (MealId, TableId, DateTimeData) VALUES
(1, 1, GETDATE()), 
(2, 1, GETDATE()), 
(1, 2, GETDATE()),  
(1, 3, GETDATE());  
GO



INSERT INTO Orders (MealId, TableId, DateTimeData) VALUES
(2, 2, DATEADD(HOUR, -2, GETDATE())),      
(3, 3, DATEADD(MINUTE, -90, GETDATE())),    
(1, 1, DATEADD(MINUTE, -45, GETDATE())),    
(2, 1, DATEADD(MINUTE, -120, GETDATE()));   
GO


SELECT 
    t.Id,
    t.[No] AS TableNumber,
    COUNT(o.Id) AS OrderCount
FROM Tables t
LEFT JOIN Orders o ON o.TableId = t.Id
GROUP BY t.Id, t.[No]
ORDER BY t.[No];
GO


SELECT 
    m.Id,
    m.[Name] AS MealName,
    m.Price,
    COUNT(o.Id) AS OrderCount
FROM Meals m
LEFT JOIN Orders o ON o.MealId = m.Id
GROUP BY m.Id, m.[Name], m.Price
ORDER BY OrderCount DESC;
GO


SELECT 
    o.Id AS OrderId,
    o.DateTimeData AS OrderDateTime,
    m.[Name] AS MealName,
    m.Price
FROM Orders o
JOIN Meals m ON o.MealId = m.Id
ORDER BY o.DateTimeData DESC;
GO

SELECT 
    o.Id AS OrderId,
    o.DateTimeData AS OrderDateTime,
    m.[Name] AS MealName,
    m.Price,
    t.[No] AS TableNumber
FROM Orders o
JOIN Meals m ON o.MealId = m.Id
JOIN Tables t ON o.TableId = t.Id
ORDER BY o.DateTimeData DESC;
GO


SELECT 
    t.Id,
    t.[No] AS TableNumber,
    COUNT(o.Id) AS OrderCount,
    ISNULL(SUM(m.Price), 0) AS TotalAmount
FROM Tables t
LEFT JOIN Orders o ON o.TableId = t.Id
LEFT JOIN Meals m ON o.MealId = m.Id
GROUP BY t.Id, t.[No]
ORDER BY TotalAmount DESC;
GO


SELECT 
    t.[No] AS TableNumber,
    MIN(o.DateTimeData) AS FirstOrder,
    MAX(o.DateTimeData) AS LastOrder,
    DATEDIFF(HOUR, MIN(o.DateTimeData), MAX(o.DateTimeData)) AS HoursDifference,
    DATEDIFF(MINUTE, MIN(o.DateTimeData), MAX(o.DateTimeData)) AS MinutesDifference,
    DATEDIFF(SECOND, MIN(o.DateTimeData), MAX(o.DateTimeData)) AS SecondsDifference
FROM Orders o
JOIN Tables t ON o.TableId = t.Id
WHERE o.TableId = 1
GROUP BY t.[No];
GO


SELECT 
    o.Id AS OrderId,
    o.DateTimeData AS OrderDateTime,
    m.[Name] AS MealName,
    t.[No] AS TableNumber,
    DATEDIFF(MINUTE, o.DateTimeData, GETDATE()) AS MinutesAgo
FROM Orders o
JOIN Meals m ON o.MealId = m.Id
JOIN Tables t ON o.TableId = t.Id
WHERE DATEDIFF(MINUTE, o.DateTimeData, GETDATE()) > 30
ORDER BY o.DateTimeData DESC;
GO


SELECT 
    t.Id,
    t.[No] AS TableNumber
FROM Tables t
LEFT JOIN Orders o ON o.TableId = t.Id
WHERE o.Id IS NULL;
GO


SELECT 
    t.Id,
    t.[No] AS TableNumber,
    MAX(o.DateTimeData) AS LastOrderTime,
    CASE 
        WHEN MAX(o.DateTimeData) IS NULL THEN NULL
        ELSE DATEDIFF(MINUTE, MAX(o.DateTimeData), GETDATE())
    END AS MinutesSinceLastOrder
FROM Tables t
LEFT JOIN Orders o ON o.TableId = t.Id
GROUP BY t.Id, t.[No]
HAVING MAX(o.DateTimeData) IS NULL 
    OR DATEDIFF(MINUTE, MAX(o.DateTimeData), GETDATE()) > 60
ORDER BY t.[No];
GO


....new

