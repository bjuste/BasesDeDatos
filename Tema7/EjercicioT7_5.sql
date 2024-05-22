CREATE OR REPLACE TYPE persona AS OBJECT(
    dni VARCHAR2(9),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    f_nacimiento DATE,
    MEMBER FUNCTION muestraEdad RETURN NUMBER,
    CONSTRUCTOR FUNCTION persona(dni VARCHAR2, nombre VARCHAR2, apellidos VARCHAR2, f_nacimiento DATE)
    RETURN SELF AS RESULT
);

CREATE OR REPLACE TYPE BODY persona AS
    CONSTRUCTOR FUNCTION persona (
        dni VARCHAR2,
        nombre VARCHAR2,
        apellidos VARCHAR2,
        f_nacimiento DATE
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.dni := dni;
        SELF.nombre := nombre;
        SELF.apellidos := apellidos;
        SELF.f_nacimiento := f_nacimiento;
        RETURN;
    END;
    
    MEMBER FUNCTION muestraEdad RETURN NUMBER IS
        edad NUMBER;
    BEGIN
        edad := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM self.f_nacimiento);
        RETURN edad;
    END muestraEdad;
END;

DECLARE
    trabajador persona;
    edad NUMBER;
BEGIN
    trabajador := persona('123456789', 'Juan', 'P�rez', TO_DATE('1985-05-15', 'YYYY-MM-DD'));

    edad := trabajador.muestraEdad;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || trabajador.nombre);
    DBMS_OUTPUT.PUT_LINE('Edad: ' || edad);
END;