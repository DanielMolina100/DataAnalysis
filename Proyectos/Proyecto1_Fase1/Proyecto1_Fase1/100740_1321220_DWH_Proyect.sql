/*
PROYECTO DE ANÁLISIS DE DATOS

DANIEL MOLINA 1007420
BENJAMIN IZQUIERDO 1321220

SUPERMERCADO

DATA WHAREHOUSE
*/

/*************************/
/* DIMENSIONES DE LA BD */
/***********************/

Create table Dim_client(

	client_idkey int IDENTITY (1,1) not null,
	CustomerName varchar(50) not null,
	StartDate date not null,
	EndDate date not null,
	created varchar(40) not null,
	CONSTRAINT PK_clientIDKEY PRIMARY KEY (client_idkey)
);
GO

Create table Dim_Product(
	
	product_idkey int IDENTITY (1,1) not null,
	category int not null,
	subcategory int not null,
	ProductName varchar(45) not null,
	startDate date not null,
	endDate date not null,
	created varchar(25) not null
	CONSTRAINT PK_productIDKEY PRIMARY KEY (product_idkey)
);
GO

Create table Dim_Date(

	date_idkey int IDENTITY(1,1) not null,
	DayOfWeek date not null,
	DayName date not null,
	FullDate date not null,
	Month date not null,
	Year int not null,
	Quarter varchar(25) not null,
	WeekdayFlag varchar(25) not null,
	WeerkNumLnYear varchar(25) not null,
	MonthNumOverall varchar(25) not null,
	FiscalMonth varchar(25) not null,
	FiscalQuarter varchar(25) not null,
	FiscalYear varchar(25) not null,
	CONSTRAINT PK_fechaIDKEY PRIMARY KEY (date_idkey)
);
GO

Create table Dim_Ubication(
	
	localization_idkey int IDENTITY(1,1) not null,
	Country varchar(100) not null,
	City varchar(25)not null,
	Region varchar(25) not null,
	State varchar(25) not null,
	zone varchar(25) not null,
	PostalCode int not null,
	CONSTRAINT PK_localIDKEY1 PRIMARY KEY (localization_idkey)
)
GO

/********************/
/* TABLA DE HECHOS */
/******************/

USE [1007420_1321220_DWH]

Create table FactDetails(
	
	FactDetailsKey int not null,
	client_idkey int not null,
	product_idkey int not null,
	date_idkey int not null,
	localization_idkey int not null,
	Sales varchar(25) not null,
	Discount varchar(25) not null,
	Profit varchar(25) not  null,
	CONSTRAINT PK_clientIDKEY1 FOREIGN KEY (client_idkey) REFERENCES Dim_client(client_idkey),
	CONSTRAINT PK_ProductDKEY1 FOREIGN KEY (product_idkey) REFERENCES Dim_Product(product_idkey),
	CONSTRAINT PK_dateIDKEY1 FOREIGN KEY (date_idkey) REFERENCES Dim_Date(date_idkey),
	CONSTRAINT PK_localiIDKEY1 FOREIGN KEY (localization_idkey) REFERENCES Dim_Ubication(localization_idkey)
);

/*************************************************/
/* CREACION DE LOS ESQUEMAS DIMENSIONES Y HECHOS */
/*************************************************/


USE [1007420_DWH];
GO
CREATE SCHEMA Fact1;
GO
CREATE SCHEMA Dim1;
GO

