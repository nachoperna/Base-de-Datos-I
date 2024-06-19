-- Tomando el esquema de Voluntarios, resuelva las siguientes consultas en SQL utilizando operadores (o simulando la operación) de Conjuntos. Discuta qué sucede si se incluye el operador ALL.

-- 1. Indique cuáles instituciones tienen solo un voluntario trabajando y ninguna tarea desarrollada -históricamente- hasta el momento.
      SELECT id_institucion
      FROM institucion
      JOIN voluntario v USING(id_institucion)
      GROUP BY id_institucion
      HAVING COUNT(*) = 1
      AND NOT EXISTS (
          SELECT 1
          FROM historico h
          WHERE h.id_institucion = institucion.id_institucion
      );

      SELECT id_institucion, COUNT(*)
      FROM institucion JOIN voluntario v USING(id_institucion) 
      WHERE id_institucion NOT IN (SELECT id_institucion FROM historico) OR id_institucion IN (SELECT id_institucion FROM historico WHERE id_tarea IS NULL)
      GROUP BY id_institucion HAVING COUNT(*)=1;

-- 2. Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ o que son coordinadores, y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente. 
      SELECT nro_voluntario, nombre, apellido
      FROM voluntario
      WHERE nro_voluntario IN
      (SELECT id_director FROM institucion) AND (id_coordinador IS NULL OR id_institucion IN
      (SELECT id_institucion FROM institucion WHERE id_direccion IN
      (SELECT id_direccion FROM direccion WHERE id_pais IN
      (SELECT id_pais FROM pais WHERE id_continente IN
      (SELECT id_continente FROM continente WHERE nombre_continente = 'Europeo')))))
      ORDER BY apellido;

      SELECT v.nro_voluntario, v.nombre, v.apellido
      FROM voluntario v
      WHERE EXISTS
       (SELECT 1 FROM institucion i WHERE i.id_director = v.nro_voluntario)
       INTERSECT
      SELECT v.nro_voluntario, v.nombre, v.apellido
      FROM voluntario v
      WHERE v.id_coordinador IS NULL OR EXISTS
       (SELECT 1 FROM institucion i WHERE v.id_institucion=i.id_institucion AND EXISTS
       (SELECT 1 FROM direccion d WHERE d.id_direccion=i.id_direccion AND EXISTS
       (SELECT 1 FROM pais p WHERE p.id_pais=d.id_pais AND EXISTS
       (SELECT 1 FROM continente c WHERE c.id_continente=p.id_continente AND lower(nombre_continente)='europeo'))));

-- 3. Liste todos los voluntarios que no pertenecen a instituciones ubicadas en el continente Europeo.
      SELECT nro_voluntario, nombre, apellido
      FROM voluntario
      WHERE id_institucion IN
      (SELECT id_institucion FROM institucion WHERE id_direccion IN
      (SELECT id_direccion FROM direccion WHERE id_pais IN
      (SELECT id_pais FROM pais WHERE id_continente IN
      (SELECT id_continente FROM continente WHERE nombre_continente != 'Europeo'))))
      ORDER BY apellido;

      SELECT * FROM voluntario v WHERE EXISTS
      (SELECT 1 FROM institucion i WHERE i.id_institucion=v.id_institucion AND EXISTS
      (SELECT 1 FROM direccion d WHERE d.id_direccion=i.id_direccion AND EXISTS
      (SELECT 1 FROM pais p WHERE p.id_pais=d.id_pais AND NOT EXISTS
      (SELECT 1 FROM continente c WHERE c.id_continente=p.id_continente AND lower(c.nombre_continente)='europeo'))));

-- 4. Indique los voluntarios que históricamente hayan trabajado para todas las instituciones, ordenando el resultado por nombre de voluntario.
      SELECT v.*
      FROM voluntario v
      WHERE NOT EXISTS(
            SELECT i.id_institucion
            FROM institucion i
            EXCEPT
            SELECT 1
            FROM historico h
            WHERE v.id_institucion = h.id_institucion
      )
      ORDER BY v.nombre;
       -- posiblemente mal
-- 5. Determine cuáles tareas se están ejecutando en todas las instituciones.
      SELECT DISTINCT i.id_institucion, t.nombre_tarea 
      FROM institucion i 
       JOIN voluntario v USING(id_institucion) 
       JOIN tarea t USING(id_tarea);
