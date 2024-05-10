/*1*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE mostrarValor(vValor IN VARCHAR2)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('EL VALOR ES: ' || vValor);
END;

/*COMPROBAR QUE FUNCIONA*/
BEGIN
  mostrarValor('Hola, mundo');
END;

CALL mostrarValor('que tal');