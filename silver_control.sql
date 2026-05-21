CREATE TABLE IF NOT EXISTS silver_control AS
WITH etl_01 as (
        -- borramos las columnas servicios_extras, 
        -- p.v.p y cliente_captado_en
SELECT servicio_n_albaran,
        data,
        centro,
        turno,
        tipo_servicio,
        precio_venta,
        precio_base_com_iva,
        cantidad_empleado,
        servicio_realizado_por,
        michael,
        richard,
        steven,
        robert,
        andrew,
        jonathan
FROM bronze_control
),

etl_02 as (
        -- adiccionamos surrogate key,
        -- estandarizamos nombres de las columnas,
        -- cambiamos tipo numerico de las columnas para
        -- tipo real
        -- cambiamos valores NULL para zero
        -- sacamos de la tabla albarans cancelados
        SELECT 
                ROW_NUMBER() OVER (ORDER BY servicio_n_albaran)
                as albaran_id,
                servicio_n_albaran as albarana_number,
                LOWER(TRIM(centro)) as filial,
                LOWER(TRIM(turno)) as turno,
                LOWER(TRIM(tipo_servicio)) as tipo_servicio,
                CAST(REPLACE(precio_venta,',','.') as REAL) AS precio_venta,
                CAST(REPLACE(precio_base_com_iva,',','.') AS REAL) as valor_comisiones,
                CAST(cantidad_empleado AS INTEGER) as cantidad_empleados,
                servicio_realizado_por as servicio_empleados,
                COALESCE(CAST(REPLACE(michael,',','.') AS REAL), 0) as michael,
                COALESCE(CAST(REPLACE(richard,',','.') AS REAL), 0) as richard,
                COALESCE(CAST(REPLACE(steven,',','.') AS REAL), 0) as steven,
                COALESCE(CAST(REPLACE(robert,',','.') AS REAL), 0) as robert,
                COALESCE(CAST(REPLACE(andrew,',','.') AS REAL), 0) as andrew,
                COALESCE(CAST(REPLACE(jonathan,',','.') AS REAL), 0) as jonathan
        FROM etl_01
        WHERE precio_venta > 10
)

SELECT *
FROM etl_02