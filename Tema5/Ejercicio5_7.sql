CREATE TABLE PRODUCTOS (
  ID NUMBER(3) PRIMARY KEY,
  NOMBRE VARCHAR2(100) NOT NULL,
  PRECIO  NUMBER(6,2) NOT NULL,
  ID_FABRICANTE NUMBER(3) NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id)
);


CREATE TABLE FABRICANTES (
  ID NUMBER(3) PRIMARY KEY,
  NOMBRE VARCHAR2(100) NOT NULL
);

INSERT INTO productos VALUES(1, 'DISCO DURO SATA3 1TB', 86.99, 5);
INSERT INTO productos VALUES(2, 'MEMORIA RAM DDR4 8GB', 120, 6);
INSERT INTO productos VALUES(3, 'DISCO SSD 1 TB', 150.99, 4);
INSERT INTO productos VALUES(4, 'GEFORCE GTX 1050TI', 185, 7);
INSERT INTO productos VALUES(5, 'GEFORCE GTX 1080 XTREME', 755, 6);
INSERT INTO productos VALUES(6, 'MONITOR 24 LED FULL HD', 202, 1);
INSERT INTO productos VALUES(7, 'MONITOR 27 LED FULL HD', 245.99, 1);
INSERT INTO productos VALUES(8, 'PORTATIL YOGA 520', 559, 2);
INSERT INTO productos VALUES(9, 'PORTATIL IDEAPD 320', 444, 2);
INSERT INTO productos VALUES(10, 'IMPRESORA HP DESKJET 3720', 59.99, 3);
INSERT INTO productos VALUES(11, 'IMPRESORA HP LASERJET PRO M26NW', 180, 3);

INSERT INTO fabricantes VALUES(1, 'ASUS');
INSERT INTO fabricantes VALUES(2, 'LENOVO');
INSERT INTO fabricantes VALUES(3, 'HEWLETT-PACKARD');
INSERT INTO fabricantes VALUES(4, 'SAMSUNG');
INSERT INTO fabricantes VALUES(5, 'SEAGATE');
INSERT INTO fabricantes VALUES(6, 'CRUCIAL');
INSERT INTO fabricantes VALUES(7, 'GIGABYTE');
INSERT INTO fabricantes VALUES(8, 'HUAWEI');
INSERT INTO fabricantes VALUES(9, 'XIAOMI');

