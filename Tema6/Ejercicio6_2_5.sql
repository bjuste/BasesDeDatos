/*5*/
/*a*/
CREATE OR REPLACE PROCEDURE obtenerDni (
    codigoEmpleado VARCHAR2
)
AS
    dniEmple VARCHAR2(10);
    codEmpleado VARCHAR2(5) := codigoEmpleado;
BEGIN
    SELECT dp.dni INTO dniEmple
    FROM DATOSPERSONALES dp
    JOIN EMPLEADOS e ON dp.clave_empleado = e.id_empleado
    WHERE e.id_empleado = codEmpleado;
    
    DBMS_OUTPUT.PUT_LINE(dniEmple);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se puede localizar el código.');
END;
/*COMPROBAR*/
BEGIN
    obtenerDni('EMP03');
END;

/*b*/
CREATE OR REPLACE PROCEDURE contadorPersonalE 
AS
    vtotalEmple NUMBER(3);
    sinEmpleados EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO vtotalEmple FROM EMPLEADOS WHERE id_departamento = 1;
    
    if vtotalEmple = 0 THEN
        RAISE sinEmpleados;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(vtotalEmple);
    
EXCEPTION
    WHEN sinEmpleados THEN
            DBMS_OUTPUT.PUT_LINE('No se puede localizar el código.');
    
END;
/*COMPROBAR*/
BEGIN
    contadorPersonal();
END;
call contadorPersonalE();

/*c*/
CREATE OR REPLACE PROCEDURE contarEmpleadosDepartamento (nombreDep VARCHAR2)
AS
totalEmple NUMBER;
sinEmpleados EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO totalEmple
    FROM EMPLEADOS E
    JOIN DEPARTAMENTO D ON E.ID_DEPARTAMENTO = D.ID_DEPARTAMENTO
    WHERE D.NOMBRE = nombreDep;
    
    DBMS_OUTPUT.PUT_LINE('numero total de trabajadores: ' || totalEmple);
EXCEPTION
    WHEN sinEmpleados THEN
            DBMS_OUTPUT.PUT_LINE('No se puede localizar el código.');
END;
/*COMPROBAR*/

BEGIN
    contarEmpleadosDepartamento('Empaque');
END;
