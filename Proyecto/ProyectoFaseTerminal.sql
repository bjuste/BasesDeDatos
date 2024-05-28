Set SERVEROUTPUT ON;

--se han tenido que añadir estos dos campos a la tabla ticket
Alter table TICKET ADD precio NUMBER(10,3);
Alter table TICKET ADD cantidad NUMBER(5);
Alter table VENTA MODIFY PRECIOPRODUCTO NUMBER(10,3);

/*DECLARE
    vNombreCamarero VARCHAR2(30) := 'javi61';
    vDniTrabajador VARCHAR2(9) := '07894125S';
    vCodProducto VARCHAR2(100) := '16'; 
    vDescuento VARCHAR2(5);
    vTotalDescuento NUMBER;
    vCodigoEmpleado NUMBER;
    vNumeroTicket NUMBER;
    vCantidad NUMBER := 1;
    vPrecioProducto NUMBER;
    vPrecioDescuento NUMBER;
    vStock NUMBER;
    vFechaVenta DATE := SYSDATE;
    vProductoID NUMBER;
BEGIN
    Begin
        --Guardamos en la variable descuento el descuento del empleado que esta pidiendo, si no existe saltara una excepcion por que no existira el trabajador
        SELECT descuento INTO vDescuento FROM Empleado where dni = vDniTrabajador;
        
        SELECT SUM(d.porcentaje) INTO vTotalDescuento FROM Empleado e JOIN Descuento d ON e.descuento = d.codDescuento where e.dni = vDniTrabajador;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontro ningun trabajador con el dni');
END;

    BEGIN
     -- Sumamos los descuentos de la tabla Descuento asociados al trabajador
        SELECT SUM(d.porcentaje) INTO vTotalDescuento 
        FROM Empleado e
        JOIN Descuento d ON e.descuento = d.codDescuento 
        WHERE e.dni = vDniTrabajador;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontraron descuentos para el trabajador especificado.');
    END;

    BEGIN
        -- Validamos si existe el camarero y obtenemos su cï¿½digo de empleado
        SELECT codEmpleado INTO vCodigoEmpleado 
        FROM Camarero 
        WHERE nombreUsuario = vNombreCamarero;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontrï¿½ ningï¿½n camarero con el nombre de usuario especificado.');
    END;

    BEGIN
        --cogemnos el maximo de nuestro numero de ticket y le sumamos uno para generar el ticket de la venta
        SELECT NVL(MAX(numTicket), 0) + 1 Into vNumeroTicket FROM venta;
        --devuelve el valor de la primera expresion que no es nula en una serie de expresiones
        dbms_output.put_line(vNumeroTicket);
    END;

    -- Convertimos el codigo de producto a numero
    vProductoID := vCodProducto;

    BEGIN
        SELECT stock INTO vStock FROM producto WHERE codProducto = vProductoID;
        --validamos el stock
        IF vStock < 1 THEN
            dbms_output.put_line('no hay suficiente stock');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontro el producto con el codigo asociado');
    END;

    BEGIN
        SELECT precio INTO vPrecioProducto
        FROM Producto
        WHERE codProducto = vProductoID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('no se encontro el precio del producto');
    END;

    -- Calculamos el precio con el descuento aplicado
    vPrecioDescuento := vPrecioProducto - (vPrecioProducto * (vTotalDescuento / 100));

    -- Insertamos en la tabla VENTA
    BEGIN
        -- Insertamos en la tabla VENTA
        INSERT INTO Venta (numTicket, fecha, precioProducto, cantidadProducto, codEmpleado, dni) 
        VALUES (vNumeroTicket, vFechaVenta, vPrecioDescuento, vCantidad, vCodigoEmpleado, vDniTrabajador);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al insertar en la venta.');
            RETURN;
    END;
    -- Insertamos en la tabla ticket
    BEGIN
        -- Insertamos en la tabla ticket
        INSERT INTO ticket (codProducto, numTicket, precio, cantidad) 
        VALUES (vProductoID, vNumeroTicket, vPrecioProducto, vCantidad);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al insertar el ticket.');
            RETURN;
    END;
    -- Actualizamos el stock del producto
    BEGIN
        -- Actualizamos el stock del producto
        UPDATE Producto 
        SET stock = stock - 1 
        WHERE codProducto = vProductoID;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al actualizar el stock del producto.');
            RETURN;
    END;
    
    -- Mostramos un mensaje indicando que la operacion fue exitosa
    DBMS_OUTPUT.PUT_LINE('Venta realizada con exito. Numero de ticket: ' || vNumeroTicket);
    DBMS_OUTPUT.PUT_LINE('Descuento aplicado: ' || vTotalDescuento || '%');
    DBMS_OUTPUT.PUT_LINE('Precio final del producto: ' || vPrecioDescuento);
END;
*/

