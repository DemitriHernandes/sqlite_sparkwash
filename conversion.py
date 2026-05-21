import pandas as pd 
import sqlite3

# leer csv
df = pd.read_csv("Tabla_control_albaran.csv", encoding="latin1") 

# crear (o conectar) base de datos SQLite
conn = sqlite3.connect("consulta.db")

# enviar datos a la tabla "control"
df.to_sql("control", conn, if_exists="replace", index=False)

# verificación rápida
result = pd.read_sql("SELECT * FROM control LIMIT 10", conn)

print(result)

# cerrar conexión
conn.close()