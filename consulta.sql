--.headers on
--.mode csv
--.import --Skip 1 Tabla_control_albaran.csv control

--.mode column

.tables 

SELECT *
FROM silver_control
LIMIT 10;

SELECT count(*)
FROM silver_control;

SELECT *
FROM dim_tipo_servicio;

SELECT *
FROM dim_turno;

SELECT *
FROM dim_empleados;


SELECT 
        sum(valor_comisiones),
        (SELECT sum(precio_venta)
        FROM silver_control)
FROM bridge_empleado;

SELECT *
FROM fact_ventas_servicios
LIMIT 5;

SELECT *
FROM dim_data;

WITH separacion as(
SELECT albaran_id,
        valor_comisiones,
        substr(servicio_empleados, 1, instr(servicio_empleados,'/') -1) as empleado1,
        substr(servicio_empleados, instr(servicio_empleados,'/') +1) as empleado2
FROM silver_control
),
vacio as(
SELECT albaran_id,
        valor_comisiones,
        empleado2,
CASE
        WHEN empleado1 = '' THEN '0'
        ELSE empleado1
        END as empleado
FROM separacion
),
unir_explode as(
SELECT albaran_id,
        valor_comisiones,
        empleado
FROM vacio 
WHERE empleado != '0'

UNION ALL
SELECT albaran_id,
        valor_comisiones,
        empleado2 as empleado
FROM vacio
)
SELECT *
FROM unir_explode
ORDER BY albaran_id, empleado;

-- SELECT sum(valor_comisiones),
--         (SELECT sum(precio_venta) FROM silver_control)
-- FROM unir_explode;