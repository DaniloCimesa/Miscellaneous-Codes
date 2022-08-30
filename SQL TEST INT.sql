
--Zadatak 2
WITH cte_a AS (
SELECT 
	A.DBServer
,	Instanca
,	OS
,	Datum_instalacije
,	DATEDIFF(DAY, Datum_instalacije, GETDATE()) AS [Broj dana od instaliranja]
FROM drr.DBservers_ENV A
JOIN drr.DBservers B
ON A.DBServer=B.DBServer
WHERE Datum_instalacije IS NOT NULL)

SELECT *
FROM cte_a
WHERE [Broj dana od instaliranja]<=30


--Zadatak 3
SELECT 
	REPLACE(REPLACE(REPLACE(OS, 'Microsoft', ''), 'Standard', ''),'Enterprise', '') AS [Operativni Sistem]
,	COUNT(*) AS [Ukupan broj DB Servera]
FROM drr.DBservers_ENV A
JOIN drr.DBservers B
ON A.DBServer=B.DBServer
WHERE Edition LIKE '%64%'
GROUP BY OS
ORDER BY [Ukupan broj DB Servera] DESC

--Zadatak 4

SELECT 
	DBServer
,	ROW_NUMBER() OVER (PARTITION BY Edition ORDER BY DBServer ASC) AS [Redni broj]
,	Edition
FROM drr.DBservers

--Zadatak 5

CREATE PROCEDURE DBSrvInst
(
       @DBServer varchar(100),
       @Instanca varchar(20)=NULL,
       @Edicija varchar (100),
       @OS varchar(100))
AS
BEGIN

--1. Way       
/*IF NOT EXISTS  
(
	SELECT * 
	FROM sys.tables t
	JOIN sys.schemas s
	ON t.schema_id=s.schema_id
	WHERE s.name='dbo' AND t.name='LogGresaka')*/

--2. way
IF OBJECT_ID('dbo.LogGresaka') IS NULL
	   CREATE TABLE dbo.LogGresaka
       (
                IDLog INT IDENTITY (1,1) PRIMARY KEY,
                [Error_Number]  INT,
                 [Error_Message] VARCHAR(MAX),
                D_ins DATETIME2)
       CREATE INDEX index_ErrorNum on dbo.LogGresaka ([Error_Number])

       BEGIN TRY
             INSERT INTO drr.DBservers 
             (DBServer, Instanca, Edition)
             VALUES
             (@DBServer, @Instanca, @Edicija)
             --GO
             INSERT INTO drr.DBservers_ENV
             (DBServer, Datum_instalacije, OS)
             VALUES
             (@DBServer, GETDATE(), @OS)
       END TRY
       BEGIN CATCH
             INSERT INTO dbo.LogGresaka
             ([Error_Number], [Error_Message], D_ins)
             VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), GETDATE())
             --SELECT ERROR_NUMBER(), ERROR_MESSAGE(), GETDATE() -- Pandan VALUES 
       END CATCH
END
GO
