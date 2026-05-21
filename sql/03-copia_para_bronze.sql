USE SPARKWASH
GO

SELECT *
INTO bronze.tabla_control_albaran
FROM dbo.Tabla_control_albaran

SELECT TOP(10)*
FROM bronze.tabla_control_albaran