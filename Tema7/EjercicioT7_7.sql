DECLARE
    profesorUno profesor;
    alumnoUno alumno;
BEGIN
    profesorUno := profesor(
        101, TNOMBRECOMPLETO('Dolores', 'SANCHEZ', 'GOMEZ'), TDOMICILIO('Plaza', 'Espa�a', 103, '1oA'), TCODPOSTAL(28003, 28), DATE '2021-09-01'
    );

    alumnoUno := alumno(
        201, TNOMBRECOMPLETO('Luis', 'MARIN', 'SOL'), TDOMICILIO('Calle', 'Laguna', 12, ''), TCODPOSTAL(28660, 28), DATE '2000-01-01', EVALUACIONES(4, 4, 5, 7) 
    );

    DBMS_OUTPUT.PUT_LINE('Profesor: ');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || profesorUno.NOMBRE_COMPLETO.NOMBRE || ' ' || profesorUno.NOMBRE_COMPLETO.PRAPELLIDO || ' ' || profesorUno.NOMBRE_COMPLETO.SGAPELLIDO);
    DBMS_OUTPUT.PUT_LINE('Fecha de Incorporaci�n: ' || TO_CHAR(profesorUno.F_INCORPORACION, 'DD/MM/YYYY'));

    DBMS_OUTPUT.PUT_LINE('Alumno: ');
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || alumnoUno.NOMBRE_COMPLETO.NOMBRE || ' ' || alumno_obj.NOMBRE_COMPLETO.PRAPELLIDO || ' ' || alumnoUno.NOMBRE_COMPLETO.SGAPELLIDO);
    DBMS_OUTPUT.PUT_LINE('Calificaciones:');
    DBMS_OUTPUT.PUT_LINE('Evaluaci�n 1: ' || alumnoUno.CALIFICACIONES.EVALUACIONUNO);
    DBMS_OUTPUT.PUT_LINE('Evaluaci�n 2: ' || alumnoUno.CALIFICACIONES.EVALUACIONDOS);
    DBMS_OUTPUT.PUT_LINE('Evaluaci�n 3: ' || alumnoUno.CALIFICACIONES.EVALUACIONTRES);
    DBMS_OUTPUT.PUT_LINE('Evaluaci�n 4: ' || alumnoUno.CALIFICACIONES.EVALUACIONCUATRO);
END;