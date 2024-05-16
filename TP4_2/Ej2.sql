 -- Interpretación de resultados en consultas en las que intervienen valores nulos

-- 2.1) Considere la siguiente tabla:
    CREATE TABLE Equipo (
    Id 		int NOT NULL,
    puntos		int,
    descripcion 	varchar(20),
  	CONSTRAINT pk_equipo PRIMARY KEY (Id)
    );
    INSERT INTO Equipo(id, puntos) VALUES (1, null), (2, null), (3, null), (4, null);

    -- a) Qué retornan las siguientes consultas?
      /*1*/ SELECT avg(puntos), count(puntos), count(*)
            FROM Equipo;
            -- AVG retorna NULL porque no hay puntos definidos, COUNT(puntos) retorna NULL porque no cuenta las filas nulas a no ser que se especifique, COUNT(*) retorna 4 porque se insertaron 4 equipos en la tabla

      /*2*/ SELECT id, 'Su descripción es '|| descripcion
            FROM equipo
            WHERE puntos NOT IN (select distinct puntos from equipo);
            -- Sin retorno de filas. Consulta sin sentido porque tiene como restriccion que los puntos de cada equipo no esten en la misma tabla de equipos.

      /*3*/ SELECT *
            FROM equipo
            WHERE puntos NOT IN (select distinct puntos from equipo);
            -- Sin retorno de filas. Consulta sin sentido

      /*4*/ SELECT *
            FROM equipo e1 JOIN equipo e2
            ON (e1.puntos = e2.puntos);
            -- Sin retorno de filas. Todos los puntos son NULL en la tabla Equipo, por lo tanto la igualdad no funciona cuando ambos valores son nulos.

    -- b) Modifique la consulta 1 para que devuelva los valores nulos como ceros o blancos.
          SELECT COALESCE(avg(puntos), 0) AS "Avg Puntos", COALESCE(count(puntos), 0) AS "Count Puntos", count(*)
          FROM Equipo;

-- 2.2) ¿Cuáles son los voluntarios que no selecciona la siguiente consulta?
        SELECT nro_voluntario, apellido, nombre
        FROM VOLUNTARIO
        WHERE NOT (porcentaje BETWEEN 0.15 AND 0.30);
        -- NO selecciona los voluntarios donde su porcentaje se encuentre entre 0.15 y 0.30

-- 2.3) Estas dos consultas arrojan los mismos resultados? O sino, cuáles son las diferencias?
        SELECT I.id_institucion, count(*)
        FROM institucion I LEFT JOIN voluntario V
        ON (I. id_institucion = V. id_institucion)
        GROUP BY   I.id_institucion;
        
        SELECT V.id_institucion, count(*)
        FROM institucion I LEFT JOIN voluntario V
        ON (I. id_institucion = V. id_institucion)
        GROUP BY   V.id_institucion;
        -- No arrojan los mismos resultados. 
        -- En la primera consulta nos devuelve la cantidad de voluntarios que pertenecen a determinada institucion habiendo al menos un voluntario como minimo. 
        -- En la segunda consulta...



    
