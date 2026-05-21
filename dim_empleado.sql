CREATE TABLE IF NOT EXISTS dim_empleados as

WITH empleado as(
SELECT 
        'michael' as empleado,
        'norte' as filial,
        'operario' as cargo
UNION ALL
SELECT
        'richard',
        'norte',
        'operario'
UNION ALL
SELECT 
        'steven',
        'norte',
        'operario'
UNION ALL
SELECT
        'robert',
        'norte',
        'operario'
UNION ALL
SELECT
        'andrew',
        'norte',
        'operario'
UNION ALL
SELECT
        'jonathan',
        'norte',
        'operario'
UNION ALL
SELECT
        'robert_2',
        'norte',
        'operario'
),

empleado_id as(
SELECT
        ROW_NUMBER() OVER (ORDER BY empleado) as empleado_id,
        *
FROM empleado
)

SELECT *
FROM empleado_id;