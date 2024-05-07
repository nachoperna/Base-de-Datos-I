-- Consultas con condiciones y ordenamiento (esq. Voluntarios)

-- 1. Muestre los apellidos, nombres y e_mail de los voluntarios que llevan aportadas más de 1.000 horas, ordenados por apellido.
SELECT apellido AS "Apellido", nombre AS "Nombre", e_mail AS "Mail", horas_aportadas AS "Horas"
FROM "unc_esq_voluntario"."voluntario"
WHERE horas_aportadas > 1000
ORDER BY apellido;

-- 2. Muestre el apellido y teléfono de todos los voluntarios de las instituciones 20 y 50 en orden alfabético por apellido y nombre.
SELECT apellido AS "Apellido", nombre AS "Nombre", telefono AS "Telefono", id_institucion
FROM "unc_esq_voluntario"."voluntario"
WHERE id_institucion = 20 OR id_institucion = 50
ORDER BY apellido, nombre;

-- 3. Muestre el apellido, nombre y el e-mail de todos los voluntarios cuyo teléfono comienza con '+11'. Coloque como encabezado de las columnas los títulos 'Apellido y Nombre' y 'Dirección de mail'
SELECT apellido || ', ' || nombre AS "Apellido y Nombre", e_mail AS "Direccion de mail", telefono
FROM "unc_esq_voluntario"."voluntario"
WHERE telefono LIKE '+11%';
