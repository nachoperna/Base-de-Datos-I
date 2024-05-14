-- 9. Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de su jefe, en caso de tenerlo
SELECT e.id_empleado, e.nombre||', '||e.apellido AS "Nombre Empleado", e.id_jefe, e1.nombre||', '||e1.apellido AS "Nombre Jefe"
FROM empleado e JOIN empleado e1 ON e1.id_empleado = e.id_jefe
WHERE e.id_jefe != e.id_empleado;

-- 10. Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde se desempeñan se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids
