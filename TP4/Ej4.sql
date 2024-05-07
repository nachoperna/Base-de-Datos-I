-- Uso de funciones de fecha (esq. Voluntarios)

-- 1. Haga un listado de los voluntarios donde se muestre el apellido y nombre (concatenados y separados por una coma) y la fecha de nacimiento (como año, mes y día), ordenados por año de nacimiento.
SELECT apellido || ', ' || nombre AS "Apellido y Nombre",  to_char(fecha_nacimiento, 'DD/MM/YYYY') AS "Fecha nacimiento"
FROM "unc_esq_voluntario"."voluntario"
ORDER BY extract(year from fecha_nacimiento);

-- 2. Muestre todos los voluntarios nacidos a partir de 1998 con más de 5000 horas aportadas, ordenados por su identificador.
SELECT nro_voluntario AS "ID", apellido ||', '|| nombre AS "Apellido, Nombre", to_char(fecha_nacimiento, 'DD/MM/YYYY') AS "Fecha nacimiento", horas_aportadas AS "Horas aportadas"
FROM "unc_esq_voluntario"."voluntario"
WHERE extract(year from fecha_nacimiento) >= 1998 AND horas_aportadas > 5000
ORDER BY nro_voluntario

-- 3. Haga un listado de los voluntarios que cumplen años hoy (día y mes actual), indicando el nombre, apellido y su edad (en años).
SELECT apellido||', '||nombre AS "Apellido, nombre", fecha_nacimiento AS "Fecha nacimiento", extract(year from age(current_date,fecha_nacimiento)) || ' años' AS "Edad" -- funcion age() devuelve la diferencia exacta entre 2 fechas
FROM "unc_esq_voluntario"."voluntario"
WHERE fecha_nacimiento = current_date;
