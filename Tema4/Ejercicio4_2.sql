CREATE TABLE FABRICANTE(
    CODFABRICANTE NUMBER(3) NOT NULL,
    FABRICANTE VARCHAR(40) NOT NULL,
    CONSTRAINT PK_FABRICANTE PRIMARY KEY (CODFABRICANTE)
);

CREATE TABLE MARCA(
    CODMARCA NUMBER(3) NOT NULL,
    MARCA VARCHAR(40) NOT NULL,
    CONSTRAINT PK_MARCA PRIMARY KEY (CODMARCA)
);

CREATE TABLE VEHICULO(
    CODVEHICULO NUMBER(3) NOT NULL,
    MODELO VARCHAR(40)NOT NULL,
    TIPO VARCHAR(40)NOT NULL,
    CODFABRICANTE NUMBER(3) NOT NULL,
    CODMARCA NUMBER(3) NOT NULL,
    CONSTRAINT PK_VEHICULO PRIMARY KEY (CODVEHICULO),
    CONSTRAINT FK_FABRICANTE FOREIGN KEY(CODFABRICANTE) REFERENCES FABRICANTE(CODFABRICANTE),
    CONSTRAINT FK_MARCA FOREIGN KEY(CODMARCA) REFERENCES MARCA(CODMARCA)
);

CREATE TABLE CLIENTE(
    DNI_CLIENTE VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(40)NOT NULL,
    APELLIDO1 VARCHAR(40)NOT NULL,
    APELLIDO2 VARCHAR(40)NULL,
    DOMICILIO VARCHAR(40)NOT NULL,
    NUMTARJETA NUMBER(16)NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY(DNI_CLIENTE)
);

CREATE TABLE EMPLEADO(
    DNI_EMPLEADO VARCHAR(9)NOT NULL,
    NOMBRE VARCHAR(40)NOT NULL,
    APELLIDO1 VARCHAR(40)NOT NULL,
    APELLIDO2 VARCHAR(40)NULL,
    DOMICILIO VARCHAR(40)NOT NULL,
    NUMTARJETA NUMBER(16)NOT NULL,
    CONSTRAINT PK_EMPLEADO PRIMARY KEY(DNI_EMPLEADO)
);

CREATE TABLE ALQUILER(
    CODALQUILER NUMBER(3) NOT NULL,
    FECHA DATE NOT NULL,
    NUMDIAS NUMBER(3)NOT NULL,
    KMACTUAL NUMBER(9)NOT NULL,
    KMENTREGA NUMBER(9)NOT NULL,
    DNI_CLIENTE VARCHAR(9)NOT NULL,
    CODVEHICULO NUMBER(3)NOT NULL,
    DNI_EMPLEADO VARCHAR(9)NOT NULL,
    CONSTRAINT PK_CODALQUILER PRIMARY KEY(CODALQUILER),
    CONSTRAINT FK_CLIENTE FOREIGN KEY(DNI_CLIENTE)REFERENCES CLIENTE(DNI_CLIENTE),
    CONSTRAINT FK_VEHICULO FOREIGN KEY(CODVEHICULO) REFERENCES VEHICULO(CODVEHICULO),
    CONSTRAINT FK_EMPLEADO FOREIGN KEY(DNI_EMPLEADO) REFERENCES EMPLEADO(DNI_EMPLEADO)
);

CREATE TABLE OFICINA(
    CODOFICINA NUMBER(3)NOT NULL,
    DOMICILIO VARCHAR(40)NOT NULL,
    TELEFONO NUMBER(9)NOT NULL,
    CONSTRAINT PK_OFICINA PRIMARY KEY(CODOFICINA)
);

CREATE TABLE OFICINASALQUILER(
    CODALQUILER NUMBER(3)NOT NULL,
    CODOFICINA NUMBER(3)NOT NULL,
    CONSTRAINT PK_OFINASALQUILER PRIMARY KEY(CODALQUILER, CODOFICINA),
    CONSTRAINT FK_ALQUILER FOREIGN KEY(CODALQUILER)REFERENCES ALQUILER(CODALQUILER),
    CONSTRAINT FK_OFICINA FOREIGN KEY(CODOFICINA)REFERENCES OFICINA(CODOFICINA)
);

CREATE TABLE CURSO(
    CODCURSO NUMBER(3) NOT NULL,
    DESCRIPCION VARCHAR(40)NOT NULL,
    NUMHORAS NUMBER(3) NOT NULL,
    FECHA DATE NOT NULL,
    CONSTRAINT PK_CURSO PRIMARY KEY(CODCURSO)
);

CREATE TABLE CURSOEMPLEADOS(
    DNI_EMPLEADO VARCHAR(9)NOT NULL,
    CODCURSO NUMBER(3)NOT NULL,
    CONSTRAINT PK_CURSOEMPLEADO PRIMARY KEY(DNI_EMPLEADO, CODCURSO),
    CONSTRAINT FK_EMPLEADOCURSO FOREIGN KEY(DNI_EMPLEADO) REFERENCES EMPLEADO(DNI_EMPLEADO),
    CONSTRAINT FK_CURSO FOREIGN KEY(CODCURSO) REFERENCES CURSO(CODCURSO)
);