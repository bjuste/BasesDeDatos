/*7*/
CREATE OR REPLACE FUNCTION numeroEntero (numero NUMBER)
RETURN VARCHAR2 IS
numeroComparado NUMBER(5) := numero;
resultado VARCHAR2(100);
BEGIN
    IF MOD(numero, 2) = 0 THEN
        resultado := 'El número es par';
    ELSE
        resultado := 'El número es impar';
    END IF;
    
    return resultado;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN 'Imposible calcular';
END;

/*COMPROBAR*/
DECLARE
    vResultado VARCHAR2(200);
BEGIN
    vResultado := numeroEntero(2);
    DBMS_OUTPUT.PUT_LINE(vResultado);
END;