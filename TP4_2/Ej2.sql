-- 9. Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de su jefe, en caso de tenerlo
SELECT e.id_empleado, e.nombre||', '||e.apellido AS "Nombre Empleado", e.id_jefe, e1.nombre||', '||e1.apellido AS "Nombre Jefe"
FROM empleado e JOIN empleado e1 ON e1.id_empleado = e.id_jefe
WHERE e.id_jefe != e.id_empleado;

-- 10. Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids
SELECT id_empleado, nombre, apellido
FROM empleado 
WHERE id_jefe IS NULL AND id_departamento IN
(SELECT id_departamento FROM departamento WHERE id_ciudad IN
(SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Rawalpindi'))
ORDER BY id_empleado;

-- 11. Liste los ids y números de inscripción de los distribuidores nacionales que hayan entregado películas en idioma Español luego del año 2010.
SELECT id_distribuidor, nro_inscripcion
FROM nacional
WHERE id_distribuidor IN
(SELECT id_distribuidor FROM entrega WHERE nro_entrega IN
(SELECT nro_entrega FROM renglon_entrega WHERE codigo_pelicula IN
(SELECT codigo_pelicula FROM pelicula WHERE idioma = 'Español')) AND extract(year from fecha_entrega) > 2010);

-- 12. Liste las películas que nunca han sido entregadas por un distribuidor nacional.
SELECT * 
FROM pelicula
WHERE codigo_pelicula IN
(SELECT codigo_pelicula FROM renglon_entrega WHERE nro_entrega IN
(SELECT nro_entrega FROM entrega WHERE id_distribuidor NOT IN
(SELECT id_distribuidor FROM nacional)));

-- 13. Liste el apellido y nombre de los empleados que trabajan en departamentos residentes en el país Argentina y donde el jefe de departamento posee más del 40% de comisión.
SELECT e.nombre, e.apellido
FROM empleado e
WHERE e.id_departamento IN
(SELECT id_departamento FROM departamento WHERE id_ciudad IN
(SELECT id_ciudad FROM ciudad WHERE id_pais IN
(SELECT id_pais FROM pais WHERE nombre_pais = 'Argentina')) AND
jefe_departamento IN
(SELECT id_empleado FROM empleado WHERE porc_comision > 40));
-- no retorna resultados

-- 14. Indique los departamentos (nombre e identificador completo) que tienen más de 3 empleados con tareas con sueldo mínimo menor a 6000. Muestre el resultado ordenado por distribuidor
SELECT d.nombre, d.id_departamento
FROM departamento d JOIN distribuidor d1 ON d.id_distribuidor = d1.id_distribuidor
GROUP BY d.nombre, d.id_departamento, d1.nombre HAVING COUNT(d.id_departamento IN
(SELECT id_departamento FROM empleado WHERE id_tarea IN
(SELECT id_tarea FROM tarea WHERE sueldo_minimo < 6000))) > 3
ORDER BY d1.nombre, d.nombre;
-- no muestra resultados

-- 15. Liste los datos de los departamentos en los que trabajan menos del 10 % de los empleados que hay registrados
SELECT *
FROM departamento
GROUP BY id_departamento, id_distribuidor, nombre, calle, numero, id_ciudad, jefe_departamento HAVING COUNT(id_departamento IN
(SELECT id_departamento FROM empleado)) < (SELECT COUNT(*)/10 FROM empleado); 
