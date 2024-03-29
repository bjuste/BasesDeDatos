CREATE TABLE DEPARTAMENTO(
    CLAVE_DEPTO NUMBER(1)NOT NULL,
    NOMBRE VARCHAR(30)NOT NULL,
    PRESUPUESTO NUMBER(5) NOT NULL,
    CONSTRAINT PK_CLDEPTO PRIMARY KEY (CLAVE_DEPTO)
)

CREATE TABLE EMPLEADOS(
    CLAVE_EMPLEADO VARCHAR(5) NOT NULL,
    NOMBRE VARCHAR(30)NOT NULL,
    APELLIDO VARCHAR(30) NOT NULL,
    CLAVE_DEPTO NUMBER(1),
    CONSTRAINT PK_CLEMPLE PRIMARY KEY (CLAVE_EMPLEADO),
    CONSTRAINT FK_CLDEPTO FOREIGN KEY (CLAVE_DEPTO) REFERENCES DEPARTAMENTO(CLAVE_DEPTO)
)

CREATE SEQUENCE SEQ_DEPARTAMENTO START WITH 1 INCREMENT BY 1 MAXVALUE 10 NOCYCLE;

INSERT INTO DEPARTAMENTO(CLAVE_DEPTO, NOMBRE, PRESUPUESTO) VALUES (SEQ_DEPARTAMENTO.NEXTVAL,'PERSONAL',80000);
INSERT INTO DEPARTAMENTO(CLAVE_DEPTO, NOMBRE, PRESUPUESTO) VALUES (SEQ_DEPARTAMENTO.NEXTVAL,'ALMACEN',70000);
INSERT INTO DEPARTAMENTO(CLAVE_DEPTO, NOMBRE, PRESUPUESTO) VALUES (SEQ_DEPARTAMENTO.NEXTVAL,'CONTABILIDAD',60000);
INSERT INTO DEPARTAMENTO(CLAVE_DEPTO, NOMBRE, PRESUPUESTO) VALUES (SEQ_DEPARTAMENTO.NEXTVAL,'MANUFACTURA',50000);
INSERT INTO DEPARTAMENTO(CLAVE_DEPTO, NOMBRE, PRESUPUESTO) VALUES (SEQ_DEPARTAMENTO.NEXTVAL,'EMPAQUE',30000);

INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP01','ARMANDO','LOPEZ',2);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP02','TATIANA','VARGAS',1);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP03','LAURA','GARCIA',3);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP04','JUAN','PEREZ',4);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP05','IVAN','LOPEZ',4);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP06','MARGARITA','HERNANDEZ',1);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP07','JESUS','PEREZ',3);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP08','TO�O','FLORES',2);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP09','JUAN','LOPEZ',4);
INSERT INTO EMPLEADOS(CLAVE_EMPLEADO, NOMBRE, APELLIDO, CLAVE_DEPTO) VALUES ('EMP10','JOSE','HERNANDEZ',5);

