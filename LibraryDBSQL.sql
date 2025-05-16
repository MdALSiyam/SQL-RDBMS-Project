USE MASTER
GO
IF DB_ID('LibraryDB') IS NOT NULL
DROP DATABASE LibraryDB

GO
CREATE DATABASE LibraryDB
ON(
name=LibraryDB_Data_1,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LibraryDB_Data_1.mdf',
Size=25MB,
MAXSIZE=100MB,
FileGrowth=5%
)
LOG ON(
name=LibraryDB_Log_1,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LibraryDB_Log_1.mdf',
Size=2MB,
MAXSIZE=25MB,
FileGrowth=1%
)
GO
USE LibraryDB
GO
CREATE TABLE Genre_t
(GenreId int Primary key nonclustered not null,
 GenreTitle varchar(10)  NOT NULL
)
--Question no 10-
CREATE clustered Index ix_Genre_GenreTitle  ON Genre_t(GenreTitle)
--Justify
---exec sp_helpindex  Genre_t
INSERT INTO Genre_t (GenreId,GenreTitle) VALUES
(1,'Fiction'),
(2,'Travel'),
(3,'Drama')
GO
CREATE TABLE Writer_t
(
 WriterId int Primary key  not null,
 FirstName varchar(10)  NOT NULL,
 LastName varchar(10)  NOT NULL
)
GO
INSERT INTO Writer_t (WriterId,FirstName,LastName) VALUES
(101,'George','Orwell'),
(102,'William','Shakespeare'),
(103,'Wilfred','Theisger'),
(104,'Samuel','Becket'),
(105,'Ted','Simon'),
(106,'Jane','Austen')
GO
CREATE TABLE Book_t
(
 BookId int Primary key  not null,
 BookName varchar(35)  NOT NULL,
 WriterId int  NOT NULL REFERENCES Writer_t(WriterId),
 GenreId int  NOT NULL REFERENCES Genre_t(GenreId)
)
GO
INSERT INTO Book_t(BookId,BookName,WriterId,GenreId) VALUES
(121,'Animal Firm',101,1),
(233,'Jupiter Travel',105,2),
(432,'Hamlet',102,3),
(123,'Pride & Prijudice',105,1),
(424,'Arabian Sands',103,2),
(400,'Waiting For Godot',104,3)
GO
CREATE TABLE Member_t
(
 MemberId int Primary key  not null,
 FirstName varchar(10)  NOT NULL,
 LastName varchar(10)  NOT NULL
)
GO
INSERT INTO Member_t (MemberId,FirstName,LastName) VALUES
(201,'Alex','Wilson'),
(202,'Emily','Brown')
CREATE TABLE Transaction_t
(
 TranId int Primary key  not null,
 IssueNo varchar(10)  NOT NULL,
 MemberId int not null REFERENCES Member_t (MemberId),
 IssueDate datetime not null,
 ReturnDate datetime not null
)
GO
INSERT INTO Transaction_t(TranId,IssueNo,MemberId,IssueDate,ReturnDate) VALUES
(301,'OR001',201,'2021-01-01','2021-02-04'),
(302,'OR004',201,'2021-01-10','2021-02-02'),
(303,'OR009',202,'2021-01-15','2021-01-31')
GO
CREATE TABLE TranDetail_t
(
 TranId int REFERENCES Transaction_t(TranId),
 BookId int  REFERENCES Book_t(BookId)
 PRIMARY KEY(TranId,BookId)
)
GO
INSERT INTO TranDetail_t(TranId, BookId) VALUES
(301,121),
(301,233),
(302,432),
(303,123),
(303,424),
(303,400)
GO

CREATE PROC spGenreSelectInsertUpdateDeleteOutput
@statement varchar(6)='',
@GenreId int,
@GenreTitle varchar(10),
@genCount int OUTPUT
AS
BEGIN
if @statement='Select'
--1
BEGIN
SELECT * FROM Genre_t
END
if @statement='Insert'
--2
BEGIN
BEGIN TRANSACTION
BEGIN TRY
INSERT INTO Genre_t (GenreId, GenreTitle) VALUES
(@GenreId,@GenreTitle)
COMMIT TRANSACTION
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
ROLLBACK TRANSACTION
END CATCH
END
if @statement='Update'
--3
BEGIN

BEGIN TRANSACTION
BEGIN TRY
UPDATE Genre_t SET GenreTitle=@GenreTitle WHERE GenreId=@GenreId
COMMIT TRANSACTION
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage
ROLLBACK TRANSACTION
END CATCH

END
if @statement='Delete'
--4
BEGIN
DELETE FROM Genre_t WHERE GenreId=@GenreId
END
if @statement='Count'
--5
BEGIN
SELECT @genCount=COUNT(GenreId) FROM Genre_t
END
END
GO
--Justify
EXEC spGenreSelectInsertUpdateDeleteOutput 'Select','','',''
EXEC spGenreSelectInsertUpdateDeleteOutput 'Insert','4','Comedy',''
EXEC spGenreSelectInsertUpdateDeleteOutput 'Update','4','Tragedy',''
EXEC spGenreSelectInsertUpdateDeleteOutput 'Delete','4','',''
DECLARE @genCount int
EXEC spGenreSelectInsertUpdateDeleteOutput 'Count','','',@genCount OUTPUT
PRINT @genCount
GO
CREATE VIEW vu_LibraryBookIssuInfo
WITH ENCRYPTION, SCHEMABINDING
AS
SELECT td.BookId,b.BookName, w.FirstName+' '+w.LastName AS "Writer Name",
IssueNo,g.GenreTitle,IssueDate,ReturnDate ,m.FirstName+' '+m.LastName AS "Issue To"
FROM dbo.Transaction_t t JOIN dbo.Member_t m ON t.MemberId=m.MemberId
JOIN dbo.TranDetail_t td ON t.TranId=td.TranId
JOIN dbo.Book_t b ON b.BookId=td.BookId
JOIN dbo.Writer_t w ON w.WriterId=b.WriterId
JOIN dbo.Genre_t g ON g.GenreId=b.GenreId

---Justify
--SELECT * FROM vu_LibraryBookIssuInfo
GO
CREATE TRIGGER tr_GenreInsert
ON Genre_t
FOR INSERT 
AS
BEGIN
SELECT * FROM inserted
END
GO
CREATE TRIGGER tr_GenreDeleteRaisError
ON Genre_t
FOR DELETE 
AS
BEGIN
RAISERROR('Deletec Protected',1,1)
ROLLBACK TRANSACTION
END



