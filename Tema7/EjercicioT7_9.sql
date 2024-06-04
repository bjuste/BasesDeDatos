SET SERVEROUTPUT ON;

DECLARE
    policia1 POLICIA;
    policia2 POLICIA;
    salario_final NUMBER;
BEGIN

    policia1 := Policia('87654321B', 'Bruno', 'Juste', 'Perez', '600654321', 'LOCAL', 2000);
    insert into policias values (policia1);

    policia2 := Policia('14523687B', 'Pedro', 'martin', 'martin', 654321987, 'NACIONAL', 2000);
    insert into policias values (policia2);

    update policias set salario_base = policia1.calculaSalario(policia1.salario_base) where dni = policia1.dni;
    update policias set salario_base = policia2.calculaSalario(policia2.salario_base) where dni = policia2.dni;


    DBMS_OUTPUT.PUT_LINE('Nombre: ' || policia1.NOMBRE);
    DBMS_OUTPUT.PUT_LINE('Salario Final: ' || policia1.salario_base);
    
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || policia2.NOMBRE);
    DBMS_OUTPUT.PUT_LINE('Salario Final: ' || policia2.salario_base);
END;
