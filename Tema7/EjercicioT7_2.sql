SET SERVEROUTPUT ON;
DECLARE
    angelaNombre TNOMBRECOMPLETO := TNOMBRECOMPLETO('ÁNGELA','NEGRO','CASTILLA');
    tomNombre TNOMBRECOMPLETO := TNOMBRECOMPLETO('TOM', 'OXLEY', NULL);
    angelaCodigoPostal TCODPOSTAL := TCODPOSTAL(001, 41);
    tomCodigoPostal TCODPOSTAL := TCODPOSTAL(001, 28);
    angelaDomicilio TDOMICILIO := TDOMICILIO('AVENIDA', 'POSTIGO', 100, '1OA');
    tomDomicilio TDOMICILIO := TDOMICILIO('CALLE','SALADO',114,'21OIZQ BLOQUE 2');
    angelaDatos TDATOSPERSONALES := TDATOSPERSONALES(1, angelaNombre, angelaDomicilio, angelaCodigoPostal, '18/04/1991');
    tomDatos TDATOSPERSONALES := TDATOSPERSONALES(2, tomNombre, tomDomicilio, tomCodigoPostal, '30/05/2024');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Fecha de Nacimiento: ' || angelaDatos.FECHA_NACIMIENTO || 'nombre' || angelaDatos.NOMBRE_COMPLETO.NOMBRE);
end;