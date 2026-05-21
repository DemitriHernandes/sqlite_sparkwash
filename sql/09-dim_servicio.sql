USE sparkwash
GO

WITH

-- CTE 1: extraer la información del servicios
servicios_unicos as(
SELECT DISTINCT tipo_servicio
FROM silver.tabla_control_clean
),

-- CTE 2: creación de surrogate key
servicios_final as(
SELECT
	ROW_NUMBER() OVER (ORDER BY tipo_servicio) as tipo_servicio_sk,
	tipo_servicio,
	CASE tipo_servicio
		WHEN 'completo' THEN 'Servicio interior y exterior'
		WHEN 'interior' THEN 'Servicio solo interior'
		WHEN 'exterior' THEN 'Servicio solo exterior'
	END as tipo_servicio_descripcion
FROM servicios_unicos
)

SELECT *
INTO gold.dim_servicio
FROM servicios_final