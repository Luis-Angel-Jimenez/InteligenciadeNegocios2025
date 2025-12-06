USE [Load_Northwind]
GO

CREATE TABLE [dbo].[Shippers](
	[ShipperID] [int] NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
	[ETLLoad] DATETIME,
	[ETLExecution] INT

)
GO
DROP TABLE Shippers