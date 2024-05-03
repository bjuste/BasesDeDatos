CREATE TABLE EMPRESAS(
CIF VARCHAR(9),
NOMBRE VARCHAR(50) NOT NULL,
LOCALIDAD VARCHAR(30) NOT NULL,
CODIGO_POSTAL NUMBER(5) NOT NULL,
TIPO_EMPRESA VARCHAR(9) NOT NULL,
CONSTRAINT pk_cif PRIMARY KEY(CIF)
);

CREATE TABLE VENTAS(
COD_PRODUCTO NUMBER(4),
CIF VARCHAR(9),
FECHA DATE NOT NULL,
CANTIDAD NUMBER(3) NOT NULL,
CONSTRAINT pk_ventas PRIMARY KEY(CIF,COD_PRODUCTO,FECHA),
CONSTRAINT fk_productos FOREIGN KEY(COD_PRODUCTO) REFERENCES PRODUCTO(COD_PRODUCTO),
CONSTRAINT fk_empresas FOREIGN KEY(CIF) REFERENCES EMPRESAS(CIF)
);

CREATE TABLE PRODUCTO(
COD_PRODUCTO NUMBER(4),
NOMBRE_PRODUCTO VARCHAR(30) NOT NULL,
IVA NUMBER(2) NOT NULL,
PRECIO NUMBER(5,2) NOT NULL,
CATEGORIA VARCHAR(20),
CONSTRAINT pk_producto PRIMARY KEY(COD_PRODUCTO)
);


INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (2565, 'C99067522', '12/01/2024', 4);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (1489, 'F09505561', '22/01/2024', 1);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (2036, 'W0034981A', '13/12/2023', 19);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (0289, 'P0456584B', '10/11/2023', 6);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (4569, 'V04129219', '02/02/2024', 10);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (7851, 'C99067522', '29/02/2024', 7);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (7851, 'J24023939', '29/02/2024', 5);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (8860, 'C99067522', '02/03/2024', 2);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (1489, 'F09505561', '10/03/2024', 2);
INSERT INTO VENTAS(COD_PRODUCTO,CIF,FECHA,CANTIDAD) VALUES (2036, 'W0034981A', '03/01/2024', 25);


INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('C99067522','TALLERES GERMAN','MADRID', 28005,'PUBLICA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('J24023939','SUMINISTROS BCN','BARCELONA', 08012, 'PRIVADA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('F09505561','PELUCAN','VALENCIA',46001,'PUBLICA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('W0034981A','FRUTAS Y VERDURAS MANILA', 'SEVILLA',41005,'MIXTA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('B49064439','TRANSPORTE URGENTE NACEX','LUGO',27071,'PRIVADA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('V04129219','DECORACIONES TO-DO','TOLEDO',45002,'PRIVADA');
INSERT INTO EMPRESAS(CIF,NOMBRE, LOCALIDAD,CODIGO_POSTAL, TIPO_EMPRESA) VALUES('P0456584B','FORMULA JOVEN','BADAJOZ',06011,'MIXTA');


INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (2565, 'RUEDA TRACTOR', 10, 500, 'PIEZAS');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (1489, 'CORTE PELO', 12, 25.50, 'SERVICIO');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (2036, 'CAJA MANZANA ROJA', 8, 50, NULL);
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (0289, 'PANTALON',12, 20.25, 'ROPA');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (4569, 'MESILLA DE NOCHE', 10, 69.99, 'DECORACION' );
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (7851, 'CAJA TORNILLOS 4MM', 15, 100, 'PIEZAS');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (8860, 'CAMBIO ACEITE', 14, 150.36, 'SERVICIO');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (3541, 'CAJA PLATANOS CANARIAS', 8, 90, 'COMIDA');
INSERT INTO PRODUCTO(COD_PRODUCTO,NOMBRE_PRODUCTO,IVA,PRECIO,CATEGORIA) VALUES (5410, 'CAMISA BLANCA', 15, 23.95, 'ROPA');


/*CONSULTAS*/
/*EJERCICIO 3*/
/*1*/
SELECT NOMBRE AS nombreEmpresa, LOCALIDAD AS ubicacionEmpresa FROM EMPRESAS;
/*2*/
SELECT NOMBRE, LOWER(LOCALIDAD) FROM EMPRESAS;
/*3*/
SELECT * FROM PRODUCTO WHERE COD_PRODUCTO>5000;
/*4*/
SELECT COD_PRODUCTO, NOMBRE_PRODUCTO FROM PRODUCTO WHERE CATEGORIA IS NOT NULL ORDER BY COD_PRODUCTO DESC;
/*5*/
SELECT NOMBRE_PRODUCTO FROM PRODUCTO WHERE PRECIO != ROUND(PRECIO);
/*6*/
SELECT DISTINCT CIF FROM VENTAS; 
/*7*/
SELECT * FROM VENTAS WHERE TO_CHAR(FECHA, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');
/*8*/
SELECT NOMBRE_PRODUCTO, CATEGORIA FROM PRODUCTO WHERE NOMBRE_PRODUCTO LIKE '%CAJA%' AND IVA = 15;
/*9*/
SELECT COD_PRODUCTO, PRECIO FROM PRODUCTO WHERE PRECIO=(SELECT MIN(PRECIO) FROM PRODUCTO);
SELECT COD_PRODUCTO, PRECIO FROM (SELECT COD_PRODUCTO, PRECIO FROM PRODUCTO ORDER BY PRECIO) WHERE ROWNUM=1;
/*10*/
SELECT DISTINCT E.NOMBRE FROM EMPRESAS E INNER JOIN VENTAS V ON E.CIF=V.CIF JOIN PRODUCTO P ON V.COD_PRODUCTO=P.COD_PRODUCTO WHERE LENGTH(E.CODIGO_POSTAL) > 4 AND V.COD_PRODUCTO LIKE '%8%';
/*11*/
SELECT NOMBRE_PRODUCTO FROM PRODUCTO WHERE IVA BETWEEN 9 AND 12;
SELECT NOMBRE_PRODUCTO FROM PRODUCTO WHERE IVA >= 9 AND IVA <= 12;
/*12*/
SELECT FECHA FROM VENTAS V JOIN EMPRESAS E ON V.CIF=E.CIF WHERE E.TIPO_EMPRESA IN ('PRIVADA','MIXTA');
/*13*/
SELECT * FROM VENTAS WHERE TO_CHAR(FECHA, 'MM') BETWEEN '02' AND '03' AND TO_CHAR(FECHA, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');
/*14*/
SELECT AVG(PRECIO), MAX(PRECIO), MIN(PRECIO) FROM PRODUCTO;
/*15*/
SELECT AVG(PRECIO), MAX(PRECIO), MIN(PRECIO), E.NOMBRE FROM PRODUCTO P JOIN VENTAS V ON P.COD_PRODUCTO=V.COD_PRODUCTO JOIN EMPRESAS E ON V.CIF=E.CIF GROUP BY E.NOMBRE;
/*16*/
SELECT DISTINCT E.NOMBRE, E.CIF, E.LOCALIDAD FROM EMPRESAS E JOIN VENTAS V ON E.CIF=V.CIF WHERE V.CANTIDAD>5;
/*17*/
SELECT FECHA FROM VENTAS V JOIN EMPRESAS E ON V.CIF=E.CIF WHERE E.CODIGO_POSTAL > 30000 AND E.TIPO_EMPRESA NOT LIKE 'MIXTA';
/*18*/
SELECT P.NOMBRE_PRODUCTO, E.CIF, P.PRECIO FROM PRODUCTO P JOIN VENTAS V ON P.COD_PRODUCTO=V.COD_PRODUCTO JOIN EMPRESAS E ON V.CIF=E.CIF ORDER BY PRECIO DESC;
/*19*/
SELECT DISTINCT E.NOMBRE FROM EMPRESAS E LEFT JOIN VENTAS V ON E.CIF = V.CIF;
SELECT DISTINCT NOMBRE FROM EMPRESAS UNION SELECT NOMBRE FROM VENTAS JOIN EMPRESAS ON VENTAS.CIF=EMPRESAS.CIF;
/*20*/
SELECT DISTINCT P.COD_PRODUCTO, P.IVA, P.PRECIO, V.FECHA FROM PRODUCTO P LEFT JOIN VENTAS V ON P.COD_PRODUCTO = V.COD_PRODUCTO UNION SELECT DISTINCT V.COD_PRODUCTO, P.IVA, P.PRECIO, V.FECHA FROM VENTAS V RIGHT JOIN PRODUCTO P ON P.COD_PRODUCTO = V.COD_PRODUCTO;
/*21*/
SELECT E.NOMBRE, V.CANTIDAD FROM EMPRESAS E JOIN VENTAS V ON E.CIF=V.CIF WHERE CANTIDAD =2 AND E.TIPO_EMPRESA LIKE ('PUBLICA');
/*22*/
SELECT E.CIF, COUNT(V.CIF) FROM EMPRESAS E JOIN VENTAS V ON E.CIF=V.CIF GROUP BY E.CIF;
/*23*/
SELECT * FROM PRODUCTO WHERE PRECIO>=(SELECT AVG(PRECIO) FROM PRODUCTO);
/*24*/
SELECT E.CIF, COUNT(V.CIF) FROM EMPRESAS E JOIN VENTAS V ON E.CIF=V.CIF GROUP BY E.CIF HAVING COUNT(V.CIF)>1;
/*25*/
SELECT * FROM PRODUCTO WHERE PRECIO > (SELECT PRECIO FROM PRODUCTO WHERE COD_PRODUCTO IN (SELECT COD_PRODUCTO FROM VENTAS JOIN EMPRESAS ON VENTAS.CIF=EMPRESAS.CIF WHERE EMPRESAS.NOMBRE LIKE UPPER('Suministros BCN')));
/*26*/
SELECT * FROM PRODUCTO WHERE PRECIO >= ALL (SELECT PRECIO FROM PRODUCTO);
/*27*/
SELECT E.NOMBRE FROM EMPRESAS E JOIN VENTAS V ON E.CIF = V.CIF GROUP BY E.NOMBRE HAVING COUNT(*) = (SELECT COUNT(*) FROM VENTAS V JOIN EMPRESAS E ON V.CIF=E.CIF WHERE E.NOMBRE=TRIM('PELUCAN  ')) AND E.NOMBRE != TRIM('PELUCAN ');