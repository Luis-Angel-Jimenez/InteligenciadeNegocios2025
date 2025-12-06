SELECT 
CAST([Cliente_Codigo] AS NVARCHAR (10)) AS [Cliente_Codigo],
CAST([Cliente_Compania] AS NVARCHAR(40)) AS [Cliente_Compania],
CAST([Cliente_Nombre] AS NVARCHAR(30)) AS [Cliente_Nombre],
CAST([Cliente_Direccion] AS NVARCHAR(60)) AS [Cliente_Direccion],
CAST([Cliente_Ciudad] AS NVARCHAR(15)) AS [Cliente_Ciudad],
CAST([Cliente_Region] AS NVARCHAR(15)) AS [Cliente_Region],
CAST([Cliente_Postal] AS NVARCHAR(10)) AS [Cliente_Postal],
CAST([Cliente_Pais] AS NVARCHAR(15)) AS [Cliente_Pais],
[ETLLoad],
[ETLExecution]
FROM Stage_Northwind.dbo.Stage_Cliente

INSERT INTO [Stage_Northwind].[dbo].[Dim_Customer_Mod]
(Cliente_Codigo, Cliente_Compania, Cliente_Nombre, Cliente_Direccion, 
Cliente_Ciudad, Cliente_Region, Cliente_Postal, Cliente_Pais ,[ETLLoad])
VALUES (?, ?, ?, ?, ?, ?, ?, ?,GETDATE())
GO

CREATE TABLE Stage_Northwind.dbo.Dim_Customer_MOD
(
[ClienteID] INT IDENTITY(1,1) NOT NULL,
[Cliente_Codigo] INT NOT NULL,
[Cliente_Compania] NVARCHAR(40) NOT NULL,
[Cliente_Nombre] NVARCHAR(30),
[Cliente_Direccion] NVARCHAR(60),
[Cliente_Ciudad]NVARCHAR(15),
[Cliente_Region]NVARCHAR(15),
[Cliente_Postal]NVARCHAR(10),
[Cliente_Pais] NVARCHAR(15),
[ETLLoad] DATETIME
)


SELECT * FROM Datamart_Northwind.dbo.dim_customer