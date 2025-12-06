CREATE TABLE [dbo].[Stage_Producto](
    [Producto_Codigo] [int] NOT NULL,
    [Producto_Nombre] [varchar](40) NOT NULL,
    [Producto_PUnitario] [decimal](15, 2) NULL,
    [CategoriaProducto_Nombre] [nvarchar](15) NOT NULL,
    [ProveedorNombre] [varchar](40) NULL,
    [ETLLoad] [datetime] NULL,
    [ETLExecution] [int] NULL
)
GO

DROP TABLE Stage_Producto

SELECT
[ProductID],
CAST([ProductName] AS VARCHAR(40)) AS [ProductName],
CAST([UnitPrice] AS DECIMAL(15,2)) AS [UnitPrice],
[CategoryName],
CAST([CompanyName] AS VARCHAR(40)) AS [CompanyName]
FROM Load_Northwind.dbo.Products

SELECT * FROM Stage_Producto
TRUNCATE TABLE Stage_Producto

CREATE TABLE [dbo].[Stage_Cliente](
    [Cliente_Codigo] [char](5) NOT NULL,
    [Cliente_Nombre] [varchar](40) NOT NULL,
    [Cliente_Compania] [varchar](40) NULL,
    [Cliente_Direccion] [varchar](60) NULL,
    [Cliente_Ciudad] [varchar](15) NULL,
    [Cliente_Region] [varchar](15) NULL,
    [Cliente_Pais] [varchar](15) NULL,
    [Cliente_Postal] [varchar](10) NULL,
    [ETLLoad] [datetime] NULL,
    [ETLExecution] [int] NULL
)

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


CREATE TABLE [dbo].[Stage_Ventas](
    [Cliente_Codigo] [char](5) NOT NULL,
    [Empleado_Codigo] [int] NOT NULL,
    [Producto_Codigo] [int] NOT NULL,
    [Ventas_OrderDate] [datetime] NOT NULL,
    [Ventas_NOrden] [int] NOT NULL,
    [Ventas_Monto] [decimal](15, 2) NOT NULL,
    [Ventas_Unidades] [int] NOT NULL,
    [Ventas_PUnitario] [decimal](15, 2) NOT NULL,
    [Ventas_Descuento] [decimal](15, 2) NOT NULL,
    [ETLLoad] [datetime] NULL,
    [ETLExecution] [int] NULL
)
GO

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



IF OBJECT_ID('[Stage_Northwind].[dbo].[Stage_Ventas]', 'U') IS NOT NULL
    DROP TABLE [Stage_Northwind].[dbo].[Stage_Ventas];
GO

CREATE TABLE [Stage_Northwind].[dbo].[Stage_Ventas](
    [Cliente_Codigo] [char](5)		NOT NULL,
    [Empleado_Codigo] [int]			NOT NULL,
    [Producto_Codigo] [int]			NOT NULL,
	[Transportista_Codigo] INT      NOT NULL,
    [Ventas_OrderDate] [datetime]	NOT NULL,
    [Ventas_NOrden] [int]			NOT NULL,
    [Ventas_Monto] [decimal](15, 2) NOT NULL,
    [Ventas_Unidades] [int] NOT NULL,
    [Ventas_PUnitario] [decimal](15, 2) NOT NULL,
    [Ventas_Descuento] [decimal](15, 2) NOT NULL,
    [ETLLoad] [datetime] NULL,
    [ETLExecution] [int] NULL
)
GO

SELECT
    CAST(o.CustomerID AS CHAR(5))                    AS Cliente_Codigo,  
    o.EmployeeID                                     AS Empleado_Codigo,
    od.ProductID                                     AS Producto_Codigo,
	o.ShipVia										 AS Transportista_Codigo,
    o.OrderDate                                      AS Ventas_OrderDate,
    od.OrderID                                       AS Ventas_NOrden,
    CAST(od.Quantity AS INT)                         AS Ventas_Unidades,
    CAST(od.UnitPrice AS DECIMAL(15,2))              AS Ventas_PUnitario,
    CAST(od.Discount AS DECIMAL(15,2))               AS Ventas_Descuento,
    CAST(od.UnitPrice * od.Quantity * (1 - od.Discount) AS DECIMAL(15,2)) AS Ventas_Monto
FROM [Load_Northwind].[dbo].[Orders]        AS o
JOIN [Load_Northwind].[dbo].[Order Details] AS od
ON o.OrderID = od.OrderID
WHERE o.ETLExecution = ?;


CREATE TABLE [dbo].[Stage_Transportista](
    [Transportista_codigo] [int] NOT NULL,
    [Transportista_nombre] [nvarchar](40) NOT NULL,
    [ETLLoad] [datetime] NULL,
    [ETLExecution] [int] NULL
);

SELECT 
[ShipperID],
[CompanyName]
FROM Load_Northwind.dbo.Shippers
