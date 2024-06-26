CREATE TABLE TIPOSDP(
    CODTIPO NUMBER (4),
    DESCRIPCION VARCHAR(40) NOT NULL,
    
    CONSTRAINT PK_TIPOSDP PRIMARY KEY (CODTIPO)
);

ALTER TABLE DATOSPERSONALES MODIFY DATOSPERSOANLES.TELEFONO NOT NULL;
ALTER TABLE DATOSPERSONALES MODIFY DATOSPERSOANLES.CORREO NOT NULL;
ALTER TABLE DATOSPERSONALES ADD CONSTRAINT FK_TIPO FOREIGN KEY(TIPO) REFERENCES TIPOSDP(CODTIPO);


ALTER TABLE DIRECTOR ADD ANIOS NUMBER(2) NOT NULL);

ALTER TABLE COMERCIAL DROP COLUMN COMISION;

ALTER TABLE OFICINA ADD COMISION NUMBER(3);

CREATE TABLE TURNO(
    CODTURNO NUMBER(4),
    DESCRIPCION VARCHAR(30) NOT NULL,

    CONSTRAINT PK_TURNO PRIMARY KEY (CODTURNO)
);

ALTER TABLE VENDEDOR ADD CONSTRAINT FK_TURNO FOREIGN KEY (TURNO) REFERENCES TURNO(CODTURNO);

CREATE TABLE TEMATICALIBRO(
    CODTEM NUMBER(4),
    DESCRIPCION VARCHAR(30) NOT NULL,
    
    CONSTRAINT PK_TEMATICA PRIMARY KEY (CODTEM)
);

ALTER TABLE LIBRO DROP COLUMN TEMATICA;
ALTER TABLE LIBRO ADD CODTEM NUMBER(4);


ALTER TABLE LIBRO ADD CONSTRAINT FK_TEMATICALIBRO FOREIGN KEY (CODTEM) REFERENCES TEMATICALIBRO(CODTEM);