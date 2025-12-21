CREATE DATABASE Restaurant
USE Restaurant
CREATE TABLE Meals(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50));
ALTER TABLE Meals ADD Price NVARCHAR(50)

CREATE TABLE Tables(
Id INT PRIMARY KEY IDENTITY,
[No] NVARCHAR(50));

CREATE TABLE Orders(
Id INT,
MealId INT,
TableId INT,
	PRIMARY KEY (MealId, TableId),
    FOREIGN KEY (MealId) REFERENCES Meals(Id),
    FOREIGN KEY (TableId) REFERENCES Tables(Id)
);
ALTER TABLE Orders ADD DateTimeData DATETIME;
ALTER TABLE Orders ADD ID INT;

INSERT INTO Meals (Name, Price) VALUES
('Pizza',20),('Steyk',35), ('Pasta',15);

INSERT INTO Tables (No) VALUES
(100),(101),(102)

INSERT INTO Orders (MealId, TableId) VALUES
(7,1),(8,1),(7,2),(7,3);

SELECT 
	m.*,
	COUNT(s.id) AS Orders
FROM Tables m
LEFT JOIN Orders s
	ON s.TableId=m.id
GROUP BY m.id;


SELECT 
    m.Tables,
@@ -41,10 +93,11 @@ JOIN Tables g ON mg.TableId = g.TableId
JOIN Orders ma ON m.MealsId = ma.MealsId
JOIN Meals a ON ma.MealsId = a.MealsId;

SELECT 

	





