CREATE TABLE AUTOBUS(
    MATRICULA VARCHAR(7) NOT NULL,
    ANTIGUEDAD NUMBER(2) NOT NULL,
    FECHA_VALIDEZ_ITV DATE NOT NULL,
    NUM_PLAZAS NUMBER(3) NOT NULL,
    CONSTRAINT PK_AUTOBUS PRIMARY KEY(MATRICULA),
    CONSTRAINT CK_PLAZAS CHECK(NUM_PLAZAS < 100)
);

CREATE TABLE CONDUCTOR(
	DNI VARCHAR2(9) NOT NULL,
	NOMBRE VARCHAR2(40) NOT NULL,
	PRAPELLIDO VARCHAR2(40) NOT NULL,
	SGAPELLIDO VARCHAR2(30),
	NUM_EMPLEADO NUMBER(6) NOT NULL,
	CONSTRAINT pk_conductor PRIMARY KEY(DNI),
	CONSTRAINT uk_empleado UNIQUE(NUM_EMPLEADO)
);

CREATE TABLE VIAJES(
	DNI_CONDUCTOR VARCHAR2(9) NOT NULL,
	MATRICULA_AUTOBUS VARCHAR(7) NOT NULL,
	FECHA DATE NOT NULL,
	TIPO VARCHAR(7) NOT NULL,
	DESTINO VARCHAR2(20) NOT NULL,
	CONSTRAINT PK_VIAJES PRIMARY KEY(DNI_CONDUCTOR,MATRICULA_AUTOBUS,FECHA),
	CONSTRAINT FK_CONDUCTOR FOREIGN KEY(DNI_CONDUCTOR) REFERENCES CONDUCTOR(DNI) ON DELETE CASCADE,
	CONSTRAINT FK_AUTO FOREIGN KEY(MATRICULA_AUTOBUS) REFERENCES AUTOBUS(MATRICULA) ON DELETE CASCADE
);

INSERT INTO AUTOBUS VALUES('4598DLM',15,'12/12/2025',50);
INSERT INTO AUTOBUS VALUES('2526LMX',5,'06/04/2023',96);
INSERT INTO AUTOBUS VALUES('2130HGF',9,'25/10/2024',70);
INSERT INTO AUTOBUS VALUES('9995GVC',7,'30/08/2023',63);

INSERT INTO CONDUCTOR VALUES('93606885J','PEDRO','MARTIN','LUNA',852963);
INSERT INTO CONDUCTOR VALUES('57927673L','LUCAS','PEREZ',NULL,789456);
INSERT INTO CONDUCTOR VALUES('83119803B','VERONICA','LOPEZ','GOMEZ',125478);
INSERT INTO CONDUCTOR VALUES('31207982H','MARCO','GARCIA','DIAZ',669874);

INSERT INTO VIAJES VALUES('93606885J','4598DLM','01/02/2023','PUBLICO','MADRID');
INSERT INTO VIAJES VALUES('57927673L','2130HGF','20/03/2023','PRIVADO','VALENCIA');
INSERT INTO VIAJES VALUES('83119803B','9995GVC','13/04/2023','PRIVADO','SEVILLA');
INSERT INTO VIAJES VALUES('31207982H','2526LMX','17/04/2023','PUBLICO','MADRID');
INSERT INTO VIAJES VALUES('57927673L','2130HGF','05/05/2023','PUBLICO','LUGO');
INSERT INTO VIAJES VALUES('83119803B','2526LMX','23/03/2023','PUBLICO','BAECELONA');

