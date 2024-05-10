/*4*/
CREATE OR REPLACE PROCEDURE p_personal AS
  CURSOR cEmpleados IS
    SELECT E.nombre, D.fecha_alta FROM DATOSPERSONALES D, EMPLEADOS E WHERE d.clave_empleado=e.id_empleado;
  vNombre empleados.nombre%TYPE;
  vFechaAlta DATOSPERSONALES.fecha_alta%TYPE;
BEGIN
  OPEN cEmpleados;
  LOOP
    FETCH cEmpleados INTO vNombre, vFechaAlta;
    EXIT WHEN cEmpleados%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || vNombre || ', Fecha de alta: ' || TO_CHAR(vFechaAlta, 'DD-MM-YYYY'));
  END LOOP;
  CLOSE cEmpleados;
END;

/*COMPROBAR QUE FUNCIONA*/
CALL p_personal();