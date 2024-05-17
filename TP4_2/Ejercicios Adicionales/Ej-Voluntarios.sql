-- 1. Realice un resumen por país, indicando el nombre del país y la cantidad de voluntarios mayores de edad. Tenga en cuenta sólo aquellos voluntarios que pertenezcan a instituciones con más de 4 voluntarios
SELECT p.nombre_pais, COUNT(*) AS "Cant Voluntario +18"
FROM pais p
JOIN direccion d ON p.id_pais = d.id_pais
JOIN institucion i ON d.id_direccion = i.id_direccion
JOIN voluntario v ON i.id_institucion = v.id_institucion
WHERE extract(year from age(current_date, v.fecha_nacimiento)) >= 18
GROUP BY p.nombre_pais;

-- 2. Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente por apellido y nombre.
SELECT v.nro_voluntario, v.apellido, v.nombre 
FROM voluntario v
JOIN institucion i ON v.id_institucion = i.id_institucion AND v.nro_voluntario = i.id_director
JOIN direccion d ON i.id_direccion = d.id_direccion
JOIN pais p ON d.id_pais = p.id_pais 
JOIN continente c ON p.id_continente = c.id_continente AND c.nombre_continente = 'Europeo'
ORDER BY apellido, nombre;

-- 3. Indique el id y el nombre de las instituciones que tengan más de 4 voluntarios con tareas de no más de 3500 horas estimadas, o que las horas aportadas no superen las 4000.
SELECT i.id_institucion, i.nombre_institucion 
FROM institucion i 
JOIN voluntario v ON v.id_institucion = i.id_institucion 
JOIN tarea t ON t.id_tarea = v.id_tarea
GROUP BY i.id_institucion, i.nombre_institucion HAVING COUNT(
 v.horas_aportadas <= 4000) > 4 OR AVG(t.min_horas+t.max_horas) <= 3500;
  -- creo que asi tmb considera a grupos de MENOS de 4 voluntarios donde el promedio de horas de su tarea es menor a 3500

-- 4. Liste los datos completos de las instituciones en las que se estén ejecutando más del 10% del total de las tareas (distintas).
SELECT *
FROM institucion
WHERE id_institucion IN
(SELECT id_institucion FROM voluntario v WHERE v.id_tarea IN
(SELECT t.id_tarea FROM tarea t GROUP BY t.id_tarea HAVING COUNT(t.id_tarea = v.id_tarea) > COUNT(*)));
 -- no funca
