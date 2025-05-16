--- Create Database ---

--USE master
--GO
--IF DB_ID ('CollegeDB') IS NOT NULL
--DROP DATABASE CollegeDB
--GO
--CREATE DATABASE CollegeDB
--ON(
--name=CollegeDB_Data_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CollegeDB_Data_1.mdf',
--size=25mb,
--maxsize=100mb,
--filegrowth=5%
--)
--LOG ON(
--name=CollegeDB_Log_1,
--filename='C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CollegeDB_Log_1.ldf',
--size=2mb,
--maxsize=50mb,
--filegrowth=1mb
--)

--- Create Table ---

USE CollegeDB
GO

CREATE TABLE Teacher(
TeacherID int primary key not null,
TeacherName varchar(10) not null
)
INSERT INTO Teacher
(TeacherID, TeacherName)
VALUES
(101, 'A'),
(102, 'B'),
(103, 'C')
GO

CREATE TABLE Student(
StudentID int primary key not null,
StudentName varchar(10) not null
)
INSERT INTO Student
(StudentID, StudentName)
VALUES
(201, 'AA'),
(202, 'BB'),
(203, 'CC'),
(204, 'DD'),
(205, 'EE'),
(206, 'FF'),
(207, 'GG'),
(208, 'HH'),
(209, 'II')
GO

CREATE TABLE Semester(
SemesterID int primary key not null,
SemesterName varchar(20) not null
)
INSERT INTO Semester
(SemesterID, SemesterName)
VALUES
(301, 'Spring'),
(302, 'Summer'),
(303, 'Fail'),
(304, 'Winter')
GO

CREATE NONCLUSTERED INDEX ix_Semester_SemesterName
ON Semester(SemesterName)
--- Justify ---
EXEC sp_helpindex 'Semester'

CREATE TABLE Subjects(
SubjectID int primary key not null,
SubjectName varchar(20) not null
)
INSERT INTO Subjects
(SubjectID, SubjectName)
VALUES
(401, 'C#'),
(402, 'Data Base'),
(403, 'Web Design'),
(404, 'Data Mining'),
(405, 'MIS'),
(406, 'PHP'),
(407, 'Project Management'),
(408, 'PCL'),
(409, 'Software Engineering')
GO

CREATE TABLE DataRelation(
TeacherID int not null REFERENCES Teacher(TeacherID),
StudentID int not null REFERENCES Student(StudentID),
SemesterID int not null REFERENCES Semester(SemesterID),
SubjectID int not null REFERENCES Subjects(SubjectID)
Primary key (TeacherID, StudentID, SemesterID, SubjectID)
)
INSERT INTO DataRelation
([TeacherID], [StudentID], [SemesterID], [SubjectID])
VALUES
(101, 201, 301, 401),
(101, 202, 301, 401),
(101, 204, 301, 401),

(102, 201, 301, 402),
(102, 203, 301, 402),
(102, 209, 301, 402),

(103, 205, 301, 403),
(103, 208, 301, 403),
(103, 202, 301, 403),
(103, 207, 301, 403),

(101, 205, 302, 401),
(101, 207, 302, 401),

(102, 202, 302, 404),
(102, 206, 302, 404),
(102, 208, 302, 404),

(103, 201, 302, 405),
(103, 202, 302, 405),
(103, 203, 302, 405),

(101, 208, 303, 406),
(101, 209, 303, 406),

(102, 205, 303, 402),
(102, 207, 303, 402),
(102, 204, 303, 402),

(103, 209, 303, 407),
(103, 204, 303, 407),
(103, 206, 303, 407),

(101, 203, 304, 408),
(101, 206, 304, 408),

(102, 201, 304, 409),
(102, 202, 304, 409),
(102, 207, 304, 409),

(103, 201, 304, 403),
(103, 203, 304, 403),
(103, 204, 304, 403)
GO
