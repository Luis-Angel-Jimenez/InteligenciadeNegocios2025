USE [NORTHWND]
GO

/****** Object:  Table [dbo].[Order Details]    Script Date: 17/11/2025 18:35:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Order Details](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
	[ETLLoad] DATETIME,
	[ETLExecution] INT
 )