CREATE OR REPLACE PROCEDURE ventaUnProducto(
    vNombreCamarero VARCHAR2,
    vDniTrabajador VARCHAR2,
    vCodProducto VARCHAR2
) AS 
    vDescuento VARCHAR2(5);
    vTotalDescuento NUMBER;
    vCodigoEmpleado NUMBER;
    vNumeroTicket NUMBER;
    vCantidad NUMBER := 1;
    vPrecioProducto NUMBER;
    vPrecioDescuento NUMBER;
    vStock NUMBER;
    vFechaVenta DATE := SYSDATE;
    vProductoID NUMBER;
BEGIN
Begin
        --Guardamos en la variable descuento el descuento del empleado que esta pidiendo, si no existe saltara una excepcion por que no existira el trabajador
        SELECT descuento INTO vDescuento FROM Empleado where dni = vDniTrabajador;
        
        SELECT SUM(d.porcentaje) INTO vTotalDescuento FROM Empleado e JOIN Descuento d ON e.descuento = d.codDescuento where e.dni = vDniTrabajador;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontro ningun trabajador con el dni');
    END;

    BEGIN
     -- Sumamos los descuentos de la tabla Descuento asociados al trabajador
        SELECT SUM(d.porcentaje) INTO vTotalDescuento 
        FROM Empleado e
        JOIN Descuento d ON e.descuento = d.codDescuento 
        WHERE e.dni = vDniTrabajador;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontraron descuentos para el trabajador especificado.');
    END;

    BEGIN
        -- Validamos si existe el camarero y obtenemos su codigo de empleado
        SELECT codEmpleado INTO vCodigoEmpleado 
        FROM Camarero 
        WHERE nombreUsuario = vNombreCamarero;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontrï¿½ ningï¿½n camarero con el nombre de usuario especificado.');
    END;

    BEGIN
        --cogemnos el maximo de nuestro numero de ticket y le sumamos uno para generar el ticket de la venta
        SELECT NVL(MAX(numTicket), 0) + 1 Into vNumeroTicket FROM venta;
        --devuelve el valor de la primera expresion que no es nula en una serie de expresiones
        dbms_output.put_line(vNumeroTicket);
    END;

    -- Convertimos el codigo de producto a numero
    vProductoID := vCodProducto;

    BEGIN
        SELECT stock INTO vStock FROM producto WHERE codProducto = vProductoID;
        --validamos el stock
        IF vStock < 1 THEN
            dbms_output.put_line('no hay suficiente stock');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('No se encontro el producto con el codigo asociado');
    END;

    BEGIN
        SELECT precio INTO vPrecioProducto
        FROM Producto
        WHERE codProducto = vProductoID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('no se encontro el precio del producto');
    END;

    -- Calculamos el precio con el descuento aplicado
    vPrecioDescuento := vPrecioProducto - (vPrecioProducto * (vTotalDescuento / 100));

    -- Insertamos en la tabla VENTA
    BEGIN
        -- Insertamos en la tabla VENTA
        INSERT INTO Venta (numTicket, fecha, precioProducto, cantidadProducto, codEmpleado, dni) 
        VALUES (vNumeroTicket, vFechaVenta, vPrecioDescuento, vCantidad, vCodigoEmpleado, vDniTrabajador);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al insertar en la venta.');
            RETURN;
    END;
    -- Insertamos en la tabla ticket
    BEGIN
        -- Insertamos en la tabla ticket
        INSERT INTO ticket (codProducto, numTicket, precio, cantidad) 
        VALUES (vProductoID, vNumeroTicket, vPrecioProducto, vCantidad);
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al insertar el ticket.');
            RETURN;
    END;
    -- Actualizamos el stock del producto
    BEGIN
        -- Actualizamos el stock del producto
        UPDATE Producto 
        SET stock = stock - 1 
        WHERE codProducto = vProductoID;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error al actualizar el stock del producto.');
            RETURN;
    END;
    
    -- Mostramos un mensaje indicando que la operacion fue exitosa
    DBMS_OUTPUT.PUT_LINE('Venta realizada con exito. Numero de ticket: ' || vNumeroTicket);
    DBMS_OUTPUT.PUT_LINE('Descuento aplicado: ' || vTotalDescuento || '%');
    DBMS_OUTPUT.PUT_LINE('Precio final del producto: ' || vPrecioDescuento);
END;

--comprobar que funciona el procedimiento
BEGIN
    ventaUnProducto('carlos55', '71450369F', '15');
END;