/*A. OBTENER LOS NOMBRES Y APELLIDOS DE LOS EMPLEADOS*/
SELECT NOMBRE, APELLIDO FROM EMPLEADOS;
/*B. OBTENER LOS APELLIDOS DE LOS EMPLEADOS SIN REPETECIONES*/
SELECT DISTINCT APELLIDO FROM EMPLEADOS;
/*C. OBTENER TODOS LOS DATOS DE LOS EMPLEADOS QUE SE APELLIDAN LOPEZ*/
SELECT * FROM EMPLEADOS WHERE APELLIDO='LOPEZ';
/*D. OBTENER EL NOMBRE, APELLIDOS Y NOMBRE DEL DEPARTAMENTO DE LAS MUJERES QUE TRABAJAN EN LA EMPRESA*/
SELECT EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO, DEPARTAMENTO.NOMBRE FROM EMPLEADOS, DEPARTAMENTO WHERE EMPLEADOS.CLAVE_DEPTO=DEPARTAMENTO.CLAVE_DEPTO AND EMPLEADOS.NOMBRE LIKE '%A';
/*E. OBTENER TODOS LOS DATOS DE LOS EMPLEADOS QUE SE APELLIDAN LOPEZ Y LOS QUE APELLIDAN PEREZ*/
SELECT * FROM EMPLEADOS WHERE APELLIDO IN ('LOPEZ', 'PEREZ');
/*F. OBTENER EL NOMBRE Y LA CLAVE DE EMPLEADO DE LOS TRABAJADORES QUE TRABAJAN EN EL DEPTO 4*/
SELECT NOMBRE, CLAVE_EMPLEADO FROM EMPLEADOS WHERE CLAVE_DEPTO=4;
/*G. OBTENER NOMBRE Y APELLIDOS DE LOS EMPLEADOS CUYO APELLIDO COMIENZA POR 'H'*/
SELECT NOMBRE, APELLIDO FROM EMPLEADOS WHERE APELLIDO LIKE 'H%';
/*H. OBTENER LOS DATOS DE LOS DEPARTAMENTOS CUYO PRESUPUESTO ESTA ENTRE 50000 Y 70000*/
SELECT * FROM DEPARTAMENTO WHERE PRESUPUESTO BETWEEN 50000 AND 70000;
/*I. OBTENER LA CLAVE DE EMPLEADO, NOMBRE Y APELLIDO DE LOS EMPLEADOS QUE TRABAJEN EN EL DEPARTAMENTO DE CONTABILIDAD*/
SELECT EMPLEADOS.CLAVE_EMPLEADO, EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO FROM EMPLEADOS, DEPARTAMENTO WHERE EMPLEADOS.CLAVE_DEPTO=DEPARTAMENTO.CLAVE_DEPTO AND DEPARTAMENTO.NOMBRE='CONTABILIDAD';
/*J. OBTENER NOMBRE Y APELLIDO ASI COMO EL NOMBRE DEL DEPARTAMENTO DE CADO UNO DE LOS EMPLEADOS QUE LABORAN EN LA EMPRESA*/
SELECT EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO, DEPARTAMENTO.NOMBRE FROM EMPLEADOS, DEPARTAMENTO WHERE EMPLEADOS.CLAVE_DEPTO=DEPARTAMENTO.CLAVE_DEPTO;
/*K. OBTENER EL SALARIO MEDIO DE LOS EMPLEADOS QUE TRABAJAN EN LA EMPRESA*/
SELECT * FROM EMPLEADOS WHERE CLAVE_DEPTO=1;
SELECT PRESUPUESTO/2 FROM DEPARTAMENTO WHERE CLAVE_DEPTO=1;
SELECT * FROM EMPLEADOS WHERE CLAVE_DEPTO=2;
SELECT PRESUPUESTO/2 FROM DEPARTAMENTO WHERE CLAVE_DEPTO=2;
SELECT * FROM EMPLEADOS WHERE CLAVE_DEPTO=3;
SELECT PRESUPUESTO/2 FROM DEPARTAMENTO WHERE CLAVE_DEPTO=3;
SELECT * FROM EMPLEADOS WHERE CLAVE_DEPTO=4;
SELECT PRESUPUESTO/3 FROM DEPARTAMENTO WHERE CLAVE_DEPTO=4;
SELECT * FROM EMPLEADOS WHERE CLAVE_DEPTO=5;
SELECT PRESUPUESTO/1 FROM DEPARTAMENTO WHERE CLAVE_DEPTO=5;

SELECT SUM(DEPARTAMENTO.PRESUPUESTO)/10 FROM DEPARTAMENTO;

/*SEPARA EN CACHOS SEGUN LOS CAMPOS QUE SE INTRODUZCAN Y PUEDES REALIZAR OPERACIONES CON ELLOS*/
SELECT E.CLAVE_DEPTO, PRESUPUESTO, COUNT(*), PRESUPUESTO/COUNT(*) FROM EMPLEADOS E, DEPARTAMENTO D WHERE E.CLAVE_DEPTO=D.CLAVE_DEPTO GROUP BY E.CLAVE_DEPTO, PRESUPUESTO ORDER BY PRESUPUESTO/COUNT(*);
/*L. OBTENER EL NUMERO DE EMPLEADOS CUYO NOMBRE EMPIECE POR 'J' Y TRABAJEN EN EL DEPARTAMENTO DE MANUFACTURA*/
SELECT COUNT(*) AS CANTIDAD FROM EMPLEADOS, DEPARTAMENTO WHERE EMPLEADOS.CLAVE_DEPTO=departamento.clave_depto AND DEPARTAMENTO.NOMBRE='MANUFACTURA'; 