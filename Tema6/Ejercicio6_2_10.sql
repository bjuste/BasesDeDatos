CREATE OR REPLACE FUNCTION mayor(numero1 IN NUMBER, numero2 IN NUMBER, numero3 IN NUMBER) RETURN NUMBER IS
    vMayor NUMBER;
BEGIN
    IF (numero1 >= numero2 AND numero1 >= numero3) THEN
        vMayor := numero1;
    ELSIF (numero2 >= numero1 AND numero2 >= numero3) THEN
        vMayor := numero2;
    ELSE
        vMayor := numero3;
    END IF;

    RETURN mayor;
EXCEPTION 
    WHEN OTHERS THEN
        dbms_output.put_line('Fallo en el codigo');
END;

DECLARE
    vNumUno NUMBER := 15;
    vNumDos NUMBER := 5;
    vNumTres NUMBER := 50;
    vMayor NUMBER;
BEGIN
    vMayor := mayor(vNumUno, vNumDos, vNumTres); 
    dbms_output.put_line('El numero mayor es: ' || vMayor);
END;