/*CONSULTAS*/
/*COMPOSICION EXTERNA*/
/*A*/
SELECT * FROM FABRICANTES LEFT JOIN PRODUCTOS ON FABRICANTES.ID=PRODUCTOS.ID_FABRICANTE; /*13*/
/*B*/
SELECT * FROM FABRICANTES LEFT JOIN PRODUCTOS ON FABRICANTES.ID=PRODUCTOS.ID_FABRICANTE WHERE PRODUCTOS.ID_FABRICANTE IS NULL; /*2*/
/*C*/
/*NO PUEDE HABER PRODUCTOS SIN FABRICANTE, YA QUE UNA DE LAS RESTRICCIONES AL CREAR LA TABLA PRODUCTOS ES QUE LA ID_FABRICANTE NO ESTE VACIA, LO QUE NOS OBLIGA A METER EL NUMERO DEL FABRICANTE*/
/*COMPOSICION INTERNA*/
/*1*/
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.NOMBRE FROM PRODUCTOS INNER JOIN FABRICANTES ON PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID;
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.NOMBRE FROM PRODUCTOS, FABRICANTES WHERE PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID;
/*2*/
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.NOMBRE FROM PRODUCTOS INNER JOIN FABRICANTES ON PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID ORDER BY FABRICANTES.NOMBRE ASC ;
/*3*/
SELECT PRODUCTOS.ID, PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.ID, FABRICANTES.NOMBRE FROM PRODUCTOS INNER JOIN FABRICANTES ON PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID;
/*4*/
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.NOMBRE FROM PRODUCTOS INNER JOIN FABRICANTES ON PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID WHERE PRODUCTOS.PRECIO=(SELECT MIN(PRECIO)FROM PRODUCTOS);
/*5*/
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, FABRICANTES.NOMBRE FROM PRODUCTOS INNER JOIN FABRICANTES ON PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID WHERE PRODUCTOS.PRECIO=(SELECT MAX(PRECIO)FROM PRODUCTOS);
/*6*/
SELECT * FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='LENOVO';
/*7*/
SELECT * FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='CRUCIAL' AND P.PRECIO>200;
/*8*/
SELECT * FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS' OR F.NOMBRE='HEWLETT-PACKARD' OR F.NOMBRE='SEAGATE';
/*9*/
SELECT * FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE IN('ASUS','HEWLETT-PACKARD','SEAGATE');
/*10*/
SELECT P.NOMBRE,P.PRECIO FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE LIKE '%E';
/*11*/
SELECT P.NOMBRE,P.PRECIO FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE LIKE '%W%';
/*12*/
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE P.PRECIO >=180 ORDER BY P.PRECIO DESC; /*Se divide en dos*/
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTOS P INNER JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE P.PRECIO >=180 ORDER BY P.NOMBRE ASC;
/*SUBCONSULTAS*/
/*1*/
SELECT * FROM PRODUCTOS WHERE ID_FABRICANTE=(SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO');
/*2*/
SELECT * FROM PRODUCTOS WHERE PRECIO=(SELECT MAX(PRECIO)FROM PRODUCTOS WHERE ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO'));
/*3*/
SELECT NOMBRE FROM PRODUCTOS WHERE ID_FABRICANTE=(SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO') AND PRECIO=(SELECT MAX(PRECIO)FROM PRODUCTOS WHERE ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO'));
/*4*/
SELECT * FROM PRODUCTOS WHERE PRECIO=(SELECT MIN(PRECIO) FROM PRODUCTOS WHERE ID_FABRICANTE=(SELECT ID FROM FABRICANTES WHERE NOMBRE='HEWLETT-PACKARD'));
/*5*/
SELECT * FROM PRODUCTOS WHERE PRECIO >= (SELECT MAX(PRECIO) FROM PRODUCTOS WHERE ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO'));
/*6*/
SELECT * FROM PRODUCTOS WHERE ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='ASUS') AND PRECIO > (SELECT AVG(PRECIO) FROM PRODUCTOS WHERE ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='ASUS'));
/*SUBCONSULTAS IN Y NOT IN*/
/*11*/
SELECT NOMBRE FROM FABRICANTES WHERE ID IN (SELECT ID_FABRICANTE FROM PRODUCTOS);
/*12*/
SELECT NOMBRE FROM FABRICANTES WHERE ID NOT IN (SELECT ID_FABRICANTE FROM PRODUCTOS);
/*SUBCONSULTAS ANY Y ALL*/
/*7*/
SELECT * FROM PRODUCTOS WHERE PRECIO >= ALL (SELECT PRECIO FROM PRODUCTOS);
/*8*/
SELECT * FROM PRODUCTOS WHERE PRECIO <= ALL (SELECT PRECIO FROM PRODUCTOS);
/*9*/
SELECT FABRICANTES.NOMBRE FROM FABRICANTES WHERE ID = ANY (SELECT ID_FABRICANTE FROM PRODUCTOS);
/*10*/
SELECT FABRICANTES.NOMBRE FROM FABRICANTES WHERE ID <> ALL (SELECT ID_FABRICANTE FROM PRODUCTOS);
/*SUBCONSULTAS CON EXISTS Y NOT EXISTS*/
/*13*/
SELECT NOMBRE FROM FABRICANTES WHERE EXISTS (SELECT * FROM PRODUCTOS WHERE PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID);
/*14*/
SELECT NOMBRE FROM FABRICANTES WHERE NOT EXISTS (SELECT * FROM PRODUCTOS WHERE PRODUCTOS.ID_FABRICANTE=FABRICANTES.ID);
/*SUBCONSULTAS CORRELACIONADAS*/
/*15*/
SELECT F.NOMBRE, P.NOMBRE, P.PRECIO FROM FABRICANTES F INNER JOIN PRODUCTOS P ON F.ID = P.ID_FABRICANTE WHERE PRECIO = (SELECT max(PRECIO) FROM PRODUCTOS P2 WHERE P2.ID_FABRICANTE=F.ID);
/*16*/
SELECT P.* FROM PRODUCTOS P WHERE PRECIO >= (SELECT AVG(P2.PRECIO) FROM PRODUCTOS P2 WHERE P2.ID_FABRICANTE=P.ID_FABRICANTE);
/*17*/
SELECT P.NOMBRE FROM FABRICANTES F INNER JOIN PRODUCTOS P ON F.ID=P.ID_FABRICANTE WHERE F.NOMBRE='LENOVO' AND P.PRECIO =(SELECT MAX(PRECIO) FROM PRODUCTOS P2 WHERE P2.ID_FABRICANTE=F.ID);
/*SUBCONSULTAS HAVING*/
/*18*/
SELECT F.NOMBRE FROM FABRICANTES F JOIN PRODUCTOS P ON F.ID = P.ID_FABRICANTE GROUP BY F.NOMBRE HAVING COUNT(*) >= (SELECT COUNT(*) FROM PRODUCTOS P WHERE P.ID_FABRICANTE = (SELECT ID FROM FABRICANTES WHERE NOMBRE='LENOVO')) AND F.NOMBRE!='LENOVO';
/*CONSULTAS RESUMEN*/
/*1*/
SELECT COUNT(*) FROM PRODUCTOS;
/*2*/
SELECT COUNT(DISTINCT IF_FABRICANTE) FROM PRODUCTOS;
/*3*/
SELECT AVG(PRECIO) FROM PRODUCTOS;
/*4*/
SELECT MIN(PRECIO) FROM PRODUCTOS;
/*5*/
SELECT nombre, precio FROM PRODUCTOS ORDER BY precio DESC;
/*6*/
SELECT SUM(PRECIO) FROM PRODUCTOS;
/*7*/
SELECT COUNT(*) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS';
/*8*/
SELECT AVG(PRECIO) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS';
/*9*/
SELECT MIN(PRECIO) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS';
/*10*/
SELECT MAX(PRECIO) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS';
/*11*/
SELECT SUM(PRECIO) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='ASUS';
/*12*/
SELECT MAX(PRECIO), MIN(PRECIO), AVG(PRECIO), COUNT(*) FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID WHERE F.NOMBRE='CRUCIAL';
/*13*/
SELECT COUNT(P.ID), F.NOMBRE FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID GROUP BY F.NOMBRE ORDER BY COUNT(P.ID) DESC;
/*14*/
SELECT MAX(PRECIO), MIN(PRECIO), AVG(PRECIO), COUNT(*), F.NOMBRE FROM PRODUCTOS P JOIN FABRICANTES F ON P.ID_FABRICANTE=F.ID GROUP BY F.NOMBRE;
/*15*/

