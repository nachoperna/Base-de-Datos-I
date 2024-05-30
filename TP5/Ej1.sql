-- A. Considerando que las tablas ya se encuentran creadas con sus correspondientes PRIMARY KEY declaradas, escriba las sentencias de alteración de tabla que incorporan las RIRs 
ALTER TABLE TRABAJA_EN
		ADD CONSTRAINT FK_R1 FOREIGN KEY (TipoE, NroE) REFERENCES EMPLEADO (TipoE, NroE)
		ON DELETE CASCADE
		ON UPDATE RESTRICT;
	
	ALTER TABLE TRABAJA_EN
		ADD CONSTRAINT FK_R2 FOREIGN KEY (IdProy) REFERENCES PROYECTO (IdProy) 
		ON DELETE RESTRICT
		ON UPDATE CASCADE;
			
	ALTER TABLE AUSPICIO 
		ADD CONSTRAINT FK_R3 CONSTRAINT (IdProy) REFERENCES PROYECTO (IdProy)
		ON DELETE RESTRICT
		ON UPDATE RESTRICT;
			
	ALTER TABLE AUSPICIO
		ADD CONSTRAINT FK_R4 FOREIGN KEY (IdProy) REFERENCES PROYECTO (IdProy)
		ON DELETE NULL
		ON UPDATE RESTRICT;

-- B. Suponga la existencia de las siguientes tuplas en las respectivas tablas (sólo se incluyen los atributos que se consideran relevantes para el ejercicio):
    --Empleado (A, 1,…) ; (B, 2,…) ; (A, 2,…)          Proyecto: (1,…) ; (2,…) ; (3,…) 
    --Trabaja_En (A, 1, 1, ….); (A, 2, 2, ….)             Auspicio: (2, ..., A, 2)
  /*Indique el resultado de las siguientes operaciones teniendo en cuenta las acciones referenciales e instancias dadas. En caso de que la operación no se pueda realizar, determine qué regla/s entra/n en conflicto y cuál es la causa. De ser aceptada, comente el resultado que produciría. 
    NOTA: en cada caso considere el efecto sobre la instancia original de la BD; es decir, los resultados no son acumulativos*/ 

    -- b.1) delete from Proyecto where IdProy = 3; 
       /* En tabla TRABAJA_EN rechaza la operacion porque tiene como accion referencial RESTRICT y su clave esta siendo referenciada 
          En tabla AUSPICIO setea el atributo IdProy en NULL*/
