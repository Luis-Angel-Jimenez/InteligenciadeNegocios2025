CREATE TABLE [Customers](
	   [CustomerID] INT NOT NULL
      ,[CompanyName] NVARCHAR(40) NOT NULL
      ,[ContactName] NVARCHAR(30) NULL
      ,[ContactTitle] NVARCHAR(30) NULL
      ,[Address] NVARCHAR (60) NULL
      ,[City] NVARCHAR (15) NULL
      ,[Region] NVARCHAR (15) NULL
      ,[PostalCode] NVARCHAR (10) NULL
      ,[Country] NVARCHAR (15)NULL
      ,[Phone] NVARCHAR(24) NULL
      ,[Fax] NVARCHAR (24) NULL
	  ,[ETLLoad] DATETIME 
	  ,[ETLExecution] INT
)

SELECT * FROM Customers
SELECT 
[CustomerID],
[CompanyName],
[ContactName],
[ContactTitle],
[Address],
[City],
ISNULL([Region], 'SR') AS [Region],
[PostalCode],
Country,
[Phone],
ISNULL([Fax], 'SF') AS [Fax]
FROM NORTHWND.dbo.Customers

TRUNCATE TABLE Customers