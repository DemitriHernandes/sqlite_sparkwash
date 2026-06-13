CREATE TABLE IF NOT EXISTS bridge_empleado as

WITH bridge as(
SELECT 
        albaran_id,
        valor_comisiones,
        1 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%andrew%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        2 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%jonathan%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        3 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%michael%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        4 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%richard%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        5 as empleado_id
FROM silver_control
WHERE '/' || LOWER(servicio_empleados) || '/' LIKE '%/robert/%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        6 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%robert_2%'

UNION ALL

SELECT
        albaran_id,
        valor_comisiones,
        7 as empleado_id
FROM silver_control
WHERE LOWER(servicio_empleados) LIKE '%steven%'
)

SELECT *
FROM bridge;