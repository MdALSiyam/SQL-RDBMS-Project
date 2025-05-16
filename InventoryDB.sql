--- Create Database ---

--USE master
--GO
--IF DB_ID ('InventoryDB') IS NOT NULL
--DROP DATABASE InventoryDB
--GO
--CREATE DATABASE InventoryDB
--ON(
--name=InventoryDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\InventoryDB _Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=InventoryDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\InventoryDB_Log_1.ldf',
--size=2mb,
--maxsize=50mb,
--filegrowth=1mb
--)

--- Create Table ---

USE InventoryDB
GO
CREATE TABLE Item(
ItemId int primary key,
ItemType varchar(20)
)
INSERT INTO Item 
(ItemId, ItemType) VALUES
(1, 'Camp shirt'),
(2, 'Dress shirt'),
(3, 'T-shirt'),
(4, 'Polo shirt')
GO

CREATE TABLE Color(
ColorId int primary key not null,
ColorName varchar(15) NOT NULL
)
INSERT INTO Color (ColorId, ColorName)
VALUES
(100, 'Red'),
(101, 'Blue')
GO

CREATE TABLE ItemColor
(
ItemNo varchar(10) primary key NOT NULL,
ItemId int REFERENCES Item(ItemId),
ColorId int REFERENCES Color(ColorId)
)
INSERT INTO ItemColor (ItemNo, ItemId, ColorId) VALUES
('Item 1', 1, 100),
('Item 2', 1, 101),
('Item 3', 2, 100),
('Item 4', 2, 101),
('Item 5', 3, 100),
('Item 6', 3, 101),
('Item 7', 4, 100),
('Item 8', 4, 101)
GO

CREATE TABLE Unit(
UnitId int not null primary key,
UnitName varchar(5) not null
)
INSERT INTO Unit (UnitId, UnitName) VALUES (200, 'pcs')
GO

CREATE TABLE Itemlot(
LotId varchar(5),
ItemNo varchar(10) REFERENCES ItemColor(ItemNo),
Quantity int not null,
UnitId int REFERENCES Unit(UnitId) NOT NULL,
UnitPrice decimal(18,2) not null,
Vat decimal(18,2) NOT NULL
)
INSERT INTO Itemlot (LotId, ItemNo, Quantity, UnitId, UnitPrice, Vat)
VALUES
('Lot 1', 'Item 1', 6, 200, 1100, 0.15),
('Lot 1', 'Item 2', 6, 200, 1200, 0.15),
('Lot 1', 'Item 3', 6, 200, 1300, 0.15),
('Lot 1', 'Item 4', 6, 200, 1400, 0.15),
('Lot 1', 'Item 5', 6, 200, 1500, 0.15),
('Lot 1', 'Item 6', 6, 200, 1600, 0.15),
('Lot 1', 'Item 7', 6, 200, 1700, 0.15),
('Lot 1', 'Item 8', 6, 200, 1800, 0.15),

('Lot 2', 'Item 1', 12, 200, 1150, 0.15),
('Lot 2', 'Item 2', 12, 200, 1250, 0.15),
('Lot 2', 'Item 3', 12, 200, 1350, 0.15),
('Lot 2', 'Item 4', 12, 200, 1450, 0.15),
('Lot 2', 'Item 5', 12, 200, 1550, 0.15),
('Lot 2', 'Item 6', 12, 200, 1650, 0.15),
('Lot 2', 'Item 7', 12, 200, 1750, 0.15),
('Lot 2', 'Item 8', 12, 200, 1850, 0.15)
GO