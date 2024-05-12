-- 1. Haga un resumen de cuantas veces ha cambiado de tareas cada voluntario. Indique el número,  nombre y apellido del voluntario.
SELECT v.apellido, v.nombre, v.nro_voluntario, v.id_tarea, COUNT(h.id_tarea) AS "Cantidad realizada"
FROM "unc_esq_voluntario"."voluntario" v
JOIN "unc_esq_voluntario"."historico" h ON h.nro_voluntario = v.nro_voluntario
GROUP BY v.nro_voluntario
ORDER BY COUNT(h.id_tarea) DESC;

-- 2. Liste los datos de contacto (nombre, apellido, e-mail y teléfono) de los voluntarios que hayan desarrollado tareas con diferencia max_horas-min_horas de hasta 5000 horas y que las hayan finalizado antes del  01/01/2000.
