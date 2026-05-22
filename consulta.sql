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

SELECT 
        albaran_id,
        data,
        strftime('%m', data) as mes
FROM fact_ventas_servicios
LIMIT 5;
