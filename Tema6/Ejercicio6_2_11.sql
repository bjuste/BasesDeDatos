CREATE OR REPLACE FUNCTION APELLIDO (iDni VARCHAR2) RETURN VARCHAR2 IS
    vApellido empleados.apellidos%TYPE;
    vDni datospersonales.dni%TYPE := iDni;
BEGIN
    SELECT e.apellidos INTO vApellido FROM  datospersonales dp, empleados e WHERE dp.DNI = vDni AND dp.clave_empleado = e.id_empleado;
    
    RETURN vApellido;
END;

DECLARE
    vApellido varchar2(9);
BEGIN
    vApellido := APELLIDO('16220446D');
    dbms_output.put_line(vApellido);
END;