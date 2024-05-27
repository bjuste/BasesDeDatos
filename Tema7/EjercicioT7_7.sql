set serveroutput on;
DECLARE
    dom1 tdomicilio := new tdomicilio('Plaza', 'Espania', 103, '1oA');
    cod1 tcodpostal := new tcodpostal(003, 28);
    nombre tnombrecompleto := new tnombrecompleto('Dolores', 'SANCHEZ', 'GOMEZ');
    profesorUno profesor := new profesor (101,nombre,dom1,cod1,sysdate,'1/9/2021');

    dom2 tdomicilio := new tdomicilio('golondrinas', 'pericas', 12, '1oA');
    cod2 tcodpostal := new tcodpostal(660, 28);
    nombre tnombrecompleto := new tnombrecompleto('Luis', 'MARIN', 'SOL');
    alumnoUno alumno := new alumno (201,)
    
BEGIN

    DBMS_OUTPUT.PUT_LINE('Profesor: ');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || profesorUno.NOMBRE_COMPLETO.NOMBRE || ' ' || profesorUno.NOMBRE_COMPLETO.PRAPELLIDO || ' ' || profesorUno.NOMBRE_COMPLETO.SGAPELLIDO);
    DBMS_OUTPUT.PUT_LINE('Fecha de Incorporacion: ' || TO_CHAR(profesorUno.F_INCORPORACION, 'DD/MM/YYYY'));
    
END;