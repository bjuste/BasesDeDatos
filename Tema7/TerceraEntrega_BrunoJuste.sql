/*Creaci?n de la tabla Descuento*/
CREATE TABLE Descuento (
    codDescuento VARCHAR(5),
    porcentaje NUMBER(5,2) NOT NULL,
    CONSTRAINT PK_DESCUENTO PRIMARY KEY (codDescuento)
);

/*Creaci?n de la tabla Empleado*/
CREATE TABLE Empleado (
    dni VARCHAR(9),
    nombre VARCHAR(30) NOT NULL,
    apellidoUno VARCHAR(30) NOT NULL,
    apellidoDos VARCHAR(30) NULL,
    numColegiado VARCHAR(5),
    tipoEmpleado VARCHAR(30) NOT NULL,
    descuento VARCHAR(5),
    telefono NUMBER(9),
    areaTrabajo VARCHAR(30),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (dni),
    CONSTRAINT UN_EMPLEADO UNIQUE (numColegiado),
    CONSTRAINT FK_EMPLEADO FOREIGN KEY (descuento) REFERENCES Descuento(codDescuento),
    CONSTRAINT CK_TIPOEMPLEADO CHECK (tipoEmpleado IN ('DOCTOR', 'ENFERMERO', 'AUXILIAR ENFERMERIA', 'ADMINISTRATIVO', 'CELADOR'))
);

/*Cambiamos para que apellidoDos pueda ser nulo*/
ALTER TABLE Empleado MODIFY apellidoDos VARCHAR(30) NULL;

/*Creaci?n de la tabla Proveedor*/
CREATE TABLE Proveedor (
    codProveedor NUMBER(2),
    CIF VARCHAR(9) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    ccaa VARCHAR(30) NOT NULL,
    telefono NUMBER(9),
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY (codProveedor),
    CONSTRAINT UN_PROVEEDOR UNIQUE (CIF)
);

/*Creaci?n de la tabla Camarero*/
CREATE TABLE Camarero (
    codEmpleado NUMBER(2),
    nombreUsuario VARCHAR(30) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    contrato VARCHAR(50),
    CONSTRAINT PK_CAMARERO PRIMARY KEY (codEmpleado),
    CONSTRAINT UN_CAMARERO UNIQUE (nombreUsuario),
    CONSTRAINT FK_CAMARERO FOREIGN KEY (dni) REFERENCES Empleado(dni) ON DELETE CASCADE
);

/*quitamos la foreign key de camarero*/
ALTER TABLE Camarero DROP CONSTRAINT FK_CAMARERO;
/*cambiamos el tama�o dle campo de codigoEmpleado*/
ALTER TABLE Camarero MODIFY codEmpleado NUMBER(4);

/*Creaci?n de la tabla Producto*/
/*Tabla producto se ha cambiado la foreign key, por codigoProducto*/
CREATE TABLE Producto (
    codProducto NUMBER(3),
    stock NUMBER(3) NOT NULL,
    nombreProducto VARCHAR(30) NOT NULL,
    precio NUMBER(5,2) NOT NULL,
    descripcion VARCHAR(30),
    caducidad DATE,
    codProveedor number(2),
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (codProducto),
    CONSTRAINT FK_PRODUCTO FOREIGN KEY (codProveedor) REFERENCES Proveedor(codProveedor) ON DELETE CASCADE,
    CONSTRAINT CK_PRODCUTO CHECK (stock BETWEEN 0 AND 999)
);

/*Se quita CIF, para agregar codProveedor y agregarlo como primary key*/
ALTER TABLE Producto DROP COLUMN CIF;
ALTER TABLE Producto ADD codProveedor NUMBER(2);
ALTER TABLE Producto ADD CONSTRAINT FK_PRODUCTO FOREIGN KEY (codProveedor) REFERENCES Proveedor(codProveedor) ON DELETE CASCADE;

/*Creaci?n de la tabla Venta*/
CREATE TABLE Venta (
    numTicket number(3),
    fecha DATE NOT NULL,
    precioProducto number(3),
    cantidadProducto number(3),
    codEmpleado number(3),
    dni VARCHAR(9),
    CONSTRAINT PK_VENTA PRIMARY KEY (numTicket),
    CONSTRAINT fk_lineaventa FOREIGN KEY (codEmpleado) REFERENCES Camarero(codEmpleado) ON DELETE CASCADE,
    CONSTRAINT FK_VENTADNI FOREIGN KEY (dni) REFERENCES Empleado(dni) ON DELETE CASCADE
);

