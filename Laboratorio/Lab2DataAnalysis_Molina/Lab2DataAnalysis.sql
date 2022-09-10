Create table Skun(
id_sku int not null,
costo varchar(10),
cod_barra varchar(10),
precio varchar(10),
CONSTRAINT PK_IDSKU PRIMARY KEY(id_sku),
);

Create table tienda(
id_sku int not null,
id_tienda int not null,
alimento varchar(20),
CONSTRAINT PK_tienda PRIMARY KEY (id_tienda),
CONSTRAINT FK_tiendas FOREIGN KEY (id_sku) references Skun(id_sku)
);

Create table ubicacion(
id_tienda int not null,
id_ubicacion int not null,
estado varchar(100),
nombre varchar(50),
zona varchar(50),
CONSTRAINT PK_ubicacion PRIMARY KEY (id_ubicacion),
CONSTRAINT FK_Ubi FOREIGN KEY (id_tienda) references tienda(id_tienda)
);


Create table promocion(
id_sku int not null,
id_promocion int not null,
precio varchar(50),
descuento varchar(50),
anuncio varchar(50),
cantidad int,
cupon varchar(50),
CONSTRAINT PK_promo PRIMARY KEY (id_promocion),
CONSTRAINT FK_promo FOREIGN KEY (id_sku) references Skun(id_sku)
);

Create table proveedor(
id_sku int not null,
id_proveedor int not null,
direccion varchar(50),
nombre varchar(50),
CONSTRAINT PK_pro PRIMARY KEY (id_proveedor),
CONSTRAINT FK_pro FOREIGN KEY (id_sku) references Skun(id_sku)
);

Create table informacion(
id_proveedor int not null,
id_info int not null,
fecha date,
CONSTRAINT PK_info PRIMARY KEY (id_info),
CONSTRAINT FK_info FOREIGN KEY (id_proveedor) references proveedor(id_proveedor)
);

Create table venta(
id_venta int not null,
id_sku int not null,
cantidad varchar(50),
CONSTRAINT PK_venta PRIMARY KEY (id_venta),
CONSTRAINT FK_venta FOREIGN KEY (id_sku) references Skun(id_sku)
);

Create table cliente(
id_venta int not null,
id_cliente int not null,
nombre varchar(50),
nit int,
apellido varchar(50),
CONSTRAINT PK_cliente PRIMARY KEY (id_cliente),
CONSTRAINT FK_cliente FOREIGN KEY (id_venta) references venta(id_venta)
);

--AGREGAR LOS DATOS EN LAS TABLAS