/*CONSULTAS*/
/*1*/
/*A*/
SELECT NOMBRE FROM CONDUCTOR C JOIN VIAJES V ON C.DNI=V.DNI_CONDUCTOR WHERE DESTINO='MADRID';
/*B*/
SELECT NUM_PLAZAS FROM AUTOBUS A JOIN VIAJES V ON A.MATRICULA=V.MATRICULA_AUTOBUS WHERE TIPO='PRIVADO';
/*C*/
SELECT DNI FROM CONDUCTOR C WHERE NOMBRE='MARCO';
UPDATE VIAJES SET DNI_CONDUCTOR='83119803B' WHERE DNI_CONDUCTOR='31207982H';
/*D*/
SELECT FECHA FROM VIAJES WHERE DESTINO='MADRID';
/*E*/
SELECT * FROM CONDUCTOR WHERE SGAPELLIDO IS NULL;
/*F*/
SELECT DNI FROM CONDUCTOR WHERE NOMBRE IN ('VERONICA','PEDRO');
/*G*/
SELECT * FROM AUTOBUS WHERE FECHA_VALIDEZ_ITV <= TO_DATE('31/12/2023','DD/MM/YYYY');
SELECT * FROM AUTOBUS WHERE TO_CHAR(FECHA_VALIDEZ_ITV,'YYYY') <= 2023;
/*H*/
SELECT NUM_PLAZAS FROM AUTOBUS WHERE MATRICULA LIKE('2%');
/*I*/
SELECT * FROM VIAJES WHERE FECHA BETWEEN TO_DATE('1/04/2023','DD/MM/YYYY') AND TO_DATE('30/06/2023','DD-MM-YYYY');
SELECT * FROM VIAJES WHERE TO_CHAR(FECHA,'MM/YYYY') BETWEEN '04/2023' AND '06/2023';
SELECT * FROM VIAJES WHERE TO_NUMBER(TO_CHAR(FECHA,'YYYY'))=2023 AND TO_NUMBER(TO_CHAR(FECHA,'MM')) BETWEEN 4 AND 6;
/*J*/
SELECT NUM_EMPLEADO FROM CONDUCTOR WHERE NOMBRE LIKE '%_R_%';
/*K*/
SELECT NOMBRE FROM CONDUCTOR WHERE NOMBRE NOT LIKE '%Z';
/*L*/
SELECT * FROM VIAJES WHERE MATRICULA_AUTOBUS IN ('9995GVC','2526LMX');
/*M*/
SELECT NOMBRE, PRAPELLIDO, SGAPELLIDO FROM CONDUCTOR WHERE DNI NOT LIKE ('%0%');
/*N*/
SELECT MATRICULA FROM AUTOBUS WHERE NUM_PLAZAS > 65 AND ANTIGUEDAD <= 5;
/*O*/
SELECT DESTINO FROM VIAJES WHERE DNI_CONDUCTOR LIKE '5%L';

/*INSERTS EJECICIO 2*/
INSERT INTO CONDUCTOR VALUES('31207982H', 'MARCO', 'GARCIA', 'DIAZ', 669874);
INSERT INTO CONDUCTOR VALUES('38607982N', 'LUCIA', 'GARCIA', 'MEDINA', 526987);
INSERT INTO CONDUCTOR VALUES('31207102C', 'BEATRIZ', 'MENDEZ', 'GARCIA', 445879);
INSERT INTO CONDUCTOR VALUES('99207123L', 'DAVID', 'PEREZ', 'HOYO', 362201);
INSERT INTO CONDUCTOR VALUES('45204004G', 'DANIEL', 'SANTOS', 'PEREZ', 899630)

