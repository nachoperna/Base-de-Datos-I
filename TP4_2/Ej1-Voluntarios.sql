-- 1. Haga un resumen de cuantas veces ha cambiado de tareas cada voluntario. Indique el número,  nombre y apellido del voluntario.
SELECT v.apellido, v.nombre, v.nro_voluntario, v.id_tarea, COUNT(h.id_tarea) AS "Cantidad realizada"
FROM "unc_esq_voluntario"."voluntario" v
JOIN "unc_esq_voluntario"."historico" h ON h.nro_voluntario = v.nro_voluntario
GROUP BY v.nro_voluntario
ORDER BY COUNT(h.id_tarea) DESC;

-- 2. Liste los datos de contacto (nombre, apellido, e-mail y teléfono) de los voluntarios que hayan desarrollado tareas con diferencia max_horas-min_horas de hasta 5000 horas y que las hayan finalizado antes del  01/01/2000.
SELECT v.nombre, v.apellido, v.e_mail, v.telefono, v.id_tarea, (t.max_horas - t.min_horas) AS "Diferencia horas"
FROM voluntario v JOIN tarea t ON v.id_tarea = t.id_tarea 
WHERE v.nro_voluntario IN 
  (SELECT h.nro_voluntario
   FROM historico h
   WHERE h.fecha_fin < to_date('2000-01-01','YYYY-MM-DD')
  )
  AND 
  v.id_tarea IN (SELECT t.id_tarea
   FROM tarea t
   WHERE (t.max_horas - t.min_horas) > 5000
  );

-- 3. Indique nombre, id y dirección completa de las instituciones que no poseen voluntarios con aporte de horas mayor o igual que el máximo de horas de la tarea que realiza.
SELECT nombre_institucion, id_institucion, id_direccion
FROM institucion
WHERE id_institucion IN 
  (SELECT v.id_institucion
   FROM voluntario v
   WHERE v.id_tarea IN (SELECT t.id_tarea FROM tarea t WHERE v.horas_aportadas < t.max_horas)
  );

-- 4. Liste en orden alfabético los nombres de los países que nunca han tenido acción de voluntarios (considerando sólo información histórica, no tener en cuenta los voluntarios actuales).
SELECT nombre_pais, id_pais
FROM pais
WHERE id_pais NOT IN 
(SELECT id_pais FROM direccion) -- si el id_pais no se encuentra dentro de la tabla de direcciones significa que nunca hubo una institucion en ese pais, por lo tanto ningun voluntario 
ORDER BY nombre_pais;

SELECT nombre_pais, id_pais
FROM pais
WHERE id_pais NOT IN 
(SELECT id_pais FROM direccion WHERE id_direccion NOT IN
(SELECT id_direccion FROM institucion WHERE id_institucion NOT IN
(SELECT id_institucion FROM historico)))
ORDER BY nombre_pais;

-- 5. Indique los datos de las tareas que se han desarrollado históricamente y que no se están desarrollando actualmente.
SELECT *
FROM tarea 
WHERE id_tarea IN 
(SELECT id_tarea FROM historico)
AND id_tarea NOT IN
(SELECT id_tarea FROM voluntario);

-- 6. Liste el id, nombre y máxima cantidad de horas de las tareas que se están ejecutando solo una vez y que actualmente la están realizando voluntarios de la ciudad ‘Munich’. Ordene por id de tarea.
SELECT id_tarea, nombre_tarea, max_horas
FROM tarea
WHERE id_tarea IN 
(SELECT id_tarea FROM voluntario WHERE id_institucion IN
(SELECT id_institucion FROM institucion WHERE id_direccion IN 
(SELECT id_direccion FROM direccion WHERE ciudad = 'Munich')))
ORDER BY id_tarea;

-- 7. Indique los datos de las instituciones que poseen director, donde históricamente se hayan desarrollado tareas que actualmente las estén ejecutando voluntarios de otras instituciones.
SELECT *
FROM institucion i
WHERE id_director IS NOT NULL AND id_institucion IN 
(SELECT id_institucion FROM historico WHERE id_tarea IN
(SELECT id_tarea FROM voluntario WHERE id_institucion != i.id_institucion));

-- 8. Listar los datos completos de todas las instituciones junto con el nombre y apellido de su director.
SELECT *, v.apellido||', '||v.nombre AS "Director"
FROM institucion i JOIN voluntario v ON v.nro_voluntario = i.id_director
WHERE id_director IS NOT NULL;
