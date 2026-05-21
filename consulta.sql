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

SELECT sum(valor_comisiones)
FROM bridge_empleado;

SELECT sum(precio_venta)
FROM silver_control;

