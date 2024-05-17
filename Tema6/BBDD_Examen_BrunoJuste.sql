
CREATE TABLE departamento(
  id_departamento NUMBER NOT NULL,
  nombre varchar(30),
  presupuesto NUMBER,
  CONSTRAINT pk_departamento PRIMARY KEY (id_departamento)
);


CREATE TABLE empleados(
  id_empleado varchar(8) NOT NULL,
  nombre varchar(30),
  apellidos varchar(30),
  id_departamento NUMBER,
  CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
  CONSTRAINT empleados_fk FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE datospersonales (
  dni varchar(10) NOT NULL,
  oficina varchar(30),
  fecha_alta date,
  contrato varchar(30) ,
  clave_empleado varchar(30) ,
  CONSTRAINT pk_datospersonales PRIMARY KEY (dni),
  CONSTRAINT datospersonales_fk FOREIGN KEY (clave_empleado) REFERENCES empleados(id_empleado)
);

-------
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('09562145H','Valladolid','23/01/2010','Indefinido','EMP01');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('11732525R','Madrid Central','22/08/2018','Indefinido','EMP09');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('16220446D','Valladolid','12/12/2021','Practicas','EMP04');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('26135448K','Madrid Central','01/01/2022','Temporal','EMP02');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('44513677P','Valladolid','26/07/2022','Indefinido','EMP07');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('55871366V','Madrid Norte','30/04/2016','Temporal','EMP06');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('70644119B','Madrid Central','20/02/2020','Temporal','EMP05');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('71039445T','Madrid Sur','01/03/2023','Temporal','EMP08');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('71045896C','Madrid Norte','12/12/2021','Practicas','EMP10');
INSERT INTO DATOSPERSONALES(dni,oficina,fecha_alta,contrato,clave_empleado) VALUES ('71569883M','Madrid Sur','19/07/2002','Indefinido','EMP03');

-----
INSERT INTO DEPARTAMENTO (id_departamento,nombre,presupuesto) VALUES (1,'Personal',80000);
INSERT INTO DEPARTAMENTO (id_departamento,nombre,presupuesto) VALUES (2,'Almacen',70000);
INSERT INTO DEPARTAMENTO (id_departamento,nombre,presupuesto) VALUES (3,'Contabilidad',60000);
INSERT INTO DEPARTAMENTO (id_departamento,nombre,presupuesto) VALUES (4,'Manufactura',50000);
INSERT INTO DEPARTAMENTO (id_departamento,nombre,presupuesto) VALUES (5,'Empaque',30000);
------
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP01','Armando','Lopez',2);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP02','Tatiana','Vargas',1);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP03','Laura','Garcia',3);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP04','Juan','Perez',4);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP05','Ivan','Lopez',4);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP06','Margarita','Hernandez',1);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP07','Jesus','Perez',3);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP08','Antonio','Flores',2);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP09','Juan','Medina',4);
INSERT INTO empleados(id_empleado,nombre,apellidos,id_departamento) VALUES ('EMP10','Pedro','Hernandez',5);

/*3 - Ejercicio 1 - Crea un bloque PL/SQL en el que se declaren tres variables*/
SET SERVEROUTPUT ON

DECLARE
    v_dni datospersonales.dni%type;
    v_num NUMBER;
    v_letra CHAR(1);
    v_nombre empleados.nombre%type;
BEGIN
    SELECT dt.dni, e.nombre INTO v_dni, v_nombre FROM datospersonales dt JOIN empleados e ON dt.clave_empleado = e.id_empleado WHERE dt.fecha_alta = (SELECT MAX(fecha_alta) FROM datospersonales); 
    dbms_output.put_line('El trabajador/a ' || v_nombre || ' con DNI es ' || v_dni || ' es el/la que más lleva trabajando en la empresa');
    v_letra := SUBSTR(v_nombre, LENGTH(v_nombre), 1);
    SELECT COUNT(*)INTO v_num FROM empleados  WHERE SUBSTR(nombre, LENGTH(nombre), 1) = v_letra;
    dbms_output.put_line('Hay ' || v_num || ' empleados cuyo nombre termina en ' || v_letra);
END;

/*4 - Ejercicio 2 - Crea un bloque PL/SQL en el que*/

ACCEPT nombre_dept PROMPT 'Introduce el nombre de un departamento';

