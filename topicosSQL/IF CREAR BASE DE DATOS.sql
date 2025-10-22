IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'miniBD')
BEGIN
	CREATE DATABASE miniBD
	COLLATE Latin1_General_100_CI_AS_SC_UTF8;
END
GO

SELECT name FROM sys.databases where name = N'miniBD'

USE miniBD
go


-- Creacion de tablas

IF OBJECT_ID ('clientes', 'U') IS NOT NULL DROP TABLE clientes;

CREATE TABLE clientes(
	Idcliente INT not null,
	Nombre NVARCHAR(100),
	Edad INT,
	Ciudad NVARCHAR(100),
	CONSTRAINT pk_clientes
	PRIMARY KEY (idcliente)
);

GO

IF OBJECT_ID ('productos', 'U') IS NOT NULL DROP TABLE productos;

CREATE TABLE productos(
	Idproducto INT primary key,
	NombreProducto NVARCHAR(200),
	Categoria NVARCHAR(200),
	Precio DECIMAL(12,2)
);
GO