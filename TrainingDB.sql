--- Create Database

--USE master
--GO
--IF DB_ID ('TrainingDB') IS NOT NULL
--DROP DATABASE TrainingDB
--GO
--CREATE DATABASE TrainingDB
--ON(
--name=Training_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Training_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=Training_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Training_Log_1.ldf',
--size=2mb,
--maxsize=25mb,
--filegrowth=1%
--)
--GO

USE TrainingDB
GO

CREATE TABLE Student(
StudentID int primary key,
StudentFName varchar(25) not null,
StudentLName varchar(25) not null
)
INSERT INTO Student
(StudentID, StudentFName, StudentLName)
VALUES
(101, 'Jhon', 'Smith'),
(102, 'Jane', 'Bloggs'),
(103, 'Mark', 'Antony')
GO

CREATE TABLE Trainer(
TrainerID int primary key,
TrainerFName varchar(25) not null,
TrainerLName varchar(25) not null,
TrainerPhone varchar(10) not null Unique
)
INSERT INTO Trainer
(TrainerID, TrainerFName, TrainerLName, TrainerPhone)
VALUES
(201, 'Roger', 'Burks', '800-13232'),
(202, 'Kate', 'Alan', '800-64644'),
(203, 'Evan', 'Bright', '800-13231'),
(204, 'Robart', 'Kim', '800-13234')
GO

CREATE TABLE Training(
TrainingID int primary key,
TrainingName varchar(15) not null
)
INSERT INTO Training
(TrainingID, TrainingName)
VALUES
(301, 'Tennis'),
(302, 'Swimming'),
(303, 'Squash'),
(304, 'Golf')
GO

CREATE TABLE Unit(
UnitID int primary key,
UnitName varchar(15) not null
)
INSERT INTO Unit
(UnitID, UnitName)
VALUES (400, 'Hour')
GO

CREATE TABLE Enrollment(
StudentID int REFERENCES Student(StudentID),
TrainerID int REFERENCES Trainer(TrainerID),
TrainingID int REFERENCES Training(TrainingID),
Primary key (StudentID, TrainerID, TrainingID),
Duration int not null,
UnitID int REFERENCES Unit(UnitID),
HourlyPayment decimal (18,2) not null,
AdvancePay decimal (18,2) not null
)
INSERT INTO Enrollment
(StudentID, TrainerID, TrainingID, Duration, UnitID, HourlyPayment, AdvancePay)
VALUES
(101, 201, 301, 72, 400, 100, 0.40),
(101, 202, 302, 40, 400, 50, 0.30),
(102, 203, 303, 72, 400, 150, 0.50),
(102, 202, 302, 40, 400, 50, 0.30),
(103, 204, 304, 128, 400, 200, 0.50)
GO