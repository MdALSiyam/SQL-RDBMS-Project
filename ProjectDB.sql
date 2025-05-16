--- Create Database

--USE master
--GO
--IF DB_ID ('ProjectDB') IS NOT NULL
--DROP DATABASE ProjectDB
--GO
--CREATE DATABASE ProjectDB
--ON(
--name=ProjectDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ProjectDB_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=ProjectDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ProjectDB_Log_1.ldf',
--size=2mb,
--maxsize=50mb,
--filegrowth=1mb
--)
--GO

USE ProjectDB
GO

CREATE TABLE Project(
ProjectCode varchar(10) primary key,
ProjectTitle varchar(25) not null,
)
INSERT INTO Project
(ProjectCode, ProjectTitle)
VALUES
('PC01', 'Pensions System'),
('PC04', 'Salary System'),
('PC06', 'HR System')
GO

CREATE TABLE Employee(
EmployeeCode varchar(10) primary key,
EmployeeFName varchar(25) not null,
EmployeeLName varchar(25) not null
)
INSERT INTO Employee
(EmployeeCode, EmployeeFName, EmployeeLName)
VALUES
('S1000', 'Allen', 'Smith'),
('S1003', 'Lewis', 'Jones'),
('S2101', 'Prince', 'Lewis'),
('S1001', 'Barbara', 'Jones'),
('S3100', 'Tony', 'Gilbert'),
('S1321', 'Frank', 'Richo'),
('S1005', 'Robert', 'Jhon')
GO

CREATE TABLE Department(
DepartmentCode varchar(10) primary key,
DepartmentTitle varchar(25) not null,
)
INSERT INTO Department
(DepartmentCode, DepartmentTitle)
VALUES
('L004', 'IT'),
('L023', 'HR'),
('L008', 'Pay Roll'),
('L009', 'Sales')
GO

CREATE TABLE DataRelation(
ProjectCode varchar(10) REFERENCES Project(ProjectCode),
EmployeeCode varchar(10) REFERENCES Employee(EmployeeCode),
DepartmentCode varchar(10) REFERENCES Department(DepartmentCode),
Primary key (ProjectCode, EmployeeCode, DepartmentCode),
ProjectBudget int not null,
HourlyRate decimal (18,2) not null
)
INSERT INTO DataRelation
(ProjectCode, EmployeeCode, DepartmentCode, ProjectBudget, HourlyRate)
VALUES
('PC01', 'S1000', 'L004', 800000, 220.00),
('PC01', 'S1003', 'L023', 800000, 180.50),
('PC01', 'S2101', 'L004', 800000, 210.00),
('PC04', 'S1001', 'L004', 900000, 210.00),
('PC04', 'S1000', 'L004', 900000, 180.00),
('PC04', 'S3100', 'L023', 900000, 25.00),
('PC04', 'S1321', 'L008', 900000, 170.00),
('PC06', 'S3100', 'L023', 600000, 230.00),
('PC06', 'S2101', 'L004', 600000, 170.00),
('PC06', 'S1005', 'L009', 600000, 160.00)
GO