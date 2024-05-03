/*8*/
CREATE OR REPLACE PROCEDURE diasSemana (diaSemana NUMBER)
IS
numeroDiaSemana NUMBER(1) := diaSemana;
BEGIN
    IF numeroDiaSemana = 1 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el lunes');
    ELSIF numeroDiaSemana = 2 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el martes');
    ELSIF numeroDiaSemana = 3 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el miercoles');
    ELSIF numeroDiaSemana = 4 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el jueves');
    ELSIF numeroDiaSemana = 5 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el viernes');
    ELSIF numeroDiaSemana = 6 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el sabado');
    ELSIF numeroDiaSemana = 7 THEN
        DBMS_OUTPUT.PUT_LINE('El numero ' || numeroDiaSemana || ' es el domingo');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Dia semana no valido');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al procesar el día de la semana');
END;

/*COMPROBAR*/
CALL diasSemana(0);