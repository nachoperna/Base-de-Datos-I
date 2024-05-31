-- 1. Realice un resumen por país, indicando el nombre del país y la cantidad de voluntarios mayores de edad. Tenga en cuenta sólo aquellos voluntarios que pertenezcan a instituciones con más de 4 voluntarios
SELECT p.nombre_pais, COUNT(*) AS "Cant Voluntario +18"
FROM pais p
JOIN direccion d ON p.id_pais = d.id_pais
JOIN institucion i ON d.id_direccion = i.id_direccion
GROUP BY p.nombre_pais HAVING COUNT(i.id_institucion IN (
 SELECT v.id_institucion FROM voluntario v WHERE extract(year from age(current_date, v.fecha_nacimiento)) >= 18)) > 4;

-- 2. Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ y que además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente por apellido y nombre.
SELECT v.nro_voluntario, v.apellido, v.nombre 
FROM voluntario v
JOIN institucion i ON v.id_institucion = i.id_institucion AND v.nro_voluntario = i.id_director
JOIN direccion USING(id_direccion)
JOIN pais p USING(id_pais) 
JOIN continente c ON p.id_continente = c.id_continente AND c.nombre_continente = 'Europeo'
ORDER BY apellido, nombre;

-- 3. Indique el id y el nombre de las instituciones que tengan más de 4 voluntarios con tareas de no más de 3500 horas estimadas, o que las horas aportadas no superen las 4000.
SELECT DISTINCT i.id_institucion, i.nombre_institucion 
FROM institucion i 
JOIN voluntario v USING(id_institucion) 
JOIN tarea t USING(id_tarea)
GROUP BY i.id_institucion, i.nombre_institucion, v.horas_aportadas HAVING COUNT(
 (t.min_horas+t.max_horas)/2 <= 3500) > 4 OR v.horas_aportadas <= 4000;
 

-- 4. Liste los datos completos de las instituciones en las que se estén ejecutando más del 10% del total de las tareas (distintas).
SELECT i.*, COUNT("Tareas en institucion i") AS "Cantidad tareas"
FROM institucion i 
 JOIN voluntario v USING(id_institucion) 
 JOIN tarea t USING(id_tarea) AS "Tareas en institucion i"
GROUP BY i.id_institucion, i.nombre_institucion, i.id_director, i.id_direccion HAVING COUNT("Tareas en institucion i") > (SELECT DISTINCT COUNT(*) FROM tarea)/10;
 -- soy un fenomeno

-- 5. Liste el nombre y apellido de los voluntarios que pertenecen a instituciones de la provincia ‘Washington’ y donde el director de la institución ha cumplido con 2 o más tareas.
SELECT v.nombre, v.apellido
FROM voluntario v 
 JOIN institucion i USING(id_institucion)
 JOIN direccion d USING(id_direccion)
 JOIN tarea t ON v.nro_voluntario = i.id_director AND v.id_tarea = t.id_tarea
 JOIN historico USING(nro_voluntario)
WHERE d.provincia = 'Washington';
 -- anda a chequearlo re boludito 

SELECT v.nombre, v.apellido
FROM voluntario v
	JOIN institucion i USING(id_institucion)
	JOIN direccion d USING(id_direccion)
WHERE d.provincia = 'Washington'

INTERSECT ALL

SELECT v.nombre, v.apellido
FROM institucion i
	JOIN voluntario v ON i.id_director = v.nro_voluntario
	JOIN tarea t USING(id_tarea)
GROUP BY v.nro_voluntario, v.nombre, v.apellido
	HAVING COUNT(t.id_tarea) > 2;

-- 6. Liste nombre, apellido y teléfono de los 5 voluntarios que han participado en la mayor cantidad de tareas.
SELECT v.nombre, v.apellido, v.telefono, COUNT("Tareas de voluntario v") AS "Cantidad de tareas"
FROM voluntario v JOIN tarea t USING(id_tarea) AS "Tareas de voluntario v"
ORDER BY "Cantidad de tareas" DESC
LIMIT 5;
 -- ordenar en orden DESCENDENTE segun cantidad de tareas realizadas y uso del LIMIT para obtener los primeros 5
