USE SPARKWASH
GO

WITH

-- CTE 1: seleccionar todos los datos de la capa bronze
bronze_raw as(
SELECT *
FROM bronze.tabla_control_raw
),

-- CTE 2: excluir registro cancelamento
sin_cancelaciones as(
SELECT *
FROM bronze_raw
WHERE servicio_realizado_por <> 'Cancelado 80'
),

-- CTE 3: limpiar y estandarizar texto
estandarizaciones as(
SELECT 
	servicio_n_albaran,
	data,
	LOWER(TRIM(centro)) as centro,
	LOWER(TRIM(turno)) as turno,
	LOWER(TRIM(tipo_servicio)) as tipo_servicio,
	precio_venta,
	precio_base_com_iva,
	cantidad_empleado,
	servicio_realizado_por,
	cliente_captado_en
FROM sin_cancelaciones
),

-- CTE 4: renombrar columnas para taxonomía correcta
renombres as(
SELECT 
	servicio_n_albaran as albaran_id,
	data as fecha_servicio,
	centro as filial,
	turno,
	tipo_servicio,
	precio_venta,
	precio_base_com_iva as base_comision,
	cantidad_empleado as cantidad_empleados,
	servicio_realizado_por as empleados_servicio,
	cliente_captado_en as canal_captacion
FROM estandarizaciones
),

-- CTE 5: adicionar surrogate key
silver_final as(
SELECT
	ROW_NUMBER() OVER (ORDER BY albaran_id) as servicio_sk,
	*
FROM renombres
)

SELECT *
INTO silver.tabla_control_clean
FROM silver_final
