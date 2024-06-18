-- 9. Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de su jefe, en caso de tenerlo
SELECT 'ID:'||e1.id_empleado||'-'||e1.nombre||', '||e1.apellido AS "Empleado", 'ID:'||e2.id_empleado||'-'||e2.nombre||', '||e2.apellido AS "Jefe", e1.id_jefe AS "id jefe de empleado"
FROM empleado e1 JOIN empleado e2 ON e1.id_jefe = e2.id_empleado
WHERE e1.id_jefe IS NOT NULL;

-- 10. Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids
SELECT id_empleado, nombre, apellido
FROM empleado 
WHERE id_jefe IS NULL AND id_departamento IN
(SELECT id_departamento FROM departamento WHERE id_ciudad IN
(SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Rawalpindi'))
ORDER BY id_empleado;

SELECT e.id_empleado, e.nombre, e.apellido, e.id_jefe, c.nombre_ciudad
FROM empleado e JOIN departamento d USING(id_departamento) JOIN ciudad c ON c.id_ciudad=d.id_ciudad AND c.nombre_ciudad = 'Rawalpindi'
WHERE e.id_jefe IS NULL
ORDER BY e.id_empleado ASC;
 -- en este caso no usamos la clave compuesta de departamento porque los departamentos son unicos en cada ciudad, por lo que solo con el id_departamento basta para linkear una ciudad.

-- 11. Liste los ids y números de inscripción de los distribuidores nacionales que hayan entregado películas en idioma Español luego del año 2010.
SELECT id_distribuidor, nro_inscripcion
FROM nacional
WHERE id_distribuidor IN
(SELECT id_distribuidor FROM distribuidor WHERE id_distribuidor IN
(SELECT id_distribuidor FROM entrega WHERE extract(year from fecha_entrega)>2010 AND nro_entrega IN
(SELECT nro_entrega FROM renglon_entrega WHERE codigo_pelicula IN
(SELECT codigo_pelicula FROM pelicula WHERE idioma = 'Español'))));

-- 12. Liste las películas que nunca han sido entregadas por un distribuidor nacional.
SELECT * 
FROM pelicula
WHERE codigo_pelicula IN
(SELECT codigo_pelicula FROM renglon_entrega WHERE nro_entrega IN
(SELECT nro_entrega FROM entrega WHERE id_distribuidor NOT IN
(SELECT id_distribuidor FROM nacional)));

SELECT DISTINCT p.*
FROM pelicula p
	JOIN renglon_entrega r USING(codigo_pelicula)
	JOIN entrega e USING(nro_entrega)
	JOIN distribuidor d USING(id_distribuidor)
	LEFT JOIN nacional n USING(id_distribuidor)
WHERE n.id_distribuidor IS NULL;
  -- no entiendo muy bien como funciona esta consulta
-- 13. Liste el apellido y nombre de los empleados que trabajan en departamentos residentes en el país Argentina y donde el jefe de departamento posee más del 40% de comisión.
SELECT nombre, apellido, id_empleado
FROM empleado
WHERE (id_departamento, id_distribuidor) IN
(SELECT id_departamento, id_distribuidor FROM departamento WHERE id_ciudad IN
(SELECT id_ciudad FROM ciudad WHERE id_pais IN
(SELECT id_pais FROM pais WHERE lower(nombre_pais) = 'argentina')))
 AND 
id_jefe IN 
(SELECT id_empleado FROM empleado WHERE porc_comision > 40);

SELECT DISTINCT e.nombre, e.apellido
FROM empleado e JOIN departamento USING(id_departamento,id_distribuidor) JOIN ciudad USING(id_ciudad) JOIN pais p USING(id_pais)
WHERE lower(p.nombre_pais)='argentina' AND e.id_jefe IN
(SELECT id_empleado FROM empleado WHERE porc_comision > 40);

-- 14. Indique los departamentos (nombre e identificador completo) que tienen más de 3 empleados con tareas con sueldo mínimo menor a 6000. Muestre el resultado ordenado por distribuidor
SELECT nombre, id_departamento, id_distribuidor
FROM departamento
WHERE (id_departamento,id_distribuidor) IN
(SELECT id_departamento, id_distribuidor FROM empleado WHERE id_tarea IN
(SELECT id_tarea FROM tarea WHERE sueldo_minimo < 6000))
GROUP BY nombre, id_departamento, id_distribuidor HAVING COUNT(*) > 3
ORDER BY id_distribuidor;

SELECT d.nombre, d.id_departamento, d.id_distribuidor
FROM departamento d JOIN empleado e USING(id_departamento,id_distribuidor) JOIN tarea t USING(id_tarea)
WHERE t.sueldo_minimo < 6000
GROUP BY d.nombre, d.id_departamento, d.id_distribuidor, t.id_tarea HAVING COUNT(*) > 3;

-- 15. Liste los datos de los departamentos en los que trabajan menos del 10 % de los empleados que hay registrados
SELECT d.*
FROM departamento d JOIN empleado e USING(id_departamento,id_distribuidor)
GROUP BY d.id_departamento, d.id_distribuidor HAVING COUNT(e.*) < (SELECT COUNT(*)/10 FROM empleado);
