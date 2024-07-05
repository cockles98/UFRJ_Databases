CREATE DATABASE my_database;

-- Criação das Tabelas
CREATE TABLE Categories (
    CategoryID int PRIMARY KEY,
    CategoryName varchar(255) NOT NULL,
    Description text
);

CREATE TABLE Customers (
    CustomerID int PRIMARY KEY,
    CustomerName varchar(255) NOT NULL,
    ContactName varchar(255),
    Address varchar(255),
    City varchar(255),
    PostalCode varchar(255),
    Country varchar(255)
);

CREATE TABLE Employees (
    EmployeeID int PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    BirthDate date,
    Photo varchar(255),
    Notes text
);

CREATE TABLE Orders (
    OrderID int PRIMARY KEY,
    CustomerID int,
    EmployeeID int,
    OrderDate date,
    ShipperID int
);

CREATE TABLE OrderDetails (
    OrderDetailID int PRIMARY KEY,
    OrderID int,
    ProductID int,
    Quantity int
);

CREATE TABLE Products (
    ProductID int PRIMARY KEY,
    ProductName varchar(255) NOT NULL,
    SupplierID int,
    CategoryID int,
    Unit varchar(255),
    Price decimal
);

CREATE TABLE Shippers (
    ShipperID int PRIMARY KEY,
    ShipperName varchar(255)
);

CREATE TABLE Suppliers (
    SupplierID int PRIMARY KEY,
    SupplierName varchar(255),
    ContactName varchar(255),
    Address varchar(255),
    City varchar(255),
    PostalCode varchar(255),
    Country varchar(255),
    Phone varchar(255)
);

-- Inserção de Dados

-- Dados na Tabela Categories
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, 'Confections', 'Desserts, candies, and sweet breads'),
(4, 'Dairy Products', 'Cheeses'),
(5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
(6, 'Meat/Poultry', 'Prepared meats'),
(7, 'Produce', 'Dried fruit and bean curd'),
(8, 'Seafood', 'Seaweed and fish');

-- Dados na Tabela Customers
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country) VALUES
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'),
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '05021', 'Mexico'),
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '05023', 'Mexico'),
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'),
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');

-- Dados na Tabela Employees
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, Photo, Notes) VALUES
(1, 'Davolio', 'Nancy', '1948-12-08', 'EmpID1.pic', 'Education includes a BA in psychology from Colorado State University.'),
(2, 'Fuller', 'Andrew', '1952-02-19', 'EmpID2.pic', 'Andrew received his BTS commercial in 1974 and a PhD in international marketing from the University of Dallas in 1981.'),
(3, 'Leverling', 'Janet', '1963-08-30', 'EmpID3.pic', 'Janet has a BS degree in chemistry from Boston College (1984).');

-- Dados na Tabela Orders
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, ShipperID) VALUES
(1, 1, 1, '2024-06-22', 1),
(2, 2, 2, '2024-06-23', 2),
(3, 3, 3, '2024-06-24', 3);

-- Dados na Tabela OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 10),
(2, 1, 2, 20),
(3, 2, 3, 30),
(4, 2, 4, 40),
(5, 3, 5, 50);

-- Dados na Tabela Products
INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, Unit, Price) VALUES
(1, 'Chais', 1, 1, '10 boxes x 20 bags', 18.00),
(2, 'Chang', 1, 1, '24 - 12 oz bottles', 19.00),
(3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10.00),
(4, 'Chef Anton\'s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22.00),
(5, 'Chef Anton\'s Gumbo Mix', 2, 2, '36 boxes', 21.35);

-- Dados na Tabela Shippers
INSERT INTO Shippers (ShipperID, ShipperName) VALUES
(1, 'Speedy Express'),
(2, 'United Package'),
(3, 'Federal Shipping');

-- Dados na Tabela Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Address, City, PostalCode, Country, Phone) VALUES
(1, 'Exotic Liquids', 'Charlotte Cooper', '49 Gilbert St.', 'London', 'EC1 4SD', 'UK', '(171) 555-2222'),
(2, 'New Orleans Cajun Delights', 'Shelley Burke', 'P.O. Box 78934', 'New Orleans', '70117', 'USA', '(100) 555-4822');
