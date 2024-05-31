-- 7. Liste los identificadores y títulos de aquellas películas que registran la mayor cantidad de entregas y la menor cantidad de ellas, junto con la cantidad respectiva. 
((SELECT p.codigo_pelicula, p.titulo, e.cantidad
  FROM pelicula p JOIN renglon_entrega e USING(codigo_pelicula)
  ORDER BY e.cantidad DESC
  LIMIT 1)
  UNION 
  (SELECT p.codigo_pelicula, p.titulo, e.cantidad
  FROM pelicula p JOIN renglon_entrega e USING(codigo_pelicula)
  ORDER BY e.cantidad
  LIMIT 1));
  -- sacala del medio

-- 8. Obtenga los datos de los videos que han recibido entregas por parte de distribuidores nacionales y también internacionales, ordenados por razón social 
(SELECT v.id_video, v.razon_social AS "v_razon_social"
FROM video v
	JOIN entrega e USING(id_video)
	JOIN distribuidor d USING(id_distribuidor)
	JOIN nacional n USING(id_distribuidor))
	
INTERSECT ALL

(SELECT v.id_video, v.razon_social AS "v_razon_social"
FROM video v
	JOIN entrega e USING(id_video)
	JOIN distribuidor d USING(id_distribuidor)
	JOIN internacional i USING(id_distribuidor))
	
ORDER BY v_razon_social;

-- 9. Liste id, nombre y apellido de los empleados que no son jefes de departamento. 
SELECT e.id_empleado, e.nombre, e.apellido
FROM empleado e JOIN departamento d ON e.id_empleado != d.id_departamento;

-- 10. Indique si hay distribuidores (nacionales o internacionales) que efectuaron entregas a todos los videos.

-- 11. Determine los videos que han recibido entregas de parte de todos los distribuidores internacionale
SELECT v.id_video
FROM video v JOIN entrega e USING(id_video) JOIN distribuidor d USING(id_distribuidor)
WHERE 
