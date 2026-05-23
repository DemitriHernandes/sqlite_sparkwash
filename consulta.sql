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
        CASE 
        WHEN strftime('%m', data) = '01' THEN 'janero'
        WHEN strftime('%m', data) = '02' THEN 'febrero'
        WHEN strftime('%m', data) = '03' THEN 'marzo'
        WHEN strftime('%m', data) = '04' THEN 'abril'
        WHEN strftime('%m', data) = '05' THEN 'mayo'
        WHEN strftime('%m', data) = '06' THEN 'junio'
        WHEN strftime('%m', data) = '07' THEN 'julio'
        WHEN strftime('%m', data) = '08' THEN 'agosto'
        WHEN strftime('%m', data) = '09' THEN 'septembre'
        WHEN strftime('%m', data) = '10' THEN 'octubre'
        WHEN strftime('%m', data) = '11' THEN 'noviembre'
        WHEN strftime('%m', data) = '12' THEN 'diciembre'
        END as mes,
        CASE
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 1 AND 3 THEN 1
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 4 AND 6 THEN 2
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 7 AND 9 THEN 3
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 10 AND 12 THEN 4
        END as trimestre,
        strftime('%d', data) as dia,
        strftime('%W', data) as semana,
        CASE
        WHEN strftime('%w', data) = '1' THEN 'lunes'
        WHEN strftime('%w', data) = '2' THEN 'martes'
        WHEN strftime('%w', data) = '3' THEN 'miercoles'
        WHEN strftime('%w', data) = '4' THEN 'jueves'
        WHEN strftime('%w', data) = '5' THEN 'viernes'
        WHEN strftime('%w', data) = '6' THEN 'sabado'
        WHEN strftime('%w', data) = '7' THEN 'domingo'
        END as dia_semana
FROM fact_ventas_servicios
ORDER BY semana ASC, albaran_id ASC;