--- Create Database

--USE master
--GO
--IF DB_ID ('TSPDB') IS NOT NULL
--DROP DATABASE TSPDB
--GO
--CREATE DATABASE TSPDB
--ON(
--name=TSPDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TSPDB_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=TSPDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TSPDB_Log_1.ldf',
--size=2mb,
--maxsize=25mb,
--filegrowth=1%
--)
--GO

--- Create Table ---
USE TSPDB
GO

CREATE TABLE Student(
StudentID int primary key,
StudentFName varchar(25) not null,
StudentLName varchar(25) not null
)
INSERT INTO Student
(StudentID, StudentFName, StudentLName)
VALUES
(101, 'RAIHAN', 'KABIR'),
(102, 'AZMAL', 'HOSSAIN'),
(103, 'MIFTAHUL', 'ALAM'),
(104, 'MD.', 'ABDULLAH'),
(105, 'RAFIQUL', 'ISLAM'),
(106, 'SIRAJUR', 'RAHMAN')
GO

CREATE TABLE District(
DistrictID int primary key,
DistrictName varchar(15) not null
)
INSERT INTO District
(DistrictID, DistrictName)
VALUES
(201, 'Sylhet'),
(202, 'Khulna'),
(203, 'Dhaka'),
(204, 'Rajshahi')
GO

CREATE TABLE Batch(
BatchID char(20) primary key,
TSPName varchar(5) not null,
CourseName varchar(5) not null
)
INSERT INTO Batch
(BatchID, TSPName, CourseName)
VALUES
('SCSL-29-1A-CS', 'SCSL', 'CS'),
('USSL-29-1A-WPDF', 'USSL', 'WPDF'),
('TCL-29-1M-J2EE', 'TCL', 'J2EE'),
('PNT-29-1M-GV', 'PNTL', 'GAVE')
GO

CREATE TABLE DataRelation(
StudentID int REFERENCES Student(StudentID),
DistrictID int REFERENCES District(DistrictID),
BatchID char(20) REFERENCES Batch(BatchID),
Primary key (StudentID, DistrictID, BatchID)
)
INSERT INTO DataRelation
(StudentID, DistrictID, BatchID)
VALUES
(101, 201, 'SCSL-29-1A-CS'),
(102, 202, 'USSL-29-1A-WPDF'),
(103, 203, 'USSL-29-1A-WPDF'),
(104, 203, 'SCSL-29-1A-CS'),
(105, 204, 'TCL-29-1M-J2EE'),
(106, 201, 'PNT-29-1M-GV')
GO