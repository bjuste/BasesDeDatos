CREATE TABLE DIRECTOR(
    DNI_DIRECTOR VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30)NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    CONSTRAINT PK_DIRECTOR PRIMARY KEY(DNI_DIRECTOR)
);

CREATE TABLE SUPERMERCADO(
    CODSUP NUMBER(4),
    DIRECCION VARCHAR(30) NOT NULL,
    SUPERFICIE NUMBER(4) NOT NULL,
    ESALQUILER CHAR(1) NOT NULL,
    FECHA DATE NOT NULL,
    DNI_DIRECTOR VARCHAR(9) NOT NULL,
    CONSTRAINT PK_SUPERMERCADO PRIMARY KEY(CODSUP),
    CONSTRAINT FK_SUPERMERCADO FOREIGN KEY(DNI_DIRECTOR) REFERENCES DIRECTOR(DNI_DIRECTOR),
    CONSTRAINT CK_SUPERMERCADO CHECK(SUPERFICIE>0 AND ESALQUILER IN('S','s','N','n'))
);

CREATE TABLE VENDEDOR(
    DNI_VENDEDOR VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30)NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    CODSUP NUMBER(4) NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY(DNI_VENDEDOR),
    CONSTRAINT FK_VENDEDOR FOREIGN KEY(CODSUP) REFERENCES SUPERMERCADO(CODSUP) ON DELETE CASCADE
);

CREATE TABLE CLIENTE(
    DNI_CLIENTE VARCHAR(9),
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30),
    DOMICILIO VARCHAR(30)NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30),
    CODSUP NUMBER(4) NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY(DNI_CLIENTE)
);

CREATE TABLE VENTA(
    CODVENTA NUMBER(4),
    FECHA DATE,
    DNI_VENDEDOR VARCHAR(9),
    DNI_CLIENTE VARHCAR(9),
    CONSTRAINT PK_VENTA PRIMARY KEY(CODVENTA),
    CONSTRAINT FK_VENDEDOR FOREIGN KEY(DNI_VENDEDOR) REFERENCES VENDEDOR(DNI_VENDEDOR),
    CONSTRAINT FK_CLIENTE FOREIGN KEY(DNI_CLIENTE) REFERENCES CLIENTE(DNI_CLIENTE) ON DELETE CASCADE
);

CREATE TABLE FAMILIA(
    COD_FAMILIA NUMBER(4),
    CONSTRAINT PK_FAMILIA PRIMARY KEY(COD_FAMILIA)
);

CREATE TABLE GENERO(
    COD_GENERO NUMBER(4),
    CONSTRAINT PK_GENERO PRIMARY KEY(COD_GENERO)
);

CREATE TABLE PRODUCTO(
    COD_PRODUCTO NUMBER(4),
    DESCRIPCION VARCHAR(30) NOT NULL,
    DESCUENTO NUMBER(4,2) DEFAULT 0,
    IVA NUMBER(2) NOT NULL,
    COD_FAMILIA NUMBER(4) NOT NULL,
    COD_GENERO NUMBER(4) NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY(COD_PRODUCTO),
    CONSTRAINT FK_GENERO FOREIGN KEY(COD_GENERO) REFERENCES GENERO(COD_GENERO),
    CONSTRAINT FK_FAMILIA FOREIGN KEY(COD_FAMILIA) REFERENCES FAMILIA(COD_FAMILIA),
    CONSTRAINT CK_DESCUENTO CHECK(DESCUENTO > 0 AND DECUENTO < 100),
    CONSTRAINT CK_IVA CHECK(IVA IN (4,10,21))
);

CREATE TABLE LINEAVENTA(
    NUMLINEA NUMBER(4),
    COD_VENTA NUMBER(4),
    CANTIDAD NUMBER(4),
    CONSTRAINT PK_LINEAVENTA PRIMARY KEY(NUMLINEA, COD_VENTA),
    CONSTRAINT FK_VENTA FOREIGN KEY (COD_VENTA) REFERENCES VENTA(COD_VENTA),
    CONSTRAINT CK_CANTIDAD CHECK(CANTIDAD BETWEEN 1 AND 249)
);

CREATE TABLE DEVOLUCION(
    COD_VENTA NUMBER(4),
    NUMLINEA NUMBER(4),
    FECHA DATE,
    ESTADO CHAR(1) NOT NULL,
    TIPO_DEV VARCHAR(30) NOT NULL,
    CONSTRAINT PK_DEVOLUCION PRIMARY KEY(COD_VENTA, NUMLINEA, FECHA),
    CONSTRAINT FK_VENTA FOREIGN KEY(COD_VENTA, NUMLINEA) REFERENCES LINEAVENTA(NUMLINEA, COD_VENTA),
    CONSTRAINT CK_ESTADO CHECK(ESTADO IN ('B','M','F')),
    CONSTRAINT CK_TIPODEV CHECK(TIPO_DEV BETWEEN 1 AND 5)
);

CREATE TABLE PRECIO(
    COD_PROD NUMBER(4),
    FECHA DATE,
    PRECIO NUMBER(6,2) NOT NULL,
    CONSTRAINT PK_PRECIO PRIMARY KEY(COD_PROD),
    CONSTRAINT FK_PRODUCTO FOREIGN KEY(COD_PROD) REFERENCES PRODUCTO(COD_PRODUCTO),
    CONSTRAINT CK_PRECIO CHECK (PRECIO BETWEEN 0.01 AND 9999.99)
);


