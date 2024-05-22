
CREATE OR REPLACE TYPE persona AS OBJECT(
    dni VARCHAR2(9),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    f_nacimiento DATE,
    MEMBER FUNCTION muestraEdad RETURN NUMBER
);
CREATE OR REPLACE TYPE BODY persona AS
MEMBER FUNCTION muestraEdad RETURN NUMBER IS
        edad NUMBER;
    BEGIN
        edad := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM self.f_nacimiento);
        RETURN edad;
    END muestraEdad;
END;