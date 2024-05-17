CREATE OR REPLACE FUNCTION AREA (vRadio IN NUMBER) RETURN NUMBER IS
    vArea NUMBER;
    vPi CONSTANT NUMBER := 3.141592;
BEGIN
    vArea := POWER(vRadio,2) * vPi;
    RETURN vArea;
END;


DECLARE
    vRadio NUMBER := 10; 
    vArea NUMBER;
BEGIN
    vArea := AREA(vRadio); 
    dbms_output.put_line('El área del círculo con radio ' || vRadio || ' es: ' || vArea);
END;