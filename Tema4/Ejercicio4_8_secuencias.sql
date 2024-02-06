CREATE TABLE PROFESOR(
    DNI_PROFESOR VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    AP1 VARCHAR(35) NOT NULL,
    AP2 VARCHAR(35) NULL,
    DIRECCION VARCHAR(35) NOT NULL,
    CUENTA VARCHAR(5) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL
);

ALTER TABLE PROFESOR MODIFY CUENTA VARCHAR(40);

ALTER TABLE PROFESOR ADD CONSTRAINT PK_PROFESOR PRIMARY KEY(DNI_PROFESOR);

CREATE TABLE CICLOFORM(
    CODCICLO NUMBER(3) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    TIPO VARCHAR(35) NOT NULL,
    CONSTRAINT PK_CICLOFORM PRIMARY KEY(CODCICLO)
);

CREATE TABLE ASIGNATURA(
    CODASIG NUMBER(3) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    NUMHORAS NUMBER(3) NOT NULL,
    DNI_PROFESOR VARCHAR(9) NOT NULL,
    CODCICLO NUMBER(3) NOT NULL,
    CONSTRAINT PK_ASIGNATURA PRIMARY KEY(CODASIG),
    CONSTRAINT FK_PROFESOR FOREIGN KEY(DNI_PROFESOR) REFERENCES PROFESOR(DNI_PROFESOR),
    CONSTRAINT FK_CICLOFORM FOREIGN KEY(CODCICLO) REFERENCES CICLOFORM(CODCICLO)
);

ALTER TABLE ASIGNATURA MODIFY CODCICLO NUMBER(4);

CREATE TABLE IDIOMA(
    CODIDIOMA NUMBER(3) NOT NULL,
    DESCRIPCION VARCHAR(50) NOT NULL,
    CONSTRAINT PK_IDIOMA PRIMARY KEY(CODIDIOMA)
);

CREATE TABLE ALUMNO(
    DNI_ALUMNO VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    AP1 VARCHAR(35) NOT NULL,
    AP2 VARCHAR(35) NULL,
    DIRECCION VARCHAR(35) NOT NULL,
    EMAIL VARCHAR(36) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    CODIDIOMA NUMBER(3) NULL,
    CONSTRAINT PK_ALUMNO PRIMARY KEY(DNI_ALUMNO)
);

CREATE TABLE MATRICULA(
    CODASIG NUMBER(3) NOT NULL,
    DNI_ALUMNO VARCHAR(9) NOT NULL,
    CONSTRAINT PK_MATRICULA PRIMARY KEY(DNI_ALUMNO, CODASIG),
    CONSTRAINT FK_ASIGNATURA FOREIGN KEY(CODASIG) REFERENCES ASIGNATURA(CODASIG),
    CONSTRAINT FK_ALUMNO FOREIGN KEY (DNI_ALUMNO) REFERENCES ALUMNO(DNI_ALUMNO)
);

CREATE TABLE IDIOMASPROF(
    CODIDIOMA NUMBER(3) NOT NULL,
    DNI_PROFESOR VARCHAR(9) NOT NULL,
    CONSTRAINT PK_IDIOMASPROF PRIMARY KEY(CODIDIOMA, DNI_PROFESOR),
    CONSTRAINT FK_IDI FOREIGN KEY(CODIDIOMA) REFERENCES IDIOMA(CODIDIOMA),
    CONSTRAINT FK_PROF FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESOR(DNI_PROFESOR)
);

CREATE TABLE DATOSPERSONALES(
    DNI VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(20) NOT NULL,
    APELLIDO1 VARCHAR(20) NOT NULL,
    APELLIDO2 VARCHAR(20),
    DIRECCION VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    TIPO VARCHAR(2) NOT NULL
);

ALTER TABLE PROFESOR DROP (NOMBRE);
ALTER TABLE PROFESOR DROP (AP1);
ALTER TABLE PROFESOR DROP (AP2);
ALTER TABLE PROFESOR DROP (DIRECCION);
ALTER TABLE PROFESOR DROP (TELEFONO);

