-- Create Database
CREATE DATABASE TorontoCMS;
GO

-- Use the newly created database
USE TorontoCMS;
GO

-- Create SubwayStations table
CREATE TABLE SubwayStations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Latitude FLOAT,
    Longitude FLOAT
);
GO

-- Insert dummy data for SubwayStations (near major stations)
INSERT INTO SubwayStations (Name, Latitude, Longitude) VALUES
('Union Station', 43.6456, -79.3801),
('St. George Station', 43.6636, -79.4009),
('Bloor-Yonge Station', 43.6695, -79.3865),
('King Station', 43.6467, -79.3806),
('Dundas Station', 43.6541, -79.3808),
('Spadina Station', 43.6647, -79.4027);
GO

-- Create Restaurants table
CREATE TABLE Restaurants (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Type NVARCHAR(50),
    SubwayStationID INT,
    Latitude FLOAT,
    Longitude FLOAT,
    FOREIGN KEY (SubwayStationID) REFERENCES SubwayStations(ID)
);
GO

-- Insert dummy data for Restaurants
INSERT INTO Restaurants (Name, Type, SubwayStationID, Latitude, Longitude) VALUES
('Wahlburgers', 'American', 1, 43.6445, -79.3811),
('Harbour 60', 'Steakhouse', 2, 43.6631, -79.3965),
('The Keg', 'Steakhouse', 3, 43.6704, -79.3846),
('Aloette', 'French', 4, 43.6478, -79.3800),
('Pizzeria Libretto', 'Italian', 5, 43.6548, -79.3801),
('KINKA IZAKAYA', 'Japanese', 6, 43.6632, -79.4020);
GO

-- Create GroceryStores table
CREATE TABLE GroceryStores (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Type NVARCHAR(50),
    SubwayStationID INT,
    Latitude FLOAT,
    Longitude FLOAT,
    FOREIGN KEY (SubwayStationID) REFERENCES SubwayStations(ID)
);
GO

-- Insert dummy data for GroceryStores
INSERT INTO GroceryStores (Name, Type, SubwayStationID, Latitude, Longitude) VALUES
('Walmart', 'Supermarket', 1, 43.6455, -79.3800),
('FreshCo', 'Supermarket', 2, 43.6635, -79.3970),
('No Frills', 'Supermarket', 3, 43.6692, -79.3850),
('Loblaws', 'Supermarket', 4, 43.6461, -79.3795),
('Metro', 'Supermarket', 5, 43.6540, -79.3807),
('Longos', 'Supermarket', 6, 43.6630, -79.4015);


GO
-- Procedure to get restaurants or grocery stores based on the user's choice
CREATE PROCEDURE GetPlaces
    @SubwayStationName NVARCHAR(100),
    @Category NVARCHAR(50) -- 'Restaurant' or 'Grocery'
AS
BEGIN
    DECLARE @SubwayStationID INT;

    -- Get the Subway Station ID based on the input
    SELECT @SubwayStationID = ID 
    FROM SubwayStations
    WHERE Name = @SubwayStationName;

    IF @Category = 'Restaurant'
    BEGIN
        -- Return nearby restaurants
        SELECT Name, Type, Latitude, Longitude
        FROM Restaurants
        WHERE SubwayStationID = @SubwayStationID;
    END
    ELSE IF @Category = 'Grocery'
    BEGIN
        -- Return nearby grocery stores
        SELECT Name, Type, Latitude, Longitude
        FROM GroceryStores
        WHERE SubwayStationID = @SubwayStationID;
    END
    ELSE
    BEGIN
        PRINT 'Invalid Category. Please choose either Restaurant or Grocery.';
    END
END;
GO
