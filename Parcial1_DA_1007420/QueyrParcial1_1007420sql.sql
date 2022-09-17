---Jose Daniel Molina Galindo 1007420

---QUERY PARA CREAR EL DWH

----:D

						
USE master GO
if exists (select * from sysdatabases where name='DW_Parcial1_DanielMolina')
drop database DW_Parcial1_DanielMolina
go
create database DW_Parcial1_DanielMolina;
go
USE DW_Parcial1_DanielMolina;
GO


---Se crea las tablas para la administracion de los datos para el datawarehouse

---hechos
IF OBJECT_ID('DW_Parcial1_DanielMolina..H_Sales') IS NOT NULL DROP TABLE DW_Parcial1_DanielMolina.[dbo].[H_Sales]
CREATE TABLE DW_Parcial1_DanielMolina.[dbo].[H_Sales](
	[ID] [INT] IDENTITY (1,1),
	[OrderDate] [date] NULL,
	[Month_sales] [int] NULL,
	[Year_sales] [int] NULL,
	[Day_sales] [int] NULL,
	[ProductID] [int] NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[CategoryID] [int] NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
	[Sales_dolar] [real] NULL
)
GO



IF OBJECT_ID('DW_Parcial1_DanielMolina..Dim_Customers') IS NOT NULL DROP TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Customers]
CREATE TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Customers](
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


IF OBJECT_ID('DW_Parcial1_DanielMolina..Dim_Categories') IS NOT NULL DROP TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Categories]
CREATE TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Categories](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[Description] [ntext] NULL,
	[Picture] [image] NULL
)
GO

IF OBJECT_ID('DW_Parcial1_DanielMolina..Dim_Products') IS NOT NULL DROP TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Products]
CREATE TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Products](
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

IF OBJECT_ID('DW_Parcial1_DanielMolina..Dim_Fecha') IS NOT NULL DROP TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Fecha]
CREATE TABLE DW_Parcial1_DanielMolina.[dbo].[Dim_Fecha](
	[CalendarDate] [date] NOT NULL,
	[dayOfCalendarMonthNum] [int] NULL,
	[CalendarWeekNum] [int] NULL,
	[dayOfWeekNum] [int] NULL,
	[dayOfCalendarYearNum] [int] NULL,
	[calendarMonthNum] [int] NULL,
	[calendarYearNum] [int] NULL,
	[calendarQuerterNum] [int] NULL,
	[dayOfWeekName] [nvarchar](30) NULL,
	[calendarMonthName] [nvarchar](30) NULL
) ON [PRIMARY]
GO


ALTER TABLE DW_Parcial1_DanielMolina.dbo.Dim_Categories ADD PRIMARY KEY (CategoryID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.Dim_Customers ADD PRIMARY KEY (CustomerID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.Dim_Products ADD PRIMARY KEY (ProductID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.Dim_Fecha ADD PRIMARY KEY (CalendarDate);

drop table DW_Parcial1_DanielMolina.dbo.H_Sales
ALTER TABLE DW_Parcial1_DanielMolina.dbo.H_Sales ADD CONSTRAINT FK_CategoryID FOREIGN KEY (CategoryID) REFERENCES DW_Parcial1_DanielMolina.dbo.Dim_Categories (CategoryID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.H_Sales ADD CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES DW_Parcial1_DanielMolina.dbo.Dim_Customers (CustomerID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.H_Sales ADD CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES DW_Parcial1_DanielMolina.dbo.Dim_Products (ProductID);
ALTER TABLE DW_Parcial1_DanielMolina.dbo.H_Sales ADD CONSTRAINT FK_Date FOREIGN KEY (OrderDate) REFERENCES DW_Parcial1_DanielMolina.dbo.Dim_Fecha (CalendarDate);

GO



DELETE FROM DW_Parcial1_DanielMolina.dbo.Dim_Customers;
INSERT INTO DW_Parcial1_DanielMolina.dbo.Dim_Customers
SELECT * 
FROM Northwind.dbo.Customers;
GO



DELETE FROM DW_Parcial1_DanielMolina.dbo.Dim_Products;
INSERT INTO DW_Parcial1_DanielMolina.dbo.Dim_Products
SELECT * 
FROM Northwind.dbo.Products;
GO


DELETE FROM DW_Parcial1_DanielMolina.dbo.Dim_Categories;
INSERT INTO DW_Parcial1_DanielMolina.dbo.Dim_Categories
SELECT 
* 
FROM Northwind.dbo.Categories;
GO

DELETE FROM DW_Parcial1_DanielMolina.dbo.H_Sales;
INSERT INTO DW_Parcial1_DanielMolina.dbo.H_Sales
SELECT
	CAST(b.OrderDate AS DATE) AS OrderDate,
	MONTH(b.OrderDate) AS Month_sales,
	YEAR(b.OrderDate) AS Year_sales,
	DAY(b.OrderDate) AS Day_sales,
	a.ProductID,
	b.CustomerID,
	b.EmployeeID,
	c.CategoryID,
	a.UnitPrice,
	a.Quantity,
	a.Discount,
	(a.UnitPrice * a.Quantity) - a.Discount AS Sales_dolar
FROM Northwind.dbo.[Order Details] AS a
INNER JOIN Northwind.dbo.[Orders] AS b
ON a.OrderID = b.OrderID
INNER JOIN Northwind.dbo.Products AS c
ON a.ProductID = c.ProductID;

GO