/*2*/
/*A*/
SELECT * FROM CONDUCTOR WHERE PRAPELLIDO ='PEREZ' AND NOMBRE ='DAVID'; 
/*B*/
SELECT DNI FROM CONDUCTOR WHERE NOMBRE LIKE 'L%' AND SGAPELLIDO IS NOT NULL;
/*C*/
SELECT DNI FROM CONDUCTOR WHERE PRAPELLIDO IN('PEREZ','GARCIA') AND DNI NOT LIKE('%L%');
/*D*/
SELECT NOMBRE, PRAPELLIDO, SGAPELLIDO FROM CONDUCTOR ORDER BY PRAPELLIDO ASC;
/*E*/
SELECT NOMBRE, PRAPELLIDO, SGAPELLIDO FROM CONDUCTOR ORDER BY PRAPELLIDO,SGAPELLIDO;
/*F*/
SELECT NOMBRE FROM CONDUCTOR WHERE PRAPELLIDO != 'PEREZ' AND SGAPELLIDO != 'PEREZ';
/*G*/
SELECT DISTINCT DNI_CONDUCTOR FROM VIAJES;
/*H*/
SELECT DESTINO FROM VIAJES ORDER BY DESTINO;
/*C*/
ALTER TABLE AUTOBUS ADD PRECIO NUMBER(6) NOT NULL;
/*I*/
SELECT MATRICULA, PRECIO FROM AUTOBUS WHERE PRECIO=(SELECT MAX(PRECIO)FROM AUTOBUS);
SELECT MATRICULA, PRECIO FROM (SELECT MATRICULA, PRECIO FROM AUTOBUS ORDER BY PRECIO DESC) WHERE ROWNUM=1;
/*J*/
SELECT DISTINCT NOMBRE, PRAPELLIDO, NUM_EMPLEADO FROM CONDUCTOR C JOIN VIAJES V ON C.DNI=V.DNI_CONDUCTOR WHERE DESTINO LIKE('L%') ORDER BY C.NUM_EMPLEADO;
/*K*/
SELECT DESTINO FROM VIAJES V JOIN CONDUCTOR C ON V.DNI_CONDUCTOR=C.DNI WHERE C.NUM_EMPLEADO < 700000 AND C.SGAPELLIDO!=('PEREZ');
/*L*/
SELECT DISTINCT NOMBRE FROM VIAJES V RIGHT JOIN CONDUCTOR C ON V.DNI_CONDUCTOR=C.DNI;
SELECT DISTINCT NOMBRE FROM CONDUCTOR WHERE DNI NOT IN (SELECT DISTINCT DNI_CONDUCTOR FROM VIAJES);
/*M*/
SELECT COUNT(TIPO) FROM VIAJES V WHERE V.TIPO LIKE('PRIVADO');
/*N*/
SELECT C.NOMBRE, C.PRAPELLIDO, C.NUM_EMPLEADO, MAX(A.PRECIO), MIN(A.PRECIO), AVG(A.PRECIO) FROM CONDUCTOR C JOIN VIAJES V ON C.DNI=V.DNI_CONDUCTOR JOIN AUTOBUS A ON V.MATRICULA_AUTOBUS=A.MATRICULA GROUP BY C.NOMBRE, C.PRAPELLIDO, C.NUM_EMPLEADO;
/*O*/
SELECT C.NOMBRE, COUNT(*) FROM VIAJES V JOIN CONDUCTOR C ON V.DNI_CONDUCTOR=C.DNI GROUP BY C.NOMBRE HAVING COUNT(*)>1;
/*P*/
SELECT * FROM AUTOBUS WHERE PRECIO<(SELECT PRECIO FROM AUTOBUS WHERE MATRICULA IN (SELECT MATRICULA_AUTOBUS FROM VIAJES WHERE DNI_CONDUCTOR=(SELECT DNI FROM CONDUCTOR WHERE NOMBRE LIKE ('PEDRO')))); 
/*Q*/
SELECT * FROM AUTOBUS WHERE PRECIO<=ALL(SELECT PRECIO FROM AUTOBUS);
/*R*/
SELECT COUNT(DNI_CONDUCTOR), DNI_CONDUCTOR FROM VIAJES GROUP BY DNI_CONDUCTOR HAVING COUNT(DNI_CONDUCTOR) < (SELECT COUNT(DNI_CONDUCTOR) FROM VIAJES WHERE DNI_CONDUCTOR IN (SELECT DNI FROM CONDUCTOR WHERE NOMBRE='VERONICA'));
/*S*/
SELECT * FROM AUTOBUS A WHERE PRECIO > (SELECT AVG(A.PRECIO) FROM AUTOBUS A JOIN VIAJES V ON A.MATRICULA=V.MATRICULA_AUTOBUS JOIN CONDUCTOR C ON V.DNI_CONDUCTOR=C.DNI WHERE C.NOMBRE LIKE ('LUCAS'));