DECLARE
    CURSOR c_empleados IS
        SELECT dni
        FROM datospersonales;

    TYPE t_departamentos IS VARRAY(5) OF VARCHAR2(30);
    t_depar t_departamentos := t_departamentos('Personal', 'Almacen', 'Contabilidad', 'Manufactura', 'Empaque');
    
    v_dept departamento.nombre%TYPE := UPPER('&nombre_dept');
    v_nombre_dept departamento.nombre%TYPE;
    v_contador NUMBER := 0;
    v_num NUMBER:= 0;
    
    ValoresIncorrectos EXCEPTION;
    
BEGIN
    /*No he sabido sacarlo como me habias dicho te lo dejo como estaba*/
    SELECT nombre INTO v_nombre_dept
    FROM departamento
    WHERE UPPER(nombre) = v_dept;

    IF SQL%NOTFOUND THEN
        RAISE ValoresIncorrectos;
    END IF;

    FOR emp IN c_empleados LOOP
        SELECT COUNT(*)
        INTO v_contador
        FROM datospersonales dp
        JOIN empleados e ON dp.clave_empleado = e.id_empleado
        WHERE dp.dni = emp.dni 
        AND e.id_departamento = (SELECT id_departamento FROM departamento WHERE UPPER(nombre) = v_dept);
        
        v_num := v_num + v_contador;
    END LOOP;

    dbms_output.put_line('El número de personas que pertenecen al departamento de ' || v_nombre_dept || ' son: ' || v_num);

    IF v_contador < 3 THEN
        dbms_output.put_line('Se debe contratar más personas.');
    ELSE
        dbms_output.put_line('No hay vacantes disponibles.');
    END IF;
    
EXCEPTION
    WHEN ValoresIncorrectos THEN
        dbms_output.put_line('El valor introducido no es correcto.');
END;

/*Ejercicio 5 - Transforma el ejercicio 4 en un procedimiento llamado p_empleados, que necesita como variable de entrada el nombre del departamento. EJecutalo y comprueba que funciona correctamente*/

CREATE OR REPLACE PROCEDURE p_empleados (v_nombre_dept IN departamento.nombre%TYPE) AS
    CURSOR c_empleados IS
        SELECT dni
        FROM datospersonales;

    v_dept departamento.nombre%TYPE := UPPER(v_nombre_dept);
    v_nombre_dept_total departamento.nombre%TYPE;
    v_contador NUMBER := 0;
    v_num NUMBER:= 0;
    
    ValoresIncorrectos EXCEPTION;
BEGIN
    /*No he sabido sacarlo como me habias dicho te lo dejo como estaba*/
    SELECT nombre INTO v_nombre_dept_total
    FROM departamento
    WHERE UPPER(nombre) = v_dept;

    IF SQL%NOTFOUND THEN
        RAISE ValoresIncorrectos;
    END IF;

    FOR emp IN c_empleados LOOP
        SELECT COUNT(*)
        INTO v_contador
        FROM datospersonales dp
        JOIN empleados e ON dp.clave_empleado = e.id_empleado
        WHERE dp.dni = emp.dni
        AND e.id_departamento = (SELECT id_departamento FROM departamento WHERE UPPER(nombre) = v_dept);
        
        v_num := v_num + v_contador;
    END LOOP;

    dbms_output.put_line('El número de personas que pertenecen al departamento de ' || v_nombre_dept || ' son: ' || v_num);

    IF v_contador < 3 THEN
        dbms_output.put_line('Se debe contratar más personas.');
    ELSE
        dbms_output.put_line('No hay vacantes disponibles.');
    END IF;
    
EXCEPTION
    WHEN ValoresIncorrectos THEN
        dbms_output.put_line('El valor introducido no es correcto.');
END;

/*Comprobacion*/
BEGIN
    p_empleados('Manufactura'); 
END;

/*Ejercicio 6*/

/*Ejemplo 1*/
CREATE OR REPLACE TRIGGER AnadirEmpleados
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
    dbms_output.put_line('Nuevo empleado:');
    dbms_output.put_line('ID Empleado: ' || :NEW.id_empleado);
    dbms_output.put_line('Nombre: ' || :NEW.nombre);
    dbms_output.put_line('Apellidos: ' || :NEW.apellidos);
    dbms_output.put_line('ID Departamento: ' || :NEW.id_departamento);
END;

