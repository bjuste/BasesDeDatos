/*3*/
CREATE OR REPLACE PROCEDURE cadenaReves(vcadena VARCHAR2) AS 
vcad_reves VARCHAR2(80); 
BEGIN 
    FOR i IN REVERSE 1..LENGTH(vcadena) LOOP 
        vcad_reves := vcad_reves || SUBSTR(vcadena,i,1); 
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE(vcad_reves); 
END; 

/*Comprobar que funciona*/
CALL cadenaReves('hola mundo');