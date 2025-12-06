INSERT Datamart_Northwind.dbo.fact_sales (order_date_key, customer_key, product_key, employee_key, shipper_key,
order_number,order_qty, unit_price ,discount)
SELECT dd.date_key
      ,dc.customer_key
      ,dp.product_key
      ,de.employee_id
      ,ds.shipper_key
      ,SV.[Ventas_NOrden]
      ,SV.[Ventas_Unidades]
      ,SV.[Ventas_PUnitario]
      ,SV.[Ventas_Descuento]
  FROM [STAGE_NORTHWIND].[dbo].[Stage_Ventas] AS sv
    JOIN
        [Datamart_Northwind].dbo.dim_customer AS dc
        ON sv.Cliente_Codigo = dc.customerid_nk
    JOIN
        Datamart_Northwind.[dbo].[dim_employee] AS de
        ON sv.Empleado_Codigo = de.employeeid_nk
    JOIN
        Datamart_Northwind.[dbo].[dim_product] AS dp
        ON SV.Producto_Codigo = dp.productid_nk

    JOIN
        [Datamart_Northwind].[dbo].[dim_date] as dd
        ON dd.date = sv.Ventas_OrderDate
    JOIN Datamart_Northwind.dbo.dim_shipper as ds
    on ds.shipperid_nk = sv.Transportista_Codigo
    WHERE sv.Ventas_OrderDate >COALESCE(
      (SELECT MAX(d.date)
       FROM Datamart_Northwind.dbo.fact_sales fs
       JOIN Datamart_Northwind.dbo.dim_date d ON fs.order_date_key = d.date_key), '19000101')
ORDER BY dc.customer_key, de.employee_id, dp.product_key,ds.shipper_key, dd.date_key,sv.Ventas_NOrden





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

	SELECT
[ProductID],
CAST([ProductName] AS VARCHAR(40)) AS [ProductName],
CAST([UnitPrice] AS DECIMAL(15,2)) AS [UnitPrice],
CAST([CategoryName] AS VARCHAR(15)) AS [CategoryName],
CAST([CompanyName] AS VARCHAR(40)) AS [CompanyName]
FROM Load_Northwind.dbo.Products

SELECT
[ProductID],
CAST([ProductName] AS VARCHAR(40)) AS [ProductName],
CAST([UnitPrice] AS DECIMAL(15,2)) AS [UnitPrice],
CAST([CategoryName] AS VARCHAR(15)) AS [CategoryName],
CAST([CompanyName] AS VARCHAR(40)) AS [CompanyName]
FROM Load_Northwind.dbo.Products
WHERE ETLExecution = ?;

SELECT 
      dd.date_key                         AS order_date_key
    , dc.customer_key
    , dp.product_key
    , de.employee_id
    , ds.shipper_key
    , sv.[Ventas_NOrden]
    , sv.[Ventas_Unidades]
    , sv.[Ventas_PUnitario]
    , sv.[Ventas_Descuento]
FROM [STAGE_NORTHWIND].[dbo].[Stage_Ventas] AS sv
JOIN [Datamart_Northwind].dbo.dim_customer AS dc
    ON  sv.Cliente_Codigo      = dc.customerid_nk
    AND sv.Ventas_OrderDate    >= dc.start_date
    AND sv.Ventas_OrderDate    <  ISNULL(dc.end_date, '9999-12-31')   -- SCD2: versión vigente en la fecha de la venta
JOIN Datamart_Northwind.[dbo].[dim_employee] AS de
    ON sv.Empleado_Codigo      = de.employeeid_nk
JOIN Datamart_Northwind.[dbo].[dim_product] AS dp
    ON sv.Producto_Codigo      = dp.productid_nk
JOIN [Datamart_Northwind].[dbo].[dim_date] AS dd
    ON dd.[date]               = sv.Ventas_OrderDate
JOIN Datamart_Northwind.dbo.dim_shipper AS ds
    ON ds.shipperid_nk         = sv.Transportista_codigo
WHERE sv.Ventas_OrderDate >
      COALESCE(
          (SELECT MAX(d.[date])
           FROM Datamart_Northwind.dbo.fact_sales fs
           JOIN Datamart_Northwind.dbo.dim_date d 
               ON fs.order_date_key = d.date_key),
           '19000101'
      )
ORDER BY 
      dc.customer_key
    , de.employee_id
    , dp.product_key
    , ds.shipper_key
    , dd.date_key
    , sv.Ventas_NOrden;

	UPDATE dc
SET start_date = '19960704'
FROM Datamart_Northwind.dbo.dim_customer dc
WHERE dc.start_date > '19960704'
  AND dc.end_date IS NULL;

  SELECT * FROM Datamart_Northwind.DBO.fact_sales
WHERE order_number = '12078'
  SELECT * FROM Datamart_Northwind.DBO.fact_sales
WHERE order_number in('12079','12078')



 SELECT sum(extended_amount) FROM Datamart_Northwind.DBO.fact_sales
WHERE order_number = '12079'




SELECT * FROM Stage_Northwind.dbo.Stage_Ventas
WHERE Ventas_NOrden in('12079','12078')
SELECT * FROM Datamart_Northwind.DBO.dim_customer
where customerid_nk = 'AFORE'

DELETE FROM Datamart_Northwind.dbo.fact_sales;
DBCC CHECKIDENT ('Datamart_Northwind.DBO.fact_sales', RESEED, 0);


DELETE FROM Datamart_Northwind.dbo.dim_product;
DBCC CHECKIDENT ('Datamart_Northwind.DBO.dim_product', RESEED, 0);


SELECT 
      dd.date_key                         AS order_date_key
    , dc.customer_key
    , dp.product_key
    , de.employee_id
    , ds.shipper_key
    , sv.[Ventas_NOrden]
    , sv.[Ventas_Unidades]
    , sv.[Ventas_PUnitario]
    , sv.[Ventas_Descuento]
FROM [STAGE_NORTHWIND].[dbo].[Stage_Ventas] AS sv
JOIN [Datamart_Northwind].dbo.dim_customer AS dc
    ON  sv.Cliente_Codigo      = dc.customerid_nk
    AND sv.Ventas_OrderDate    >= dc.start_date
    AND sv.Ventas_OrderDate    <  ISNULL(dc.end_date, '9999-12-31')   -- SCD2: versión vigente en la fecha de la venta
JOIN Datamart_Northwind.[dbo].[dim_employee] AS de
    ON sv.Empleado_Codigo      = de.employeeid_nk
JOIN Datamart_Northwind.[dbo].[dim_product] AS dp
    ON sv.Producto_Codigo      = dp.productid_nk
JOIN [Datamart_Northwind].[dbo].[dim_date] AS dd
    ON dd.[date]               = sv.Ventas_OrderDate
JOIN Datamart_Northwind.dbo.dim_shipper AS ds
    ON ds.shipperid_nk         = sv.Transportista_codigo
WHERE sv.Ventas_OrderDate >
      COALESCE(
          (SELECT MAX(d.[date])
           FROM Datamart_Northwind.dbo.fact_sales fs
           JOIN Datamart_Northwind.dbo.dim_date d 
               ON fs.order_date_key = d.date_key),
           '19000101'
      )
ORDER BY 
      dc.customer_key
    , de.employee_id
    , dp.product_key
    , ds.shipper_key
    , dd.date_key
    , sv.Ventas_NOrden;