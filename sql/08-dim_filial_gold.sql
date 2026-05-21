USE sparkwash
GO

WITH

-- CTE 1: extraer filial de la silver
filiales_unicas as(
SELECT DISTINCT filial
FROM silver.tabla_control_clean
),

-- CTE 2: adicionar surrogate key y atributos
dim_filial_final as(
SELECT
	ROW_NUMBER() OVER (ORDER BY filial) as filial_sk,
	filial,
	'Costa del sol' as ciudad,
	'España' as pais
FROM filiales_unicas
)

SELECT *
INTO gold.dim_filial
FROM dim_filial_final