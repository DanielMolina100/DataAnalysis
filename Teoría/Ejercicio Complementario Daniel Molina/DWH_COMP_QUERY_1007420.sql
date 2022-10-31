/* COMPLEMENTO PARCIAL 1

DANIEL MOLINA 1007420

ANÁLISIS DE DATOS */

/*CREAMOS LA BD EN LA CUAL ES EL COMPLEMENTO DATA WHAREHOUSE DEL PARCIAL 1*/
SET NOCOUNT ON
GO
USE master
GO
if exists (select * from sysdatabases where name='DWH1_COMP_1007420')
		drop database LosMejoresDWH
go

DECLARE @device_directory NVARCHAR(520)
SELECT @device_directory = SUBSTRING(filename, 1, CHARINDEX(N'master.mdf', LOWER(filename)) - 1)
FROM master.dbo.sysaltfiles WHERE dbid = 1 AND fileid = 1

EXECUTE (N'CREATE DATABASE DWH1_COMP_1007420
  ON PRIMARY (NAME = N''DWH1_COMP_1007420'', FILENAME = N''' + @device_directory + N'DWH1_COMP_1007420.mdf'')
  LOG ON (NAME = N''DWH1_COMP_1007420_log'',  FILENAME = N''' + @device_directory + N'DWH1_COMP_1007420.ldf'')')
go

set quoted_identifier on
GO

/* DIMENSIONES */

/*CREAMOS LAS DIMENSIONES Y EN LA QUE SE UTILIZAN PARA TOMAR LOS DATOS DE LA TABLA DE NORTHWIND*/

/*DBO  Y FACT  son los esquemas creados en la BD*/
if OBJECT_ID('DWH1_COMP_1007420..Dim_Clientes') is not null drop table DWH1_COMP_1007420.dbo.Dim_Clientes

CREATE TABLE DWH1_COMP_1007420.dbo.[Dim_Clientes](
	[Id_Cliente] int identity(1,1) not null,
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL
)
GO


if OBJECT_ID('DWH1_COMP_1007420..Dim_Productos') is not null drop table DWH1_COMP_1007420.dbo.Dim_Productos

CREATE TABLE DWH1_COMP_1007420.[dbo].[Dim_Productos](
	[Id_Producto] int identity(1,1) not null,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL
) 
GO

/* HACEMOS LAS CONEXIONES QUE SE NECESITAN EN LA BD 
 Y CON ELLO YA HACER EL DWH CON LAS DIMESIONES Y HECHOS */

ALTER TABLE DWH1_COMP_1007420.dbo.Dim_Clientes ADD PRIMARY KEY (CustomerID)
ALTER TABLE DWH1_COMP_1007420.dbo.Dim_Productos ADD PRIMARY KEY (ProductID);
ALTER TABLE DWH1_COMP_1007420.dbo.Dim_Empleado  ADD PRIMARY KEY (EmployeeID);

ALTER TABLE DWH1_COMP_1007420.dbo.fact_Invoices ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES DWH1_COMP_1007420.dbo.Dim_Clientes (CustomerID)
ALTER TABLE DWH1_COMP_1007420.dbo.fact_Invoices add CONSTRAINT FK_ProductID  FOREIGN KEY (ProductID) REFERENCES DWH1_COMP_1007420.dbo.Dim_Productos (ProductID)
ALTER TABLE DWH1_COMP_1007420.dbo.fact_Invoices add CONSTRAINT FK_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES DWH1_COMP_1007420.[dbo].[Dim_Empleado] (EmployeeID)



if OBJECT_ID('DWH1_COMP_1007420..Dim_Empleado') is not null drop table DWH_COMP_1007420.dbo.Dim_Empleado

CREATE TABLE DWH1_COMP_1007420.[dbo].[Dim_Empleado]( 
    [Id_Empleado] int identity(1,1) not null,
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL
) 
GO


if OBJECT_ID('DWH1_COMP_1007420..fact_Invoices') is not null drop table DWH1_COMP_1007420.dbo.fact_Invoices

CREATE TABLE  DWH1_COMP_1007420.[dbo].fact_Invoices(
	InvoiceID int identity(1,1) not null,
	CustomerID [nchar](5) not null,
	ProductID [INT] not null,
	EmployeeID [INT] not null,
	Quantity [INT] not null,
	UnitPrice [MONEY] null,
	OrderDate [datetime] not null, 
	CreatedDate date default getdate()
)
GO


/*  MANDAMOS A LLAMAR LOS DATOS DE LA BD NORTHWIND */


/*Tabla de clientes*/
insert into DWH1_COMP_1007420.dbo.Dim_Clientes
select * from Northwind.dbo.Customers

/*Tabla de productos*/
insert into DWH1_COMP_1007420.dbo.Dim_Productos
select *  from Northwind.dbo.Products

/*Tabla de Empleados*/
insert into DWH1_COMP_1007420.dbo.Dim_Empleado
Select 	E.Employeeid,E.Firstname, E.LastName
From Northwind.Dbo.Employees As E

/*Tabla de hechos*/
insert into DWH1_COMP_1007420.dbo.fact_Invoices
select inv.CustomerID,Inv.ProductID,O.EmployeeID,Inv.Quantity,inv.UnitPrice,inv.OrderDate,GETDATE()
from Northwind.dbo.Invoices as INV
left join Northwind.dbo.Orders AS O
on O.OrderID = INV.OrderID

--SE MUESTRA LA TABLA DE FECHA PERO NO SE TOMARA EN CUENTA EN LA DWH
CREATE TABLE DWH1_COMP_1007420.dbo.Dim_Fecha(
	[CalendarDate] [DATE] NOT NULL, 
	[dayOfWeekNum] [INT] NOT NULL,  
	[dayOfWeekName] [nvarchar](15) NOT NULL, 
	[dayOfCalendarMonthNum] [nvarchar](15) NOT NULL, 
	[dayOfCalendarYearNum] [nvarchar](15) NOT NULL, 
	[CalendarWeekNum] [nvarchar](15) NOT NULL,  
	[calendarMonthNum] [nvarchar](15) NOT NULL,
	[calendarMonthName] [nvarchar](15) NOT NULL,
	[calendarQuarterNum] [nvarchar](15) NOT NULL, 
	[calendarYearNum] [nvarchar](15) NOT NULL 
)
GO

CREATE OR ALTER PROCEDURE USP_FillDimDate @CurrentDate DATE = '1996-01-01', 
@EndDate     DATE = '1998-12-31'
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM DWH1_COMP_1007420.dbo.Dim_Fecha;

	WHILE @CurrentDate < @EndDate
	BEGIN
		INSERT INTO DWH1_COMP_1007420.dbo.Dim_Fecha
		(					 
		 [CalendarDate]--
		,[dayOfWeekNum]
		,[dayOfWeekName]--
		,[dayOfCalendarMonthNum]--
		,[dayOfCalendarYearNum]--
		,[CalendarWeekNum]--
		,[calendarMonthNum]--
		,[calendarMonthName]--
		,[calendarYearNum]-- 	
		,[calendarQuarterNum]--
						
		)
		SELECT 
			[CalendarDate] = @CurrentDate,
			[dayOfWeekNum] = DATEPART(dw,@CurrentDate), 
			[dayOfWeekName] = DATENAME(dw, @CurrentDate), 
			[dayOfCalendarMonthNum] = DAY(@CurrentDate),
			[dayOfCalendarYearNum] = DATENAME(dy, @CurrentDate), 
			[CalendarWeekNum] = DATEPART(wk, @CurrentDate), 
			[calendarMonthNum] = MONTH(@CurrentDate),
			[calendarMonthName] = FORMAT(@CurrentDate, 'MMMM'),
			[calendarYearNum] = YEAR(@CurrentDate), 
			[calendarQuarterNum] = CASE
					WHEN DATENAME(qq, @CurrentDate) = 1
					THEN 'First'
					WHEN DATENAME(qq, @CurrentDate) = 2
					THEN 'second'
				WHEN DATENAME(qq, @CurrentDate) = 3
				THEN 'third'
				WHEN DATENAME(qq, @CurrentDate) = 4
					THEN 'fourth'
							END; 					  
		SET @CurrentDate = DATEADD(DD, 1, @CurrentDate);
	END;
END;
go

EXEC USP_FillDimDate
