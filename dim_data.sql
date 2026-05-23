CREATE TABLE IF NOT EXISTS dim_data as

SELECT 
        DISTINCT
        data,
        strftime('%d', data) as dia,
        CASE 
        WHEN strftime('%m', data) = '01' THEN 'janero'
        WHEN strftime('%m', data) = '02' THEN 'febrero'
        WHEN strftime('%m', data) = '03' THEN 'marzo'
        WHEN strftime('%m', data) = '04' THEN 'abril'
        WHEN strftime('%m', data) = '05' THEN 'mayo'
        WHEN strftime('%m', data) = '06' THEN 'junio'
        WHEN strftime('%m', data) = '07' THEN 'julio'
        WHEN strftime('%m', data) = '08' THEN 'agosto'
        WHEN strftime('%m', data) = '09' THEN 'septembre'
        WHEN strftime('%m', data) = '10' THEN 'octubre'
        WHEN strftime('%m', data) = '11' THEN 'noviembre'
        WHEN strftime('%m', data) = '12' THEN 'diciembre'
        END as mes,
         strftime('%Y', data) as ano,
        CASE
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 1 AND 3 THEN 'primero'
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 4 AND 6 THEN 'segundo'
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 7 AND 9 THEN 'tercero'
        WHEN CAST(strftime('%m', data) as INTEGER)
        BETWEEN 10 AND 12 THEN 'cuarto'
        END as trimestre,
        strftime('%W', data) as semana,
        CASE
        WHEN strftime('%w', data) = '1' THEN 'lunes'
        WHEN strftime('%w', data) = '2' THEN 'martes'
        WHEN strftime('%w', data) = '3' THEN 'miercoles'
        WHEN strftime('%w', data) = '4' THEN 'jueves'
        WHEN strftime('%w', data) = '5' THEN 'viernes'
        WHEN strftime('%w', data) = '6' THEN 'sabado'
        WHEN strftime('%w', data) = '7' THEN 'domingo'
        END as dia_semana
FROM fact_ventas_servicios
ORDER BY data;