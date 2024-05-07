-- Funciones de grupo y uso de GROUP BY y HAVING (esq. Voluntarios)

-- 1. Recupere la cantidad mínima, máxima y promedio de horas aportadas por los voluntarios de más de 25 años.
SELECT extract(year from age(current_date,fecha_nacimiento)) AS "Edad", COUNT(*) AS "Cantidad voluntarios", MIN(horas_aportadas) AS "HS min", MAX(horas_aportadas) AS "HS max", AVG(horas_aportadas) AS "HS avg"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY extract(year from age(current_date,fecha_nacimiento)) HAVING extract(year from age(current_date,fecha_nacimiento)) > 25;

-- 2. Obtenga la cantidad de voluntarios que tiene cada institución.
SELECT id_institucion, COUNT(*) AS "Cantidad voluntarios"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY id_institucion
ORDER BY COUNT(*);

-- 3. Muestre la fecha de nacimiento del voluntario más joven y del más viejo.


-- 4. Considerando los datos históricos de cada voluntario, indique la cantidad de tareas distintas que cada uno ha realizado. 
SELECT id_tarea, COUNT(*) AS "Cantidad voluntarios"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY id_tarea;

-- 5. Se quiere conocer los coordinadores que tienen a su cargo menos de 3 voluntarios dentro de cada institución.
SELECT id_coordinador, COUNT(*) AS "Cantidad voluntarios"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY id_coordinador HAVING COUNT(*) <= 3;
