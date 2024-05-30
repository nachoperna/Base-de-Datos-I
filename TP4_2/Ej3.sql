-- Tomando el esquema de Voluntarios, resuelva las siguientes consultas en SQL utilizando operadores (o simulando la operación) de Conjuntos. Discuta qué sucede si se incluye el operador ALL.

-- 1. Indique cuáles instituciones tienen solo un voluntario trabajando y ninguna tarea desarrollada -históricamente- hasta el momento.
      SELECT id_institucion, COUNT(*) AS "Cantidad voluntarios trabajando"
      FROM institucion 
      GROUP BY id_institucion HAVING COUNT(id_institucion IN
      (SELECT id_institucion FROM voluntario WHERE id_tarea IS NULL AND nro_voluntario NOT IN
      (SELECT nro_voluntario FROM historico))) = 1;

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

      SELECT *
      FROM voluntario v
               JOIN institucion i USING (id_institucion)
               JOIN direccion d USING (id_direccion)
               JOIN pais p USING(id_pais)
               JOIN continente c USING(id_continente)
      WHERE c.nombre_continente != 'Europeo';

-- 3. Liste todos los voluntarios que no pertenecen a instituciones ubicadas en el continente Europeo.
      SELECT nro_voluntario, nombre, apellido
      FROM voluntario
      WHERE id_institucion IN
      (SELECT id_institucion FROM institucion WHERE id_direccion IN
      (SELECT id_direccion FROM direccion WHERE id_pais IN
      (SELECT id_pais FROM pais WHERE id_continente IN
      (SELECT id_continente FROM continente WHERE nombre_continente != 'Europeo'))))
      ORDER BY apellido;
      
-- 4. Indique los voluntarios que históricamente hayan trabajado para todas las instituciones, ordenando el resultado por nombre de voluntario.
      SELECT nro_voluntario, id_institucion FROM historico INTERSECT
      SELECT nro_voluntario, id_institucion FROM voluntario
      ORDER BY nro_voluntario;
      -- creo que mal hecho

-- 5. Determine cuáles tareas se están ejecutando en todas las instituciones.
      
