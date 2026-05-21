USE sparkwash
GO

SELECT
    COUNT(*) AS total_registros,
    SUM(CASE WHEN albaran_id IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_albaran_id,
    SUM(CASE WHEN fecha_servicio IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_fecha,
    SUM(CASE WHEN filial IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_centro,
    SUM(CASE WHEN turno IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_turno,
    SUM(CASE WHEN tipo_servicio IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_tipo_servicio,
    SUM(CASE WHEN precio_venta IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_precio_venta,
    SUM(CASE WHEN base_comision IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_base_comision,
    SUM(CASE WHEN cantidad_empleados IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_cantidad_empleados,
    SUM(CASE WHEN empleados_servicio IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_empleados_servicio,
    SUM(CASE WHEN canal_captacion IS NULL 
        THEN 1 ELSE 0 END)              AS nulos_canal_captacion
FROM silver.tabla_control_clean


SELECT TOP(10)*
FROM silver.tabla_control_clean