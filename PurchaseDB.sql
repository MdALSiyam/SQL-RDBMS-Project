--- Create Database

--USE master
--GO
--IF DB_ID ('PurchaseDB') IS NOT NULL
--DROP DATABASE PurchaseDB
--GO
--CREATE DATABASE PurchaseDB
--ON(
--name=PurchaseDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PurchaseDB_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=PurchaseDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\PurchaseDB_Log_1.ldf',
--size=2mb,
--maxsize=25mb,
--filegrowth=1%
--)
--GO

--- Create Table ---
USE PurchaseDB
GO

CREATE TABLE Customer(
CustomerID int primary key not null,
CustomerFName varchar(25) not null,
CustomerLName varchar(25) not null,
CustomerPhone varchar(10) not null
)
INSERT INTO Customer
(CustomerID, CustomerFName, CustomerLName, CustomerPhone)
VALUES
(101, 'Jhon', 'Doe', '555-1234'),
(102, 'Jane', 'Smith', '555-1235'),
(103, 'Frank', 'Lee', '555-1236')
GO

CREATE TABLE Model(
ModelID int primary key not null,
Title varchar(15) not null
)
INSERT INTO Model
(ModelID, Title)
VALUES
(201, 'Fusion'),
(202, 'Impala'),
(203, 'Accord')
GO

CREATE TABLE Brand(
BrandID int primary key not null,
Title varchar(15) not null
)
INSERT INTO Brand
(BrandID, Title)
VALUES
(301, 'Ford'),
(302, 'Chary'),
(303, 'Honda')
GO

CREATE TABLE Car(
CarID int primary key not null,
ModelID int REFERENCES Model(ModelID),
BrandID int REFERENCES Brand(BrandID),
CarYear int not null
)
INSERT INTO Car
(CarID, ModelID, BrandID, CarYear)
VALUES
(401, 201, 301, 2015),
(402, 202, 302, 2015),
(403, 203, 303, 2014),
(404, 203, 303, 2015)
GO

CREATE TABLE Purchase(
PurchaseID int primary key not null,
CustomerID int REFERENCES Customer(CustomerID),
CarID int REFERENCES Car(CarID),
PurchaseDate date not null,
LoanPercent decimal(18,2) not null
)
INSERT INTO Purchase
(PurchaseID, CustomerID, CarID, PurchaseDate, LoanPercent)
VALUES
(501, 101, 401, '2023-01-01', 0.50),
(502, 102, 402, '2023-03-01', 0.60),
(503, 103, 403, '2023-01-02', 0.60),
(504, 101, 404, '2023-01-03', 0.70)
GO