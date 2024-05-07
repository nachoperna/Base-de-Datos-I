-- Consultas con DISTINCT

-- 1. Liste los códigos de las distintas tareas que están realizando actualmente los voluntarios.
SELECT nombre AS "Nombre", apellido AS "Apellido", id_tarea AS "Codigo tarea"
FROM "unc_esq_voluntario"."voluntario";

-- 2. Genere un listado con los distintos identificadores de los coordinadores.
SELECT nombre AS "Nombre", apellido AS "Apellido", id_coordinador AS "Codigo coordinador"
FROM "unc_esq_voluntario"."voluntario";
