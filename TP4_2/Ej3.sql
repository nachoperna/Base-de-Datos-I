-- Tomando el esquema de Voluntarios, resuelva las siguientes consultas en SQL utilizando operadores (o simulando la operación) de Conjuntos. Discuta qué sucede si se incluye el operador ALL.

-- 1. Indique cuáles instituciones tienen solo un voluntario trabajando y ninguna tarea desarrollada -históricamente- hasta el momento.
      SELECT id_institucion, COUNT(*) AS "Cantidad voluntarios trabajando"
      FROM institucion 
      GROUP BY id_institucion HAVING COUNT(id_institucion IN
      (SELECT id_institucion FROM voluntario WHERE id_tarea IS NULL AND nro_voluntario NOT IN
      (SELECT nro_voluntario FROM historico))) = 1;

-- 2. Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ o que son coordinadores, y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente. 
      
      
