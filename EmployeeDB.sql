--- Create Database

--USE master
--GO
--IF DB_ID ('EmployeeDB') IS NOT NULL
--DROP DATABASE EmployeeDB
--GO
--CREATE DATABASE EmployeeDB
--ON(
--name=Employee_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Employee_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=Employee_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Employee_Log_1.ldf',
--size=2mb,
--maxsize=25mb,
--filegrowth=1%
--)

--- Create Table ---

USE EmployeeDB
GO

CREATE TABLE Employee(
EmployeeID int primary key,
EmployeeName varchar (20) not null,
JoiningDate date not null,
EmailAddress varchar (50) Unique not null,
PhoneNo varchar (11) Unique not null
)

INSERT INTO Employee
(EmployeeID, EmployeeName, JoiningDate, EmailAddress, PhoneNo)
VALUES
(101, 'Nasir Ahmed', '2017-07-01', 'nasir@gmail.com', '01512345678'),
(102, 'Kaiser Alam', '2017-01-01', 'alam@gmail.com', '01612345678'),
(103, 'Azad Ahmed', '2018-03-01', 'azad@gmail.com', '01712345678'),
(104, 'Saiful Haque', '2016-07-01', 'saif@gmail.com', '01912345678')
GO

CREATE TABLE Department(
DepartmentID int primary key,
DepartmentName varchar (15) not null
)
INSERT INTO Department
(DepartmentID, DepartmentName)
VALUES
(201, 'Accounts'),
(202, 'Admin'),
(203, 'IT'),
(204, 'HR')
GO

CREATE TABLE Designation(
DesignationID int primary key,
DesignationName varchar (20) not null
)
INSERT INTO Designation
(DesignationID, DesignationName)
VALUES
(301, 'Accounts Assistant'),
(302, 'Administrator'),
(303, 'Assistant Manager'),
(304, 'HR Operation')
GO


CREATE TABLE Grade(
GradeID int primary key,
GradeName varchar (5) not null
)
INSERT INTO Grade
(GradeID, GradeName)
VALUES
(401, 'G01'),
(402, 'G02'),
(403, 'G03')
GO

CREATE TABLE DataRelation(
EmployeeID int not null REFERENCES Employee(EmployeeID),
DepartmentID int not null REFERENCES Department(DepartmentID),
DesignationID int not null REFERENCES Designation(DesignationID),
GradeID int not null REFERENCES Grade(GradeID)
Primary key (EmployeeID, DepartmentID, DesignationID, GradeID)
)
INSERT INTO DataRelation
([EmployeeID], [DepartmentID], [DesignationID], [GradeID])
VALUES
(101, 201, 301, 402),
(102, 202, 302, 401),
(103, 203, 303, 403),
(104, 204, 304, 402)
GO

