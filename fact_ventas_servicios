CREATE TABLE IF NOT EXISTS fact_ventas_servicios AS

WITH turno as(
        SELECT
        sc.*,
        dt.turno_id
        FROM silver_control sc
        LEFT JOIN dim_turno dt 
        ON sc.turno = dt.turno
),

servicio as(
        SELECT 
        t.*,
        ts.servicio_id
        FROM turno as t
        LEFT JOIN dim_tipo_servicio as ts 
        ON t.tipo_servicio = ts.tipo_servicio
)

SELECT
        albaran_id,
        data,
        filial,
        turno_id,
        servicio_id,
        precio_venta,
        valor_comisiones
FROM servicio;