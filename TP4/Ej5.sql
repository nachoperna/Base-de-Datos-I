-- Consultas con LIMIT

-- 1. Seleccione los datos de las 10 primeras direcciones ordenadas de acuerdo a su identificador.
SELECT * 
FROM "unc_esq_voluntario"."direccion"
ORDER BY id_direccion
LIMIT 10;

-- 2. Si se desea paginar la consulta que selecciona los datos de las tareas cuyo nombre comience con O, A o C, y hay 5 registros por página, muestre la consulta que llenaría los datos para la 3er. página.
SELECT * 
FROM "unc_esq_voluntario"."tarea"
WHERE nombre_tarea LIKE 'O%' OR nombre_tarea LIKE 'A%' OR nombre_tarea LIKE 'C%'
LIMIT 5 OFFSET 3;