ALTER TABLE ALUMNO DROP (NOMBRE);
ALTER TABLE ALUMNO DROP (AP1);
ALTER TABLE ALUMNO DROP (AP2);
ALTER TABLE ALUMNO DROP (DIRECCION);
ALTER TABLE ALUMNO DROP (TELEFONO);

ALTER TABLE DATOSPERSONALES ADD CONSTRAINT PK_DATOSPERSONALES PRIMARY KEY(DNI);

ALTER TABLE PROFESOR ADD CONSTRAINT FK_DATOSPERSONALES FOREIGN KEY(DNI_PROFESOR) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;
ALTER TABLE ALUMNO ADD CONSTRAINT FK_DTPO FOREIGN KEY(DNI_ALUMNO) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;
ALTER TABLE PROFESOR ADD CONSTRAINT

ALTER TABLE DATOSPERSONALES ADD CONSTRAINT CHECK(TIPO IN('PROFESOR','ALUMNO'));

ALTER TABLE DATOSPERSONALES MODIFY TIPO VARCHAR(9);
ALTER TABLE CICLOFORM MODIFY CODCICLO NUMBER(4);

INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('71654896M','MARTA','MARTIN','RODRIGUEZ','C/MIRAVILLA','983652148','ALUMNO');

INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('44103779F','JESUS','LOPEZ','ANTON','C/LOPEZ GOMEZ','654987123','PROFESOR');
INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('11526987G','PEDRO','DIAZ','HERNANDEZ','C/TRANSICION','698741236','ALUMNO');
INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('89621477A','LUIS','VILA','GOMEZ','C/CARDENAS TORQUEMADA','654710236','PROFESOR');
INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('45986321N','ANDREA','RIVAS','ALONSO','C/SALUD','622254789','ALUMNO');
INSERT INTO DATOSPERSONALES(DNI, NOMBRE, APELLIDO1, APELLIDO2, DIRECCION, TELEFONO, TIPO) VALUES ('71056984D','MIRIAM','ALONSO','BERODAS','PASEO ZORRILLA','645897123','ALUMNO');

INSERT INTO CICLOFORM(CODCICLO, NOMBRE, TIPO) VALUES ('1565','DAM','GRADO SUPERIOR');
INSERT INTO CICLOFORM(CODCICLO, NOMBRE, TIPO) VALUES ('2598','SMR','GRADO MEDIO');
INSERT INTO CICLOFORM(CODCICLO, NOMBRE, TIPO) VALUES ('1489','ARI','GRADO SUPERIOR');

INSERT INTO PROFESOR(DNI_PROFESOR, CUENTA) VALUES ('44103779F','ES20002399348396092013170');
INSERT INTO PROFESOR(DNI_PROFESOR, CUENTA) VALUES ('89621477A','ES8501865417580989668301');

INSERT INTO ALUMNO(DNI_ALUMNO, EMAIL) VALUES ('71654896M','marta.mr@gmail.com');
INSERT INTO ALUMNO(DNI_ALUMNO, EMAIL) VALUES ('11526987G','pedro.dh@gmail.com');
INSERT INTO ALUMNO(DNI_ALUMNO, EMAIL) VALUES ('45986321N','andrea.ra@gmail.com');
INSERT INTO ALUMNO(DNI_ALUMNO, EMAIL) VALUES ('71056984D','miriam.ab@gmail.com');

INSERT INTO IDIOMA(CODIDIOMA, DESCRIPCION) VALUES ('20','INGLES');
INSERT INTO IDIOMA(CODIDIOMA, DESCRIPCION) VALUES ('30','ESPA�OL');

--insert sin secuencia
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES ('1','EMPRESA','128','44103779F','1565');
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES ('2','INFORMATICA INDUSTRIAL','269','44103779F','1565');
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES ('3','APLICACIONES WEB','200','89621477A','2598');
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES ('4','BASES DE DATOS','170','89621477A','1489');
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES ('5','PROGRAMACION','225','89621477A','2598');

INSERT INTO IDIOMASPROF(CODIDIOMA, DNI_PROFESOR) VALUES ('30','44103779F');
INSERT INTO IDIOMASPROF(CODIDIOMA, DNI_PROFESOR) VALUES ('20','89621477A');
INSERT INTO IDIOMASPROF(CODIDIOMA, DNI_PROFESOR) VALUES ('30','89621477A');

INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71654896M','1');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('11526987G','2');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('45986321N','3');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71056984D','4');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71654896M','5');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('11526987G','1');

DELETE FROM MATRICULA;

DELETE FROM ASIGNATURA;
--creacion de la secuencia
CREATE SEQUENCE SEQ_ASIGNATURA START WITH 1 INCREMENT BY 1 MAXVALUE 999 NOCYCLE;

--insert con secuencia
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (SEQ_ASIGNATURA.NEXTVAL,'EMPRESA',128,'44103779F',1565);
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (SEQ_ASIGNATURA.NEXTVAL,'INFORMATICA INDUSTRIAL',269,'44103779F',1565);
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (SEQ_ASIGNATURA.NEXTVAL,'APLICACIONES WEB',200,'89621477A',2598);
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (SEQ_ASIGNATURA.NEXTVAL,'BASES DE DATOS',170,'89621477A',1489);
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (SEQ_ASIGNATURA.NEXTVAL,'PROGRAMACION',225,'89621477A',2598);

INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71654896M','1');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('11526987G','2');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('45986321N','3');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71056984D','4');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('71654896M','5');
INSERT INTO MATRICULA(DNI_ALUMNO, CODASIG) VALUES ('11526987G','1');

SELECT NOMBRE FROM DATOSPERSONALES,PROFESOR,IDIOMASPROF,IDIOMA WHERE TIPO='PROFESOR' AND DESCRIPCION='ESPA�OL' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR AND PROFESOR.DNI_PROFESOR=IDIOMASPROF.DNI_PROFESOR AND IDIOMASPROF.CODIDIOMA=IDIOMA.CODIDIOMA;
SELECT ASIGNATURA.NOMBRE FROM ASIGNATURA,CICLOFORM WHERE CICLOFORM.NOMBRE='DAM' AND ASIGNATURA.CODCICLO=CICLOFORM.CODCICLO;
SELECT PROFESOR.CUENTA, DATOSPERSONALES.NOMBRE FROM DATOSPERSONALES, PROFESOR WHERE TIPO='PROFESOR' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR;
SELECT DATOSPERSONALES.* FROM DATOSPERSONALES, ALUMNO WHERE TIPO='ALUMNO' AND DATOSPERSONALES.DNI=ALUMNO.DNI_ALUMNO;
SELECT DATOSPERSONALES.* FROM DATOSPERSONALES, PROFESOR WHERE TIPO='PROFESOR' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR;
SELECT DATOSPERSONALES.NOMBRE, ALUMNO.EMAIL FROM DATOSPERSONALES, ALUMNO WHERE TIPO='ALUMNO' AND DATOSPERSONALES.DNI=ALUMNO.DNI_ALUMNO;
SELECT ALUMNO.EMAIL, DATOSPERSONALES.NOMBRE FROM DATOSPERSONALES, MATRICULA,ALUMNO WHERE DATOSPERSONALES.DNI=MATRICULA.DNI_ALUMNO AND DATOSPERSONALES.DNI=ALUMNO.DNI_ALUMNO;
SELECT DATOSPERSONALES.NOMBRE, ASIGNATURA.NOMBRE FROM DATOSPERSONALES, ASIGNATURA, MATRICULA WHERE DATOSPERSONALES.DNI=MATRICULA.DNI_ALUMNO AND MATRICULA.CODASIG=ASIGNATURA.CODASIG;
SELECT ASIGNATURA.NOMBRE FROM DATOSPERSONALES, ASIGNATURA, MATRICULA WHERE DATOSPERSONALES.DNI=MATRICULA.DNI_ALUMNO AND MATRICULA.CODASIG=ASIGNATURA.CODASIG AND DATOSPERSONALES.NOMBRE LIKE 'PEDRO';
SELECT * FROM CICLOFORM WHERE TIPO='GRADO SUPERIOR';
SELECT ASIGNATURA.*, CICLOFORM.NOMBRE FROM ASIGNATURA, CICLOFORM WHERE ASIGNATURA.CODCICLO=CICLOFORM.CODCICLO;
SELECT ASIGNATURA.* FROM ASIGNATURA WHERE NUMHORAS BETWEEN 0 AND 200;
SELECT * FROM DATOSPERSONALES WHERE DATOSPERSONALES.NOMBRE='ANDREA';
UPDATE DATOSPERSONALES SET DATOSPERSONALES.APELLIDO2 = NULL WHERE DATOSPERSONALES.NOMBRE='ANDREA'
SELECT * FROM ASIGNATURA, MATRICULA WHERE MATRICULA.CODASIG = ASIGNATURA.CODASIG AND ASIGNATURA.NOMBRE='PROGRAMACION';
DELETE FROM MATRICULA WHERE MATRICULA.CODASIG=5;
SELECT * FROM ASIGNATURA, MATRICULA WHERE MATRICULA.CODASIG = ASIGNATURA.CODASIG AND ASIGNATURA.NOMBRE='EMPRESA';
DELETE FROM ASIGNATURA WHERE ASIGNATURA.CODASIG=1;
DELETE FROM MATRICULA WHERE MATRICULA.CODASIG=1;
UPDATE ASIGNATURA SET ASIGNATURA.NOMBRE = 'BBDD' WHERE ASIGNATURA.NOMBRE = 'BASES DE DATOS';
SELECT ASIGNATURA.NOMBRE FROM ASIGNATURA WHERE ASIGNATURA.NOMBRE='BBDD';
INSERT INTO CICLOFORM (CODCICLO, NOMBRE,TIPO) VALUES (6365,'ELEC','GRADO MEDIO');
SELECT * FROM CICLOFORM WHERE CICLOFORM.NOMBRE='ELEC';
SELECT * FROM ASIGNATURA;
SELECT DNI_PROFESOR FROM ASIGNATURA WHERE ASIGNATURA.NOMBRE='APLICACIONES WEB';
INSERT INTO ASIGNATURA(CODASIG, NOMBRE, NUMHORAS, DNI_PROFESOR, CODCICLO) VALUES (6,'CIRCUITOS BAJA POTENCIA',100,'89621477A',6365);
SELECT * FROM ASIGNATURA;
SELECT MATRICULA.* FROM MATRICULA, DATOSPERSONALES WHERE DATOSPERSONALES.DNI=MATRICULA.DNI_ALUMNO AND datospersonales.nombre = 'PEDRO';
UPDATE MATRICULA SET MATRICULA.CODASIG = 3 WHERE MATRICULA.CODASIG=2;
SELECT * FROM IDIOMA;
INSERT INTO IDIOMA(CODIDIOMA, DESCRIPCION) VALUES(50,'ALEMAN');
SELECT DATOSPERSONALES.NOMBRE, DATOSPERSONALES.DNI FROM DATOSPERSONALES WHERE TIPO='PROFESOR';
INSERT INTO IDIOMASPROF(CODIDIOMA, DNI_PROFESOR) VALUES (50, '44103779F');
SELECT * FROM IDIOMASPROF WHERE DNI_PROFESOR='44103779F';

--reiniciar una secuencia
--1. HACEMOS UN INCREMENTO NEGATIVO PARA PONER LA SECUENCIA EN EL VALOR INICIAL QUE QUERAMOS
--ESTAMOS EN EL VALOR 20 Y QUEREMOS EL 1
ALTER SEQUENCE SEQ_ASIGNATURA INCREMENT BY -19;
--2. PARA QUE EL INCREMENTO FUNCIONE HAU QUE UTILIZARLA EN UNA CONSULTA/INSERT
SELECT SEQ_ASIGNATURA.NEXTVAL FROM DUAL;
--3. VOLVEMOS A MODIFICAR EL INCREMENTO PARA QUE AUMENTE DE 1 EN 1
ALTER SEQUENCE SEQ_ASIGNATURA INCREMENT BY 1
--4. VEMOS EL VALOR ACTUAL
SELECT SEQ_ASIGNATURA.CURRVAL FROM DUAL;
--dual es usado para comprobar que funcion las consultas

