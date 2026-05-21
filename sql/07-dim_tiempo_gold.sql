USE sparkwash
GO

WITH

-- CTE 1: extrair las fechas únicas de la silver
fechas_unicas as(
SELECT
	DISTINCT fecha_servicio
FROM silver.tabla_control_clean
),

-- CTE 2: atributos de tiempo
atributos_tiempo as(
SELECT 
	fecha_servicio,
	YEAR(fecha_servicio) as ano,
	MONTH(fecha_servicio) as mes_numero,
	CASE MONTH(fecha_servicio)
		WHEN 1 THEN 'enero'
		WHEN 2 THEN 'febrero'
		WHEN 3 THEN 'marzo'
		WHEN 4 THEN 'abril'
		WHEN 5 THEN 'mayo'
		WHEN 6 THEN 'junio'
		WHEN 7 THEN 'julio'
		WHEN 8 THEN 'agosto'
		WHEN 9 THEN 'septiembre'
		WHEN 10 THEN 'octubre'
		WHEN 11 THEN 'noviembre'
		WHEN 12 THEN 'deciembre'
	END as mes_nombre,
	DATEPART(QUARTER, fecha_servicio) as trimestre,
	DATEPART(WEEK, fecha_servicio) as semana,
	DAY(fecha_servicio) as dia_numero,
	DATEPART(WEEKDAY, fecha_servicio) as dia_semana_numero,
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
FROM fechas_unicas
),

-- CTE 3: añadir surrogate key
dim_tiempo_final as(
SELECT
	CAST(FORMAT(fecha_servicio, 'yyyyMMdd') AS INT) as tiempo_sk,
	fecha_servicio,
	ano,
	mes_numero,
	mes_nombre,
	trimestre,
	semana,
	dia_numero,
	dia_semana_numero,
	dia_semana_nombre,
	fin_de_semana
FROM atributos_tiempo
)

SELECT *
INTO gold.dim_tiempo
FROM dim_tiempo_final
ORDER BY fecha_servicio