/*16*/

/*17*/

/*18*/

/*19*/

/*20*/

/*21*/

/*22*/
/*GROUP BY*/
/*1*/
SELECT F.ID, MAX(PRECIO) FROM PRODUCTOS P, FABRICANTES F WHERE P.ID_FABRICANTE=F.ID GROUP BY F.ID ORDER BY F.ID;
/*EN EL APARTADO DE GROUP BY NO SE PONE EL PRECIO POR QUE SALEN TODOS LOS PRODUCTOS*/
/*2*/
SELECT F.NOMBRE, AVG(P.PRECIO) FROM FABRICANTES F JOIN PRODUCTOS P ON F.ID=P.ID_FABRICANTE GROUP BY F.ID, F.NOMBRE HAVING AVG(P.PRECIO)>200;
/*PRUEBAS ANY Y ALL*/
/*EN EL ANY SE PUEDE MEZCLAR < Y > CON EL = PARA INDICAR SI QUIERES METER TAMBIEN EL MINIMO O EL MAXIMO*/
/*<ANY*//*DEVUELVE LOS VALORES MENOS QUE EL MAXIMO, DE LOS PARAMETROS METIDOS*/
SELECT * FROM PRODUCTOS WHERE ID_FABRICANTE <ANY (SELECT ID FROM FABRICANTES WHERE NOMBRE = 'LENOVO' OR NOMBRE = 'SEAGATE');
/*>ANY*//*DEVUELVE LOS VALORES MAS GRANDES QUE EL MINIMO, DE LOS PARAMETROS METIDOS*/
SELECT * FROM PRODUCTOS WHERE ID_FABRICANTE >ANY (SELECT ID FROM FABRICANTES WHERE NOMBRE = 'LENOVO' OR NOMBRE = 'SEAGATE');
/*=ANY*//*ES LO MISMO QUE HACER UN IN*/
SELECT F.NOMBRE FROM FABRICANTES F WHERE F.ID = ANY (SELECT ID_FABRICANTE FROM PRODUCTOS);
/*>ALL*//*DEVUELVE LOS VALORES MAS QUE EL MAXIMO*/
SELECT * FROM PRODUCTOS WHERE PRECIO >= ALL (SELECT PRECIO FROM PRODUCTOS);
/*<ALL*//**/
SELECT * FROM PRODUCTOS WHERE PRECIO <= ALL (SELECT PRECIO FROM PRODUCTOS);
/*<>ALL*//*ES EQUIVALENTE AL NOT IN*/
SELECT F.NOMBRE FROM FABRICANTES F WHERE F.ID <> ALL (SELECT ID_FABRICANTE FROM PRODUCTOS);


