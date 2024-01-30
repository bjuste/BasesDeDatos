CREATE TABLE PRODUCTO(
    CODPRODUCTO NUMBER(5) NOT NULL,
    NOMBRE VARCHAR2(40) NOT NULL,
    TIPO VARCHAR2(2) NOT NULL,
    PRECIOCOSTE NUMBER(5,2) NOT NULL,
    PRECIOVENTA NUMBER(5,2) NOT NULL,
    IVA NUMBER(2) NOT NULL,
    CONSTRAINT pk_PRODUCTO PRIMARY KEY (CODPRODUCTO)
);

CREATE TABLE VENTA(
    CODVENTA NUMBER(5) NOT NULL,
    FECHA DATE NOT NULL,
    CONSTRAINT pk_VENTA PRIMARY KEY(CODVENTA)
);

CREATE TABLE LINEAVENTA(
    CODPRODUCTO NUMBER(5) NOT NULL,
    CODVENTA NUMBER(5) NOT NULL,
    CANTIDAD NUMBER(2) NOT NULL,
    CONSTRAINT pk_lineaventa PRIMARY KEY(CODPRODUCTO,CODVENTA),
    CONSTRAINT fk_lineaventa FOREIGN KEY (CODVENTA) REFERENCES VENTA(CODVENTA),
    CONSTRAINT fk_linea FOREIGN KEY(CODPRODUCTO) REFERENCES PRODUCTO(CODPRODUCTO)
);
