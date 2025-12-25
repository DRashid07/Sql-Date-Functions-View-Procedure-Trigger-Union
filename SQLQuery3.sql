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


SELECT 
    t.Id,
    t.[No] AS TableNumber,
    COUNT(o.Id) AS OrderCount
FROM Tables t
LEFT JOIN Orders o ON o.TableId = t.Id
GROUP BY t.Id, t.[No];
GO


SELECT 
    o.Id AS OrderId,
    m.[Name] AS MealName,
    m.Price,
    t.[No] AS TableNumber,
    o.DateTimeData AS OrderDateTime
FROM Orders o
JOIN Meals m ON o.MealId = m.Id
JOIN Tables t ON o.TableId = t.Id;
GO


SELECT 
    t.[No] AS TableNumber,
    m.[Name] AS MealName,
    m.Price,
    COUNT(o.Id) AS TimesOrdered,
    SUM(m.Price) AS TotalAmount
FROM Orders o
JOIN Meals m ON o.MealId = m.Id
JOIN Tables t ON o.TableId = t.Id
GROUP BY t.[No], m.[Name], m.Price
ORDER BY t.[No];
GO


SELECT 
    m.[Name] AS MealName,
    COUNT(o.Id) AS TimesOrdered,
    SUM(m.Price) AS TotalRevenue
FROM Meals m
LEFT JOIN Orders o ON o.MealId = m.Id
GROUP BY m.Id, m.[Name]
ORDER BY TimesOrdered DESC;
GO



--new.

