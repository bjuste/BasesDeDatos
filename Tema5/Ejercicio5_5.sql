/*A*/
SELECT DNI FROM EMPLEADO WHERE CIUDAD IN('BARCELONA','MADRID','SEVILLA','MALAGA') AND NOMBRE NOT IN('ANTONIO','LUIS') AND PRAPELLIDO = 'GARCIA';
/*B*/
SELECT DNI FROM EMPLEADO WHERE CIUDAD !='SEVILLA' AND CIUDAD IN('BARCELONA','MADRID') AND NOMBRE LIKE('M%');
/*C*/
SELECT DNI FROM EMPLEADO WHERE CUDAD IN('SEVILLA') AND CIUDAD NOT IN('BARCELONA','MADRID') AND NOMBRE NOT LIKE('M%');
/*D*/
SELECT NOMBRE, PRAPELLIDO FROM EMPLEADO WHERE (CIUDAD IN('VALENCIA','VIZCAYA') OR CIUDAD LIKE('%A')) ORDER BY PRAPELLIDO ASC;
/*E*/
SELECT DNI FROM EMPLEADO WHERE CIUDAD='BARCELONA' AND NOMBRE IN('ANTONIO','LUIS','IVAN','PEDRO') AND PRAPELLIDO IN('GARCIA','CANTOS');
/*F*/
SELECT NOMBRE, PRAPELLIDO, SGAPELLIDO FROM EMPLEADO WHERE DNI LIKE('%_4_%') AND NOMBRE IN ('ROSA','LUIS','RAMON','ANTONIO') ORDER BY PRAPELLIDO DESC;
/*G*/
SELECT DNI FROM EMPLEADO WHERE NOMBRE='ANTONIO' AND LOWER.PRAPELLIDO NOT LIKE('%_C_%') AND SGAPELLIDO IN('GARCIA','GOMEZ','SANCHEZ') ORDER BY SGAPELLIDO ASC;
/*H*/
SELECT DNI FROM EMPLEADO WHERE SGAPELLIDO is NULL;