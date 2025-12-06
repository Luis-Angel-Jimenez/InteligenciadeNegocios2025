	USE Stage_Northwind
	
	SELECT 
	se.Empleado_Codigo,
	CAST(se.Empleado_NombreCompleto AS NVARCHAR (61)) AS Empleado_NombreCompleto,
	CAST(se.Empleado_Region AS NVARCHAR (15)) AS Empleado_Region,
	CAST(se.Empleado_Ciudad AS NVARCHAR (15)) AS Empleado_Ciudad,
	CAST(se.Empleado_Pais AS NVARCHAR (15)) AS Empleado_Pais
	FROM Stage_Northwind.dbo.Stage_Empleado as se


	CREATE TABLE [dbo].[Dim_Empleado_Mod](
	[IDEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[Empleado_Codigo] [int] NOT NULL,
	[Empleado_NombreCompleto] [nvarchar](70) NOT NULL,
	[Empleado_Ciudad] [nvarchar](50) NULL,
	[Empleado_Region] [nvarchar](50) NULL,
	[Empleado_Pais] [nvarchar](50) NULL,
	[ETLLoad] [datetime] NULL
)


INSERT INTO [STAGE_NORTHWIND].[dbo].[Dim_Empleado_Mod]
([Empleado_Codigo], [Empleado_NombreCompleto], [Empleado_Ciudad], [Empleado_Region], [Empleado_Pais], [ETLLoad])
VALUES
(?, ?, ?, ?, ?, GETDATE())


UPDATE [Datamart_Northwind].[dbo].[Dim_Employee]
SET [Datamart_Northwind].[dbo].[Dim_Employee].full_name = S.Empleado_NombreCompleto,
	[Datamart_Northwind].[dbo].[Dim_Employee].Region = S.Empleado_Region,
	[Datamart_Northwind].[dbo].[Dim_Employee].City = S.Empleado_Ciudad,
	[Datamart_Northwind].[dbo].[Dim_Employee].Country = S.Empleado_Pais
FROM [Datamart_Northwind].[dbo].[Dim_Employee]
JOIN
	[Stage_Northwind].[dbo].[Stage_Empleado] AS S
ON [Datamart_Northwind].[dbo].[Dim_Employee].employee_id = S.Empleado_Codigo
WHERE [Datamart_Northwind].[dbo].[Dim_Employee].employeeid_nk = ?


SELECT * FROM Datamart_Northwind.dbo.dim_employee;
SELECT * FROM NORTHWIND_METADATA.dbo.ETLExecution;
SELECT * FROM Stage_Northwind.dbo.Dim_Empleado_Mod;


      (SELECT COALESCE( MAX(d.date), '19000101')
       FROM Datamart_Northwind.dbo.fact_sales fs
       JOIN Datamart_Northwind.dbo.dim_date d ON fs.order_date_key = d.date_key)

	   