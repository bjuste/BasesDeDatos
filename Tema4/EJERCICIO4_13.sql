SELECT NOMBRE FROM DATOSPERSONALES,PROFESOR,IDIOMASPROF,IDIOMA WHERE TIPO='PROFESOR' AND DESCRIPCION='ESPA�OL' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR AND PROFESOR.DNI_PROFESOR=IDIOMASPROF.DNI_PROFESOR AND IDIOMASPROF.CODIDIOMA=IDIOMA.CODIDIOMA;
SELECT ASIGNATURA.NOMBRE FROM ASIGNATURA,CICLOFORM WHERE CICLOFORM.NOMBRE='DAM' AND ASIGNATURA.CODCICLO=CICLOFORM.CODCICLO;
SELECT PROFESOR.CUENTA, DATOSPERSONALES.NOMBRE FROM DATOSPERSONALES, PROFESOR WHERE TIPO='PROFESOR' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR;
SELECT DATOSPERSONALES.* FROM DATOSPERSONALES, ALUMNO WHERE TIPO='ALUMNO' AND DATOSPERSONALES.DNI=ALUMNO.DNI_ALUMNO;
SELECT DATOSPERSONALES.* FROM DATOSPERSONALES, PROFESOR WHERE TIPO='PROFESOR' AND DATOSPERSONALES.DNI=PROFESOR.DNI_PROFESOR;
SELECT DATOSPERSONALES.NOMBRE, ALUMNO.EMAIL FROM DATOSPERSONALES, ALUMNO WHERE TIPO='ALUMNO' AND DATOSPERSONALES.DNI=ALUMNO.DNI_ALUMNO;