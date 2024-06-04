CREATE OR REPLACE TYPE EMPLEADO AS OBJECT (
    DNI VARCHAR2(9),
    NOMBRE VARCHAR2(30),
    APELLIDO1 VARCHAR2(30),
    APELLIDO2 VARCHAR2(30),
    TELEFONO VARCHAR2(15)
) NOT FINAL;

CREATE OR REPLACE TYPE INSPECTOR UNDER EMPLEADO (
    ESPECIALIDAD VARCHAR2(50)
);

CREATE OR REPLACE TYPE POLICIA UNDER EMPLEADO (
    CATEGORIA VARCHAR2(30),
    SALARIO_BASE NUMBER,
    MEMBER FUNCTION calculaSalario(salario_base NUMBER) RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY POLICIA AS
    MEMBER FUNCTION calculaSalario(salario_base NUMBER) RETURN NUMBER IS
        salario_final NUMBER;
    BEGIN
        CASE SELF.CATEGORIA
            WHEN 'LOCAL' THEN
                salario_final := SELF.SALARIO_BASE * 1.05;
            WHEN 'NACIONAL' THEN
                salario_final := SELF.SALARIO_BASE * 1.15;
            WHEN 'OPERACIONES ESPECIALES' THEN
                salario_final := SELF.SALARIO_BASE * 1.20;
            ELSE
                salario_final := SELF.SALARIO_BASE;
        END CASE;
        RETURN salario_final;
    END;
END;

CREATE TABLE INSPECTORES OF INSPECTOR;

CREATE TABLE POLICIAS OF POLICIA;