/*Comprobar*/
INSERT INTO empleados (id_empleado, nombre, apellidos, id_departamento)
VALUES ('EMP11', 'Bruno', 'Juste', 1);

INSERT INTO empleados (id_empleado, nombre, apellidos, id_departamento)
VALUES ('EMP16', 'Alejandro', 'Lledo', 1);

/*deshabilitar disparador*/
ALTER TRIGGER AnadirEmpleados disable;

/*Ejemplo 2*/
CREATE OR REPLACE TRIGGER ValidarDatosPersonales
BEFORE INSERT OR UPDATE OR DELETE ON datospersonales
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('Insertando nuevo empleado en la tabla datospersonales');
    ELSIF UPDATING THEN
        dbms_output.put_line('Modificando oficina en la tabla datospersonales');
    ELSIF DELETING THEN
        dbms_output.put_line('Eliminando registro en datospersonales.');
    END IF;
END;

/*Comprobar inserccion*/
INSERT INTO datospersonales (dni, oficina, fecha_alta, contrato, clave_empleado)
VALUES ('12345678A', 'Albacete', SYSDATE, 'Indefinido', 'EMP11');

INSERT INTO datospersonales (dni, oficina, fecha_alta, contrato, clave_empleado)
VALUES ('12346678A', 'Albacete', SYSDATE, 'Indefinido', 'EMP16');

/*Comprobar actualizacion*/
UPDATE datospersonales
SET oficina = 'Colombia'
WHERE dni = '12345678A';

UPDATE datospersonales
SET oficina = 'Colombia'
WHERE dni = '12346678A';

/*Comprobar eliminacion*/
DELETE FROM datospersonales
WHERE dni = '12345678A';

DELETE FROM datospersonales
WHERE dni = '12346678A';

/*Deshabilitar Trigger*/
ALTER TRIGGER ValidarDatosPersonales disable;

/*Ejercicio 7 - Crea una funcion f_calculadora con tres variables de entra y una de salida. Dos de las variables de entrada y la de salida son númericas y la otra variable de entra es de tipo alfanumerica*/
CREATE OR REPLACE FUNCTION f_calculadora(
    i_numero1 IN NUMBER,
    i_numero2 IN NUMBER,
    i_operacion IN VARCHAR2
) RETURN NUMBER IS
    o_valor NUMBER;
BEGIN
    CASE UPPER(i_operacion) /*Se pasa a mayusculas*/
        WHEN 'A' THEN /*Realizar Suma*/
            o_valor := i_numero1 + i_numero2;
        WHEN 'E' THEN /*Realizar Resta*/
            o_valor := i_numero1 - i_numero2;
        WHEN 'I' THEN /*Realizar Multiplicacion*/
            o_valor := i_numero1 * i_numero2;
        WHEN 'O' THEN /*Realizar Division*/
                IF i_numero2 = 0 THEN
                    RAISE ZERO_DIVIDE;
                ELSE
                    o_valor := i_numero1 / i_numero2;
                END IF;
        WHEN 'U' THEN /*Realizar Potencia*/
            o_valor := POWER(i_numero1, i_numero2);
        ELSE
            o_valor := 0;
    END CASE;
    
    RETURN o_valor;
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        o_valor := -1;
        RETURN o_valor;
    WHEN OTHERS THEN
        o_valor := -2;
        RETURN o_valor;
END;

/*Comprobar*/
/*Realizar Suma*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 5, 'A');
    dbms_output.put_line('Resultado (suma): ' || resultado); 
END;

/*Realizar Resta*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 5, 'E');
    dbms_output.put_line('Resultado (resta): ' || resultado); 
END;

/*Realizar Multiplicacion*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 5, 'I');
    dbms_output.put_line('Resultado (multiplicacion): ' || resultado);
END;

/*Comprobar Division*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 5, 'O');
    dbms_output.put_line('Resultado (division): ' || resultado); 
END;

/*Comprobar Division entre 0*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 0, 'O');
    dbms_output.put_line('Resultado (division): ' || resultado); 
END;

/*Realizar Potencia*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(2, 3, 'U');
    dbms_output.put_line('Resultado (potencia): ' || resultado); 
END;

/*Otra letra que no esta puesta*/
DECLARE
    resultado NUMBER;
BEGIN
    resultado := f_calculadora(10, 5, 'X');
    dbms_output.put_line('Resultado: ' || resultado);
END;