CREATE TABLE Ticket (
    codProducto NUMBER(3),
    numTicket number(3),
    constraint PK_TICKET PRIMARY KEY (codProducto, numTicket),
    CONSTRAINT FK_TICKET FOREIGN KEY (codProducto) REFERENCES Producto(codProducto),
    CONSTRAINT FK_TICKETVENTA FOREIGN KEY (numTicket) REFERENCES Venta(numTicket)
);

/*Crear las Secuencias*/
CREATE SEQUENCE SEQ_EMPLEADO START WITH 1000 INCREMENT BY 1 MAXVALUE 9999 NOCYCLE;
CREATE SEQUENCE SEQ_PRODUCTO START WITH 010 INCREMENT BY 1 MAXVALUE 999 NOCYCLE;

DROP SEQUENCE SEQ_EMPLEADO;
DROP SEQUENCE SEQ_PRODUCTO;
/*Inserts*/

/*DESECUENTOS*/

INSERT INTO Descuento (codDescuento, porcentaje) VALUES ('d022', 22);
INSERT INTO Descuento (codDescuento, porcentaje) VALUES ('e020', 20);
INSERT INTO Descuento (codDescuento, porcentaje) VALUES ('x020', 20);
INSERT INTO Descuento (codDescuento, porcentaje) VALUES ('a015', 15);
INSERT INTO Descuento (codDescuento, porcentaje) VALUES ('c018', 18);

/*EMPLEADOS*/
INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('93603385K', 'BELEN', 'LOPEZ', 'DIEZ', 'ADMINISTRATIVO', 'a015', 635625453, 'ADMINISTRACION');

INSERT INTO Empleado (dni, nombre, apellidoUno, numColegiado, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('09927463L', 'PEDRO', 'TORRES', 25641, 'DOCTOR', 'd022', 625369587, 'CONSULTA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('71119803M', 'LUIS', 'GONZALEZ', 'SANCHEZ', 'AUXILIAR ENFERMERIA', 'x020', 698789652, 'ENFERMERIA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, numColegiado, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('31290982G', 'EVA', 'MARCOS', 'GONZALEZ', 14587, 'DOCTOR', 'd022', 645987123, 'CONSULTA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, numColegiado, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('71896442T', 'JAIME', 'SANCHEZ', 'ROMERO', 36258, 'ENFERMERO', 'e020', 648753159, 'ENFERMERIA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('21964788D', 'DANIEL', 'GARCIA', 'GIL', 'CELADOR', 'c018', 639159753, 'CONSULTA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, numColegiado, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('96884452H', 'DAVID', 'MEDINA', 'ORTEGA',89345, 'DOCTOR', 'd022', 654123789, 'CONSULTA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('71450369F', 'MIGUEL', 'PEREZ', 'SANZ', 'CELADOR', 'c018', 621453786, 'CONSULTA');

INSERT INTO Empleado (dni, nombre, apellidoUno, apellidoDos, tipoEmpleado, descuento, telefono, areaTrabajo)
VALUES ('07894125S', 'MARTA', 'MU?OZ', 'VILLA', 'ADMINISTRATIVO', 'a015', 698753265, 'ADMINISTRACION');

/*CAMAREROS*/
INSERT INTO Camarero (codEmpleado, nombreUsuario, dni, contrato) VALUES (SEQ_EMPLEADO.NEXTVAL, 'carlos55', '75589642L', 'TARDE');
INSERT INTO Camarero (codEmpleado, nombreUsuario, dni, contrato) VALUES (SEQ_EMPLEADO.NEXTVAL, 'javi61', '75214758I', 'TARDE');
INSERT INTO Camarero (codEmpleado, nombreUsuario, dni, contrato) VALUES (SEQ_EMPLEADO.NEXTVAL, 'laura60', '73654872J', 'MA?ANA');
INSERT INTO Camarero (codEmpleado, nombreUsuario, dni, contrato) VALUES (SEQ_EMPLEADO.NEXTVAL, 'sonia00', '79658745H', 'MA?ANA');
INSERT INTO Camarero (codEmpleado, nombreUsuario, dni, contrato) VALUES (SEQ_EMPLEADO.NEXTVAL, 'carmen63', '71452636G', 'ALTERNO');

/*Proveedor*/
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (11,'36422476K','CARREFOUR','VALLADOLID',983423211);
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (12,'14207080A','SUMINISTROS GARCIA','TUDELA',987647542);
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (26,'44129632S','PANADERIA PUEBLA','VALLADOLID',908375842);
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (32,'55503568Z','CAFES DEL MUNDO','TUDELA',987678987);
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (56,'74483896Y','HNOS. RICO','TUDELA',987654783);
INSERT INTO Proveedor (codProveedor, CIF, nombre, ccaa, telefono) VALUES (60,'12603532E','HELADOS FRIGO','VALLADOLID',987890909);

/*Productos*/
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,120,'CAFE SOLO',1.0,'BEBIDA',TO_DATE('2024-06-30', 'YYYY-MM-DD'),32);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,20,'CAPUCHINO',1.2,'BEBIDA',TO_DATE('2024-07-21', 'YYYY-MM-DD'),32);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,35,'CROISSANT',0.95,'COMIDA',TO_DATE('2024-06-25', 'YYYY-MM-DD'),26);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,15,'SANDWICH MIXTO',1.75,'COMIDA',TO_DATE('2024-06-12', 'YYYY-MM-DD'),11);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,50,'MANZANA',0.85,'COMIDA',TO_DATE('2024-03-17', 'YYYY-MM-DD'),11);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,90,'TOSTADAS',2.20,'COMIDA',TO_DATE('2024-06-29', 'YYYY-MM-DD'),26);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL, 25,'REFRESCO COLA', 2.15, 'BEBIDA', TO_DATE('2024-10-18', 'YYYY-MM-DD'), 56);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,33,'AGUA',0.90,'BEBIDA',TO_DATE('2024-11-23', 'YYYY-MM-DD'),12);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,60,'INFUSION',1.0,'BEBIDA',TO_DATE('2024-12-27', 'YYYY-MM-DD'),12);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,100,'CERVEZA',1.6,'BEBIDA',TO_DATE('2024-08-21', 'YYYY-MM-DD'),56);
INSERT INTO Producto (codProducto,stock, nombreProducto, precio, descripcion, caducidad, codProveedor) VALUES (SEQ_PRODUCTO.NEXTVAL,50,'PATATAS FRITAS',1.35,'COMIDA',TO_DATE('2024-04-26', 'YYYY-MM-DD'),56);

