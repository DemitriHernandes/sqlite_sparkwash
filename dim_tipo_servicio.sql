
CREATE TABLE IF NOT EXISTS dim_tipo_servicio as

WITH tabla_servicio as (
        SELECT        
                DISTINCT tipo_servicio
        FROM silver_control
)

SELECT 
        ROW_NUMBER() OVER (ORDER BY tipo_servicio) as servicio_id,
        tipo_servicio
FROM tabla_servicio;