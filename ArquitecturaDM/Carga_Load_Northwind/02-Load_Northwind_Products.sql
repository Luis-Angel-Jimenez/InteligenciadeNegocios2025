
-
- CREAR LA TABLA PRODUCTS

CREATE TABLE [dbo].[Products](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[CompanyName] [nvarchar](40) NULL,
	[CategoryName] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
	[ETLLoad] DATETIME,
	[ETLExecution] INT 
);
 --CONSULTA DE ORIGEN 
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

	DROP TABLE Products

	SELECT MAX(o.ETLExecution)
FROM 
    Load_Northwind.dbo.Orders o
INNER JOIN 
    Load_Northwind.dbo.[Order Details] od
    ON o.OrderID = od.OrderID