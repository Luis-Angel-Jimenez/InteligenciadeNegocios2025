 SELECT 
 Transportista_codigo,
 Transportista_nombre,
 ETLLoad,
 ETLExecution
 FROM Stage_Northwind.dbo.Stage_Transportista

  CREATE TABLE [STAGE_NORTHWIND].[dbo].[Dim_Shipper_Mod](
	[TransportistaID] INT IDENTITY(1,1) NOT NULL,
	[Transportista_Codigo] INT NOT NULL,
	[Transportista_Nombre] NVARCHAR(40) NOT NULL,
	[ETLLoad] DATETIME
)
GO

SELECT * FROM NORTHWIND_METADATA.dbo.ETLExecution

INSERT INTO [STAGE_NORTHWIND].[dbo].[Dim_Shipper_Mod]
(Transportista_Codigo,Transportista_Nombre, [ETLLoad])
VALUES (?, ?, GETDATE())




