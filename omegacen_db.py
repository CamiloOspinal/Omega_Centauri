import pandas as pd
import sqlite3

# Leyendo omega_bruto.csv
OmegaCen_df = pd.read_csv("omega_cen.csv")

# Borrando NaN
OmegaCen_df = OmegaCen_df.dropna(subset = ['Gmag', 'BPmag', 'RPmag', 'pmRA', 'pmDE'])

# Creando la base de datos
conexion = sqlite3.connect('Omega_Cen.db')

# Creando la tabla
OmegaCen_df.to_sql('estrellas', conexion, if_exists='replace', index=False)

conexion.close()

print('Se ha creado el archivo Omega_Cen.db.\nAhora omega_cen.csv es una tabla sql')

