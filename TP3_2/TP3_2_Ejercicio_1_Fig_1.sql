-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-02 12:57:15.971

-- tables
-- Table: ARTICULO
CREATE TABLE ARTICULO (
    id_articulo int  NOT NULL,
    titulo varchar(30)  NOT NULL,
    autor varchar(30)  NOT NULL,
    fecha_pub date  NOT NULL,
    CONSTRAINT AK_TITULO UNIQUE (titulo) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT PK_ARTICULO PRIMARY KEY (id_articulo)
);

-- Table: CONTIENE
CREATE TABLE CONTIENE (
    ARTICULO_id_articulo int  NOT NULL,
    PALABRA_cod_p int  NOT NULL,
    PALABRA_idioma char(2)  NOT NULL,
    CONSTRAINT PK_CONTIENE PRIMARY KEY (ARTICULO_id_articulo,PALABRA_cod_p,PALABRA_idioma)
);

-- Table: PALABRA
CREATE TABLE PALABRA (
    cod_p int  NOT NULL,
    idioma char(2)  NOT NULL,
    descripcion varchar(25)  NOT NULL,
    CONSTRAINT PK_PALABRA PRIMARY KEY (cod_p,idioma)
);

-- foreign keys
-- Reference: CONTIENE_ARTICULO (table: CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT CONTIENE_ARTICULO
    FOREIGN KEY (ARTICULO_id_articulo)
    REFERENCES ARTICULO (id_articulo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: CONTIENE_PALABRA (table: CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT CONTIENE_PALABRA
    FOREIGN KEY (PALABRA_cod_p, PALABRA_idioma)
    REFERENCES PALABRA (cod_p, idioma)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

