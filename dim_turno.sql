CREATE TABLE IF NOT EXISTS dim_turno as

WITH tabla_turno as (
        SELECT 
                DISTINCT turno
        FROM silver_control
)

SELECT 
        ROW_NUMBER() OVER (ORDER BY turno) as turno_id,
        turno
FROM tabla_turno;