--USANDO LA BASE DE DATOS STAGE_NORTHWND
USE Stage_Northwind
GO

--VALIDANDO SI EXISTE LA TABLA Stage_Empleado
IF EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='Stage_Empleado')
BEGIN
	DROP TABLE Stage_Empleado
END
GO

--CREANDO LA TABLA [Stage_Empleado]
CREATE TABLE [dbo].[Stage_Empleado](
	[Empleado_Codigo] [int] NOT NULL,
	[Empleado_Apellido] [varchar](40) NOT NULL,
	[Empleado_Nombre] [varchar](20) NULL,
	[Empleado_NombreCompleto] [varchar](70) NOT NULL,
	[Empleado_Direccion] [varchar](120) NULL,
	[Empleado_Ciudad] [varchar](15) NULL,
	[Empleado_Region] [varchar](15) NULL,
	[Empleado_Pais] [varchar](15) NULL,
	[Empleado_Postal] [varchar](10) NULL,
	[ETLLoad] [datetime] NULL,
	[ETLExecution] [int] NULL
)
GO

-- CONSULTA ORIGEN DE DATOS [Load_Northwind].[dbo].[Employees]
SELECT [EmployeeID], 
CAST(LastName AS VARCHAR(40)) AS [LastName],
CAST(FirstName AS VARCHAR(20)) AS [FirstName],
CONCAT (CAST(FirstName AS VARCHAR(20)), ' ', CAST(LastName AS VARCHAR(40))) AS [FullName],
CAST([Address] AS VARCHAR(120)) AS [Address],
CAST([City] AS VARCHAR(15)) AS [City],
ISNULL(CAST([Region] AS VARCHAR(15)), 'SR') AS [Region],
CAST([Country] AS VARCHAR(15)) AS [Country],
CAST([PostalCode] AS VARCHAR(10)) AS [PostalCode]
FROM [Load_Northwind].[dbo].[Employees]

-- INSERTAR REGISTRO EN METADATA
INSERT INTO ETLExecution (userName, MachineName, PackageName, ETLLoad)
VALUES (?,?,?,GETDATE());

--Obteniendo el ultimo id del Metadata

SELECT TOP (1) ID
FROM ETLExecution
WHERE packageName = ?;

--OBTENER EL MAXIMO ETLExecution de la tabla Load_Northwind.dbo.Employees

SELECT MAX(ETLExecution) FROM Load_Northwind.dbo.Employees

-- Obtener el Maximo ETLExecution de la tabla Load_Northwind.dbo.Employees
SELECT MAX(ETLExecution) FROM Load_Northwind.dbo.Employees


-- Actualizar la cantidad de filas en el Metadata
UPDATE ETLExecution
SET ETLCountRows = ?
WHERE ID = ?

TRUNCATE TABLE Stage_Northwind.dbo.Stage_Empleado;








SELECT * FROM 
Load_Northwind.dbo.Employees
ORDER BY ETLExecution DESC

SELECT * FROM 
Load_Northwind.dbo.Products
ORDER BY ETLExecution DESC

SELECT * FROM
Load_Northwind.dbo.Customers
ORDER BY ETLExecution DESC

SELECT * FROM
Load_Northwind.dbo.Shippers
ORDER BY ETLExecution DESC

SELECT * FROM
Load_Northwind.dbo.Orders
ORDER BY ETLExecution DESC

SELECT * FROM
Load_Northwind.dbo.[Order Details]
ORDER BY ETLExecution DESC



SELECT * FROM
Stage_Northwind.dbo.Stage_Empleado

SELECT * FROM
Stage_Northwind.dbo.Stage_Producto

SELECT * FROM
Stage_Northwind.dbo.Stage_Cliente

SELECT * FROM
Stage_Northwind.dbo.Stage_Transportista

SELECT * FROM
Stage_Northwind.dbo.Stage_Ventas

SELECT * FROM
NORTHWIND_METADATA.dbo.ETLExecution
ORDER BY Id DESC


TRUNCATE TABLE Load_Northwind.[dbo].[Order Details]
TRUNCATE TABLE Load_Northwind.[dbo].[Orders]
TRUNCATE TABLE Load_Northwind.[dbo].[Shippers]
TRUNCATE TABLE Load_Northwind.[dbo].[Customers]
TRUNCATE TABLE Load_Northwind.[dbo].[Products]
TRUNCATE TABLE Load_Northwind.[dbo].[Employees]
TRUNCATE TABLE Stage_Northwind.dbo.Stage_Empleado
TRUNCATE TABLE NORTHWIND_METADATA.[dbo].[ETLExecution]
TRUNCATE TABLE Stage_Northwind.dbo.Stage_Cliente
TRUNCATE TABLE Stage_Northwind.dbo.Stage_Producto
TRUNCATE TABLE Stage_Northwind.dbo.Stage_Transportista
TRUNCATE TABLE Stage_Northwind.dbo.Stage_Ventas



SELECT 
CAST([CustomerID] AS CHAR(5)) AS [CustomerID],
CAST([ContactName] AS VARCHAR(40)) AS [ContactName],
CAST([CompanyName] AS VARCHAR(40)) AS [CompanyName],
CAST([Address] AS VARCHAR(60)) AS [Address],
CAST([City] AS VARCHAR(15)) AS [City],
CAST([Region] AS VARCHAR(15)) AS [Region],
CAST([Country] AS VARCHAR(15)) AS [Country],
CAST([PostalCode] AS VARCHAR(10)) AS [PostalCode]
FROM Load_Northwind.dbo.Customers
WHERE ETLExecution = ?;
go

SELECT 
CAST(o.CustomerID AS char(5)) AS CustomerID, 
o.EmployeeID, 
od.ProductID, 
o.OrderDate, 
od.OrderID, 
CAST((od.UnitPrice * od.Quantity * (1 - od.Discount)) AS decimal(15,2)) AS [Monto], 
CAST(od.Quantity AS INT) AS Quantity, 
CAST(od.UnitPrice AS DECIMAL(15,2)) AS UnitPrice, 
CAST(od.Discount AS DECIMAL(15,2)) AS Discount
FROM 
(
SELECT 
OrderID,CustomerID, EmployeeID, OrderDate 
FROM Orders) AS o
INNER JOIN
(
SELECT OrderID, ProductID, Quantity, UnitPrice, Discount
FROM [Order Details]
) AS od
ON o.OrderID = od.OrderID
WHERE ETLExecution = ?;

go



	SELECT pr.ProductID, pr.ProductName, sp.CompanyName, ca.CategoryName, pr.QuantityPerUnit, pr.UnitPrice, pr.UnitsInStock, pr.UnitsOnOrder, 
		   pr.ReorderLevel, pr.Discontinued 
	FROM (
	SELECT ProductID, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, 
		   ReorderLevel, Discontinued, CategoryID, SupplierID
	FROM Products
	) AS pr
	INNER JOIN 
	(
	SELECT CategoryID, CategoryName
	FROM NORTHWND.dbo.Categories
	) AS ca
	ON pr.CategoryID = ca.CategoryID
	INNER JOIN 
	(
	SELECT SupplierID, CompanyName 
	FROM NORTHWND.dbo.Suppliers
	) AS sp
	ON pr.SupplierID =sp.SupplierID

