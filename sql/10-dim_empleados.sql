USE sparkwash
GO

WITH

-- CTE 1: extraer los nombres unicos
empleados_unicos as(
SELECT DISTINCT
	TRIM(value) AS empleados_nombre
    FROM silver.tabla_control_clean
	CROSS APPLY STRING_SPLIT(empleados_servicio, '/')
),

-- CTE 2: crear surrogate key
empleados_final as(
SELECT
	ROW_NUMBER() OVER (ORDER BY empleados_nombre) as empleados_sk,
	empleados_nombre,
	'operario' as cargo,
	'norte' as filial_nombre
FROM empleados_unicos
)

SELECT *
INTO gold.dim_empleados
FROM empleados_final