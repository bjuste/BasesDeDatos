/*2*/
CREATE OR REPLACE FUNCTION division(num1 IN NUMBER, num2 IN NUMBER) RETURN NUMBER AS
BEGIN
    RETURN num1/num2;
    EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Error: No se puede dividir por cero.');
    RETURN 0;
END;

/*COMPROBAR QUE FUNCIONA*/
DECLARE
  resultado NUMBER;
BEGIN
  resultado := division(10, 2); -- Debería devolver 5
  DBMS_OUTPUT.PUT_LINE('Resultado de 10 / 2: ' || resultado);
  
  resultado := division(8, 4); -- Debería devolver 2
  DBMS_OUTPUT.PUT_LINE('Resultado de 8 / 4: ' || resultado);
  
  resultado := division(-12, 3); -- Debería devolver -4
  DBMS_OUTPUT.PUT_LINE('Resultado de -12 / 3: ' || resultado);
  
  resultado := division(5, 0); -- Debería devolver 0
  DBMS_OUTPUT.PUT_LINE('Resultado de 5 / 0: ' || resultado);
END;
