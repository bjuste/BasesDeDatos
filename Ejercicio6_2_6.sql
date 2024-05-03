/*6*/
CREATE OR REPLACE PROCEDURE fechaViaje
AS
vfecha DATE;
BEGIN
    SELECT MIN(DP.fecha_alta) INTO vfecha
    FROM DATOSPERSONALES DP JOIN EMPLEADOS E ON DP.CLAVE_EMPLEADO = E.ID_EMPLEADO WHERE E.ID_EMPLEADO = (SELECT MIN(ID_EMPLEADO) FROM EMPLEADOS);
    
     DBMS_OUTPUT.PUT_LINE('La fecha de alta del empleado con el número de empleado más bajo es: ' || TO_CHAR(vfecha, 'DD/MM/YYYY'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron empleados.');
END;

/*COMPROBAR*/
BEGIN
    fechaViaje;
END;