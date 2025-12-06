--DIM_PRODUCT

--Origen de Datos [Stage_Northwind].[dbo].[Stage_Producto]

SELECT [Producto_Codigo]
      ,CAST([Producto_Nombre] as nvarchar(40)) AS [Producto_Nombre]
      ,CAST([CategoriaProducto_Codigo] AS nvarchar (15)) AS [Categoria_nombre]
      ,CAST([ProveedorNombre] AS nvarchar (40)) AS [ProveedorNombre]
      ,[ETLLoad]
      ,[ETLExecution]
  FROM [Stage_Northwind].[dbo].[Stage_Producto]


  	CREATE TABLE [Stage_Northwind].[dbo].[Dim_Producto_Mod](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[Producto_Codigo] [int] NOT NULL,
	[Producto_Nombre] [nvarchar](80) NOT NULL,
	[Producto_Nombre_Categoria] [nvarchar](15) NULL,
	[ProveedorNombre] [nvarchar](40) NULL,
	[ETLLoad] [datetime] NULL
)

SELECT
CAST([Cliente_Codigo] AS NVARCHAR(10)),
CAST([Cliente_Compania] AS NVARCHAR(40)),
CAST([Cliente_Nombre] AS NVARCHAR(30)),
CAST([Cliente_Direccion] AS NVARCHAR(60)),
CAST([Cliente_Ciudad] AS NVARCHAR(15)),
CAST([Cliente_Region] AS NVARCHAR(15)),
CAST([Cliente_Postal] AS NVARCHAR(10)),
CAST([Cliente_Pais] AS NVARCHAR(15))
FROM Stage_Northwind.DBO.Stage_Cliente
GO

SELECT * FROM Datamart_Northwind.dbo.dim_product
SELECT * FROM NORTHWIND_METADATA.dbo.ETLExecution
TRUNCATE TABLE NORTHWIND_METADATA.dbo.ETLExecution

DELETE Datamart_Northwind.dbo.dim_product;
DBCC CHECKIDENT ('Datamart_Northwind.dbo.dim_product', RESEED, 0);