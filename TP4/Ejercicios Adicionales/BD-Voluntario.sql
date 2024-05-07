-- 1. Realice un listado donde, por cada voluntario, se indique las distintas instituciones y tareas que ha desarrollado (considere los datos históricos)
SELECT apellido||', '||nombre AS "Apellido, nombre", id_coordinador, id_tarea
FROM "unc_esq_voluntario"."voluntario"
GROUP BY apellido, nombre, id_coordinador, id_tarea
ORDER BY id_coordinador;

-- 2. Muestre el apellido, la tarea y las horas aportadas de todos los voluntarios cuyas tareas sean de “SA_REP” o “ST_CLERK” y cuyas horas aportadas no sean iguales a 2.500, 3.500 ni 7.000.
SELECT apellido, id_tarea, horas_aportadas
FROM "unc_esq_voluntario"."voluntario"
WHERE (id_tarea = 'SA_REP' OR id_tarea = 'ST_CLERK') AND (horas_aportadas != 2500 OR horas_aportadas != 3500 OR horas_aportadas != 7000);

-- 3. Muestre los datos completos de las instituciones que posean director. 
SELECT *
FROM "unc_esq_voluntario"."institucion"
WHERE id_director IS NOT NULL;

-- 4. Muestre el apellido e identificador de la tarea de todos los voluntarios que no tienen coordinador.
SELECT apellido, id_tarea
FROM "unc_esq_voluntario"."voluntario"
WHERE id_coordinador IS NULL;

-- 5. Muestre el apellido, las horas aportadas y el porcentaje de donación para todos los voluntarios que aportan horas (aporte > 0 o distinto de nulo). Ordene los datos de forma descendente según las horas aportadas y porcentajes de donaciones.
SELECT apellido, horas_aportadas, porcentaje
FROM "unc_esq_voluntario"."voluntario"
WHERE horas_aportadas > 0 OR horas_aportadas IS NOT NULL
ORDER BY horas_aportadas DESC, porcentaje DESC;

-- 6. Liste los identificadores de aquellos coordinadores que coordinan a más de 8 voluntarios.
SELECT id_coordinador, COUNT(*) AS "Cantidad voluntarios"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY id_coordinador HAVING COUNT(*) > 8;

-- 7. Muestre el identificador de las instituciones y la cantidad de voluntarios que trabajan en ellas, sólo de aquellas instituciones que tengan más de 10 voluntarios.
SELECT id_institucion, COUNT(*) AS "Cantidad voluntarios"
FROM "unc_esq_voluntario"."voluntario"
GROUP BY id_institucion HAVING COUNT(*) > 10;
