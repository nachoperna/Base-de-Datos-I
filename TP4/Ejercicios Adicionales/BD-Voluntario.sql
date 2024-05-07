-- 1. Realice un listado donde, por cada voluntario, se indique las distintas instituciones y tareas que ha desarrollado (considere los datos históricos)
SELECT apellido||', '||nombre AS "Apellido, nombre", id_coordinador, id_tarea
FROM "unc_esq_voluntario"."voluntario"
GROUP BY apellido, nombre, id_coordinador, id_tarea
ORDER BY id_coordinador;
