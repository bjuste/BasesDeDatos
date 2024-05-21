/*Se añade el MEMBER PROCEDURE*/
CREATE OR REPLACE TYPE TCODPOSTAL AS OBJECT(
    LOCALIDAD NUMBER(3),
    PROVINCIA NUMBER(2),
    MEMBER PROCEDURE inicializarCodPostal(LOCALIDAD NUMBER, PROVINCIA NUMBER)
);

CREATE OR REPLACE TYPE TDOMICILIO AS OBJECT(
    TIPODEVIA VARCHAR2(50),
    NOMBREVIA VARCHAR2(100),
    NUMERO NUMBER,
    RESTODOMICILIO VARCHAR2(100),
    MEMBER PROCEDURE inicializarDomicilio(TIPODEVIA VARCHAR2, NOMBREVIA VARCHAR2, NUMERO NUMBER, RESTODOMICILIO VARCHAR2)
);

CREATE OR REPLACE TYPE TNOMBRECOMPLETO AS OBJECT(
    NOMBRE VARCHAR2(50),
    PRAPELLIDO VARCHAR2(50),
    SGAPELLIDO VARCHAR2(50),
    MEMBER PROCEDURE inicializarNombreCompleto(NOMBRE VARCHAR2, PRAPELLIDO VARCHAR2, SGAPELLIDO VARCHAR2)
);

CREATE OR REPLACE TYPE TDATOSPERSONALES AS OBJECT (
    CODIGO_DP NUMBER(3),
    NOMBRE_COMPLETO TNOMBRECOMPLETO,
    DOMICILIO TDOMICILIO,
    CODIGO_POSTAL TCODPOSTAL,
    FECHA_NACIMIENTO DATE,
    MEMBER PROCEDURE inicializarDatosPersonales(CODIGO_DP NUMBER, NOMBRE_COMPLETO TNOMBRECOMPLETO, DOMICILIO TDOMICILIO, CODIGO_POSTAL TCODPOSTAL, FECHA_NACIMIENTO DATE)
);

DROP TYPE TDATOSPERSONALES;

/*CREAR las funciones de inicializar*/

CREATE OR REPLACE TYPE BODY TCODPOSTAL AS
    MEMBER PROCEDURE inicializarCodPostal(LOCALIDAD NUMBER, PROVINCIA NUMBER) IS
    BEGIN
        SELF.LOCALIDAD := LOCALIDAD;
        SELF.PROVINCIA := PROVINCIA;
    END;
END;

CREATE OR REPLACE TYPE BODY TDOMICILIO AS
    MEMBER PROCEDURE inicializarDomicilio(TIPODEVIA VARCHAR2, NOMBREVIA VARCHAR2, NUMERO NUMBER, RESTODOMICILIO VARCHAR2) IS
    BEGIN
        SELF.TIPODEVIA := TIPODEVIA;
        SELF.NOMBREVIA := NOMBREVIA;
        SELF.NUMERO := NUMERO;
        SELF.RESTODOMICILIO := RESTODOMICILIO;
    END;
END;

CREATE OR REPLACE TYPE BODY TNOMBRECOMPLETO AS
    MEMBER PROCEDURE inicializarNombreCompleto(NOMBRE VARCHAR2, PRAPELLIDO VARCHAR2, SGAPELLIDO VARCHAR2) IS
    BEGIN
        SELF.NOMBRE := NOMBRE;
        SELF.PRAPELLIDO := PRAPELLIDO;
        SELF.SGAPELLIDO := SGAPELLIDO;
    END;
END;

CREATE OR REPLACE TYPE BODY TDATOSPERSONALES AS
    MEMBER PROCEDURE inicializarDatosPersonales(CODIGO_DP NUMBER, NOMBRE_COMPLETO TNOMBRECOMPLETO, DOMICILIO TDOMICILIO, CODIGO_POSTAL TCODPOSTAL, FECHA_NACIMIENTO DATE) IS
    BEGIN
        SELF.CODIGO_DP := CODIGO_DP;
        SELF.NOMBRE_COMPLETO := NOMBRE_COMPLETO;
        SELF.DOMICILIO := DOMICILIO;
        SELF.CODIGO_POSTAL := CODIGO_POSTAL;
        SELF.FECHA_NACIMIENTO := FECHA_NACIMIENTO;
    END;
END;

/*PROCEDIMIENTO PARA EL EJERCICIO 3*/

SET SERVEROUTPUT ON;
DECLARE 
    codUno TCODPOSTAL := TCODPOSTAL(012,47);
BEGIN
    DBMS_OUTPUT.PUT_LINE(codUno.LOCALIDAD);
    codUno.inicializarCodPostal(320,47);
    DBMS_OUTPUT.PUT_LINE(codUno.LOCALIDAD);
END;

DECLARE
    domUno TDOMICILIO := TDOMICILIO('Calle','Pajaros',2,'Valladolid');
BEGIN
    DBMS_OUTPUT.PUT_LINE(domUno.TIPODEVIA);
    domUno.inicializarDomicilio('Calle','Hoteles',2,'Valladolid');
    DBMS_OUTPUT.PUT_LINE(domUno.TIPODEVIA);
END;

DECLARE
    nomUno TNOMBRECOMPLETO := TNOMBRECOMPLETO('BRUNO', 'JUSTE', 'PEREZ');
BEGIN
    DBMS_OUTPUT.PUT_LINE(nomUno.NOMBRE);
    nomUno.inicializarNombreCompleto('ALEJANDRO', 'LLEDO', 'LOPEZ');
    DBMS_OUTPUT.PUT_LINE(nomUno.NOMBRE);
END;

DECLARE
    datUno TDATOSPERSONALES := TDATOSPERSONALES(NULL, NULL, NULL, NULL, NULL);
    codUno TCODPOSTAL := TCODPOSTAL(012,47);
    domUno TDOMICILIO := TDOMICILIO('Calle','Pajaros',2,'Valladolid');
    nomUno TNOMBRECOMPLETO := TNOMBRECOMPLETO('BRUNO', 'JUSTE', 'PEREZ');
BEGIN
    DBMS_OUTPUT.PUT_LINE(datUno.CODIGO_DP);
    DBMS_OUTPUT.PUT_LINE(datUno.NOMBRE_COMPLETO.NOMBRE);
    DBMS_OUTPUT.PUT_LINE(datUno.DOMICILIO.TIPODEVIA);
    DBMS_OUTPUT.PUT_LINE(datUno.CODIGO_POSTAL.LOCALIDAD);
    DBMS_OUTPUT.PUT_LINE(datUno.FECHA_NACIMIENTO);
    
    datUno.inicializarDatosPersonales(1, nomUno, domUno, codUno, '18/04/1991');
    
    DBMS_OUTPUT.PUT_LINE(datUno.CODIGO_DP);
    DBMS_OUTPUT.PUT_LINE(datUno.NOMBRE_COMPLETO.NOMBRE);
    DBMS_OUTPUT.PUT_LINE(datUno.DOMICILIO.TIPODEVIA);
    DBMS_OUTPUT.PUT_LINE(datUno.CODIGO_POSTAL.LOCALIDAD);
    DBMS_OUTPUT.PUT_LINE(datUno.FECHA_NACIMIENTO);
END;