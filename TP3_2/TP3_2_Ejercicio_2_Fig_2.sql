-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-02 15:17:40.522

-- tables
-- Table: CAMA
CREATE TABLE CAMA (
    HABITACION_id_hab int  NOT NULL,
    id_cama int  NOT NULL,
    tipo_cama varchar(15)  NOT NULL,
    fecha_compra date  NOT NULL,
    CONSTRAINT PK_ID_HAB_CAMA PRIMARY KEY (id_cama,HABITACION_id_hab)
);

-- Table: FECHA
CREATE TABLE FECHA (
    OCUPA_TURISTA_id_turista int  NOT NULL,
    OCUPA_CAMA_id_cama int  NOT NULL,
    fecha_ini date  NOT NULL,
    fecha_fin date  NULL,
    CONSTRAINT PK_FECHA PRIMARY KEY (OCUPA_TURISTA_id_turista,OCUPA_CAMA_id_cama)
);

-- Table: HABITACION
CREATE TABLE HABITACION (
    id_hab int  NOT NULL,
    tipo_hab varchar(15)  NOT NULL,
    capacidad int  NOT NULL,
    CONSTRAINT PK_ID_HAB PRIMARY KEY (id_hab)
);

-- Table: OCUPA
CREATE TABLE OCUPA (
    TURISTA_id_turista int  NOT NULL,
    CAMA_id_cama int  NOT NULL,
    CAMA_HABITACION_id_hab int  NOT NULL,
    CONSTRAINT PK_CAMA_TURISTA PRIMARY KEY (TURISTA_id_turista,CAMA_id_cama)
);

-- Table: TURISTA
CREATE TABLE TURISTA (
    id_turista int  NOT NULL,
    pasaporte varchar(20)  NOT NULL,
    pais varchar(40)  NOT NULL,
    nombre varchar(30)  NOT NULL,
    CONSTRAINT AK_PASAPORTE UNIQUE (pasaporte) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT PK_ID_TURISTA PRIMARY KEY (id_turista)
);

-- foreign keys
-- Reference: CAMA_HABITACION (table: CAMA)
ALTER TABLE CAMA ADD CONSTRAINT CAMA_HABITACION
    FOREIGN KEY (HABITACION_id_hab)
    REFERENCES HABITACION (id_hab)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FECHA_OCUPA (table: FECHA)
ALTER TABLE FECHA ADD CONSTRAINT FECHA_OCUPA
    FOREIGN KEY (OCUPA_TURISTA_id_turista, OCUPA_CAMA_id_cama)
    REFERENCES OCUPA (TURISTA_id_turista, CAMA_id_cama)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: OCUPA_CAMA (table: OCUPA)
ALTER TABLE OCUPA ADD CONSTRAINT OCUPA_CAMA
    FOREIGN KEY (CAMA_id_cama, CAMA_HABITACION_id_hab)
    REFERENCES CAMA (id_cama, HABITACION_id_hab)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: OCUPA_TURISTA (table: OCUPA)
ALTER TABLE OCUPA ADD CONSTRAINT OCUPA_TURISTA
    FOREIGN KEY (TURISTA_id_turista)
    REFERENCES TURISTA (id_turista)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

