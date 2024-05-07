-- 8. Liste los apellidos, nombres y e-mails de los empleados con cuentas de gmail y cuyo sueldo sea superior a 1000. 
SELECT nombre||', '||apellido AS "Nombre, apellido", e_mail AS "Mail", sueldo AS "Sueldo"
FROM "unc_esq_peliculas"."empleado"
WHERE (e_mail LIKE '%gmail%') AND sueldo > 1000;

-- 9. SELECT codigo_pelicula, cantidad
FROM "unc_esq_peliculas"."renglon_entrega"
WHERE cantidad BETWEEN 3 AND 5;

-- 10. Liste la cantidad de películas que hay por cada idioma. 
SELECT idioma, COUNT(*) AS "Cantidad peliculas"
FROM "unc_esq_peliculas"."pelicula"
GROUP BY idioma
ORDER BY COUNT(*) DESC;

-- 11. Calcule la cantidad de empleados por departamento
SELECT id_departamento, COUNT(*) AS "Cantidad empleados"
FROM "unc_esq_peliculas"."empleado"
GROUP BY id_departamento
ORDER BY COUNT(*) DESC;
