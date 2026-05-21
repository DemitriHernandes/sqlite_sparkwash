USE SPARKWASH
GO

EXEC sp_rename
	'bronze.tabla_control_albaran',
	'tabla_control_raw';

