USE sparkwash
GO

SELECT count(*)
FROM dbo.tabla_control_albaran

SELECT count(*)
FROM bronze.tabla_control_raw

SELECT count(*)
FROM bronze.tabla_control_raw
WHERE servicio_realizado_por <> 'Cancelado 80'

SELECT count(*)
FROM silver.tabla_control_clean

SELECT sum(p_v_p) as pvp,
	sum(precio_venta) as precio,
	(sum(p_v_p)-sum(precio_venta)) as result
FROM bronze.tabla_control_raw

SELECT sum(precio_venta) as suma_precio_venta
FROM silver.tabla_control_clean

SELECT sum(base_comision*cantidad_empleados) as total_comisiones
FROM silver.tabla_control_clean

SELECT TOP(10)*
FROM silver.tabla_control_clean

SELECT TOP(10)*,
	DATEPART(WEEKDAY, fecha_servicio) as dia_semana,
	CASE DATEPART(WEEKDAY, fecha_servicio)
		WHEN 1 THEN 'lunes'
		WHEN 2 THEN 'martes'
		WHEN 3 THEN 'miercoles'
		WHEN 4 THEN 'jueves'
		WHEN 5 THEN 'viernes'
		WHEN 6 THEN 'sabado'
		WHEN 7 THEN 'domingo'
	END as dia_semana_nombre,
	CASE 
		WHEN DATEPART(WEEKDAY, fecha_servicio)
		IN (6,7) THEN 1 ELSE 0
	END as fin_de_semana
FROM silver.tabla_control_clean

SELECT count(*) as total_dias
FROM gold.dim_tiempo

SELECT TOP(10)*
FROM dbo.Tabla_control_albaran
WHERE servicio_realizado_por LIKE 'rober%'

SELECT *
FROM gold.dim_empleados

SELECT count(*) as total_servicios
FROM gold.bridge_servicio_empleados

SELECT
    servicio_sk,
    SUM(factor_comision) as suma_factor,
    COUNT(*) as total_empleados
FROM gold.bridge_servicio_empleados
GROUP BY servicio_sk
HAVING SUM(factor_comision) <> 1.0

SELECT *
FROM gold.dim_tiempo

SELECT *
FROM gold.dim_filial

SELECT *
FROM gold.dim_servicio

SELECT count(*) as total
FROM gold.fact_servicios

SELECT 
	SUM(CASE WHEN tiempo_sk IS NULL THEN 1 ELSE 0 END) as nulo_tiempo,
	SUM(CASE WHEN filial_sk IS NULL THEN 1 ELSE 0 END) as nulo_filial,
	SUM(CASE WHEN tipo_servicio_sk IS NULL THEN 1 ELSE 0 END) as nulo_servicio
FROM gold.fact_servicios

SELECT 
	SUM(precio_venta) as total_venta,
	SUM(base_comision*cantidad_empleados) as total_comision,
	AVG(precio_venta) as promedio_ventas
FROM gold.fact_servicios

SELECT
    cantidad_empleados,
    COUNT(*) as total_servicios
FROM gold.fact_servicios
GROUP BY cantidad_empleados
ORDER BY cantidad_empleados

SELECT sum(precio_venta)
FROM gold.fact_servicios

SELECT TOP(10)*
FROM gold.fact_servicios
WHERE turno = 'mañana'

SELECT e.empleados_nombre, sum(base_comision)
FROM gold.fact_servicios f
INNER JOIN gold.bridge_servicio_empleados b
ON f.servicio_sk = b.servicio_sk
INNER JOIN gold.dim_empleados e
ON b.empleados_sk = e.empleados_sk
GROUP BY e.empleados_nombre


SELECT sum(precio_venta)
FROM gold.fact_servicios
WHERE tiempo_sk like '202506%'

SELECT sum(precio_venta)
FROM gold.fact_servicios
WHERE tiempo_sk like '202507%'

SELECT sum(precio_venta)
FROM gold.fact_servicios