/*Consultas*/

/*1*/
SELECT * FROM Empleado WHERE numColegiado IS NOT NULL;
/*2*/
SELECT codProducto, descripcion, caducidad FROM Producto p WHERE nombreProducto LIKE 'C%';
/*3*/
SELECT nombre FROM Empleado WHERE tipoEmpleado = 'CELADOR';
/*4*/
SELECT P.nombreProducto, P.*, O.* FROM Producto P JOIN Proveedor O ON P.codProveedor = O.codProveedor WHERE P.codProveedor BETWEEN 15 AND 50 ORDER BY P.precio DESC;
/*5*/
SELECT P.codProducto, P.nombreProducto, P.precio, P.codProveedor FROM Producto P WHERE P.precio = (SELECT MAX(precio) FROM Producto WHERE codProveedor = P.codProveedor);


/*6*/
SELECT codProducto, precio FROM (SELECT codProducto, precio FROM Producto ORDER BY precio) WHERE ROWNUM = 1;
SELECT codProducto, precio FROM Producto WHERE precio = (SELECT MIN(precio) FROM Producto);
/*7*/
SELECT codEmpleado, contrato, dni FROM Camarero WHERE nombreUsuario LIKE '%0%';
/*8*/
SELECT AVG(precio) FROM Producto P JOIN Proveedor PR ON P.codProveedor = PR.codProveedor WHERE PR.nombre = UPPER('CARREFOUR');
/*9*/
SELECT DISTINCT p.nombre FROM Proveedor p LEFT JOIN Producto pr ON p.codProveedor = pr.codProveedor WHERE pr.codProveedor IS NOT NULL UNION SELECT p.nombre FROM Proveedor p WHERE p.codProveedor NOT IN (SELECT codProveedor FROM Producto);
/*10*/
SELECT pr.nombreProducto, pr.descripcion, pr.caducidad, p.nombre, p.ccaa, p.telefono FROM Producto pr JOIN Proveedor p ON pr.codProveedor = p.codProveedor WHERE pr.stock < 50;
/*11*/
SELECT e.nombre, e.apellidoUno, e.apellidoDos FROM Empleado e JOIN Descuento d ON e.descuento = d.codDescuento WHERE d.porcentaje = 20;
/*12*/
SELECT tipoEmpleado FROM Empleado WHERE apellidoDos IS NULL;
/*13*/
SELECT * FROM Producto WHERE LENGTH(nombreProducto) = 10;
/*14*/
SELECT nombre, apellidoUno, apellidoDos, telefono, areaTrabajo FROM Empleado WHERE tipoEmpleado IN ('ADMINISTRATIVO', 'ENFERMERO') ORDER BY apellidoUno ASC;