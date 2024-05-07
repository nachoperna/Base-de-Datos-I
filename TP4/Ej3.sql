-- Consultas con IS [NOT] NULL (esq. Películas)

-- 1. Muestre apellido, nombre e identificador de todos los empleados que no cobran porcentaje de comisión . Ordene por apellido.
SELECT apellido AS "Apellido", nombre AS "Nombre", id_empleado AS "ID", porc_comision AS "Porcentaje"
FROM "unc_esq_peliculas"."empleado"
WHERE porc_comision IS NULL OR porc_comision = 0
ORDER BY apellido;

-- 2. Muestre los datos de los distribuidores internacionales que no tienen registrado teléfono.
SELECT * 
FROM "unc_esq_peliculas"."distribuidor"
WHERE telefono IS NULL; 

-- 3. Seleccione la clave y el nombre de los departamentos sin jefe.
SELECT nombre AS "Nombre", id_departamento AS "ID"
FROM "unc_esq_peliculas"."departamento"
WHERE jefe_departamento IS NULL OR jefe_departamento = 0; 
