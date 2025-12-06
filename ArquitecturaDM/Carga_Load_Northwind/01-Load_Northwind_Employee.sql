-- CREAR LA TABLA EMPLOYEES
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
	[ETLLoad] DATETIME,
	[ETLExecution] INT 
);
GO

DROP TABLE Employees

TRUNCATE TABLE Employees

Select * from Employees


-- CONSULTAR LA TABLA ETLExecution

Select * from [NORTHWIND_METADATA].[dbo].[ETLExecution]

-- INSERTAR REGISTROS EN LA TABLA ETLExecution
INSERT INTO ETLExecution (UserName, MachineName, PackageName, ETLLoad)
VALUES(?,?,?,GETDATE());

--Seleccionar el ultimo ID
SELECT TOP 1 ID FROM ETLExecution 
WHERE PackageName = ?
ORDER BY ID DESC

SELECT * FROM NORTHWIND_METADATA.DBO.ETLExecution;

SELECT * FROM Load_Northwind.dbo.Employees;

TRUNCATE TABLE NORTHWIND_METADATA.dbo.ETLExecution;
TRUNCATE TABLE Load_Northwind.dbo.Employees;

-- ACTUALIZAR LA TABLA ETLExecution PARA INSERTAR LA CANTIDAD DE FILAS

UPDATE ETLExecution
SET ETLCountRows
WHERE ID = ? 