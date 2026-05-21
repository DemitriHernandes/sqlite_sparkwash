USE sparkwash
GO

WITH

-- CTE 1: extraer cada empleado por servicio_sk
empleados_sk as(
SELECT
	servicio_sk,
	TRIM(value) as empleados_nombre,
	cantidad_empleados
FROM silver.tabla_control_clean
CROSS APPLY STRING_SPLIT(empleados_servicio, '/')
),

-- CTE 2: calcular factor de comision
factor_comision as(
SELECT
	servicio_sk,
	empleados_nombre,
	CAST(1.0/cantidad_empleados as decimal(5,2)) as factor_comision
FROM empleados_sk
),

-- CTE 3: juntar factor_comision con dim_empleados
bridge_final as(
SELECT
	f.servicio_sk,
	e.empleados_sk,
	f.empleados_nombre,
	f.factor_comision
FROM factor_comision as f
INNER JOIN gold.dim_empleados as e
ON f.empleados_nombre = e.empleados_nombre
)

SELECT *
INTO gold.bridge_servicio_empleados
FROM bridge_final