/*Mostrar nombre de los ciclos formativos*/
SELECT NOMBRE FROM CICLOFORM WHERE TIPO='GRADO SUPERIOR';
/*Mostrar nombre, apellidos, direccion de los profesores*/
SELECT NOMBRE, APELLIDO1, APELLIDO2, DIRECCION FROM DATOSPERSONALES WHERE TIPO='PROFESOR';
/*Mostrar nombre de los ciclos que tienen un numero de horas entre 150 y 250*/
SELECT NOMBRE FROM ASIGNATURA WHERE NUMHORAS>=150 AND NUMHORAS<=250;
/*Mostrar el nombre y el numero de cuenta de los profesores*/
SELECT DATOSPERSONALES.NOMBRE, PROFESOR.CUENTA FROM DATOSPERSONALES, PROFESOR WHERE TIPO='PROFESOR' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR;
/*Mostrar el DNI de los alumnos matriculados en codAsig=3*/
SELECT DNI_ALUMNO FROM MATRICULA WHERE CODASIG=3;
/*Mostrar el DNI de los profesores que hablan ingles*/
SELECT DNI_PROFESOR FROM IDIOMASPROF WHERE CODIDIOMA=30;
/*Mostrar el nombre de las asignaturas del profesor*/
SELECT NOMBRE FROM ASIGNATURA WHERE DNI_PROFESOR LIKE '89621477%';
/*Mostrar el DNI de Andrea y Luis*/
SELECT DNI FROM DATOSPERSONALES WHERE NOMBRE IN ('ANDREA', 'LUIS');