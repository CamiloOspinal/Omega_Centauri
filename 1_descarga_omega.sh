#!/bin/bash

# Introducción
echo "¡Bienvenido a Arqueología Galáctica y el Misterio de Omega Centauri!"

echo "Omega Centauri tiene coordenadas ICRS 13 26 47.28 -47 28 46.1"

# Coordenadas en grados
RA=201.697
DE=-46.520527

echo "Empezando la busqueda en Vizier  de todos los objetos alrededor de un diámetro angular de 0.5 grados"

# Consulta
ADQL="SELECT Source, RA_ICRS, DE_ICRS, pmRA, pmDE,  Gmag, BPmag, RPmag FROM \"I/355/gaiadr3\" WHERE 1=CONTAINS(POINT('ICRS', RA_ICRS, DE_ICRS), CIRCLE('ICRS', $RA, $DE, 0.5))"

# Limpiador de espacios
URL_ADQL=$(echo $ADQL | sed 's/ /+/g')

# Endpoint de Vizier
TAP_URL="https://tapvizier.cds.unistra.fr/TAPVizieR/tap/sync?request=doQuery&lang=ADQL&format=csv&query="

echo "Descargando el archivo omega_bruto.csv..."

wget -q -O omega_bruto.csv "$TAP_URL$URL_ADQL"

echo "Descarga finalizada: omega_bruto.csv"

echo "Empezando a crear la base de datos..."

python3 2_crear_db.py

echo "Base de datos creada."
echo "Produciendo gráfica..."

python3 3_analisis.py

echo "-----------------------"
echo "Primera gráfica creada!"

echo "Creando nuevo catalogo Omega_Centauri..."

# Vamos a cambiar el sed para que no genere problemas con el power.

ADQL="SELECT Source, RA_ICRS, DE_ICRS, pmRA, pmDE, Gmag, BPmag, RPmag FROM \"I/355/gaiadr3\" WHERE (POWER(pmRA + 3.25, 2) + POWER(pmDE + 6.746, 2) <= POWER(0.6, 2)) AND 1=CONTAINS(POINT('ICRS', RA_ICRS, DE_ICRS), CIRCLE('ICRS', $RA, $DE, 0.5))"

URL_ADQL=$(echo $ADQL | sed 's/+/%2B/g' | sed 's/ /+/g')

echo "Descargando el archivo omega_cen.csv..."

wget -q -O omega_cen.csv "$TAP_URL$URL_ADQL"

echo "Descarga finalizada: omega_cen.csv"

echo "Empezando a crear la nueva base de datos..."

# Código de python
cat << 'EOF' > omegacen_db.py
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

EOF

# Ejecutando al base
python3 omegacen_db.py

echo "Base de datos creada."
echo "Produciendo gráfica..."

cat << 'EOF' > OmegaCen_plot.py
import sqlite3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#from mpl_toolkits.axes_grid1.inset_locator import inset_axes

# Conexión con la base de datos local
conn = sqlite3.connect('Omega_Cen.db')

# Definiendo la consulta en la tabla
request = "SELECT Gmag, BPmag, RPmag, pmRA, pmDE FROM estrellas;"

# Dataframe
OmegaCen_df = pd.read_sql_query(request, conn)

conn.close()

# Scatter principal
plt.scatter(OmegaCen_df['pmRA'], OmegaCen_df['pmDE'], color='k', s=2, label = 'GDR3 stars')

plt.xlabel('pmRA [mas/yr]', fontsize = 16)
plt.ylabel('pmDE [mas/yr]', fontsize = 16)
plt.title('Omega Centauri proper motion', fontsize = 16)
#plt.legend(loc='lower left')

plt.savefig('OmegaCen_members.png', dpi=300, bbox_inches='tight')
#plt.show()
plt.close()

################
# CMD
##############
BpRp = OmegaCen_df['BPmag'] - OmegaCen_df['RPmag']

plt.gca().invert_yaxis()

plt.scatter(BpRp, OmegaCen_df['Gmag'], s=3, alpha=0.5, color = 'darkblue')

plt.xlabel('BP-RP', fontsize=16)
plt.ylabel('Gmag', fontsize=16)
plt.title('Omega Centauri CMD', fontsize = 20)

plt.savefig('OmegaCen_CMD.png', dpi=300, bbox_inches='tight')
plt.close()
EOF

echo "Gráfica creada!"

python3 OmegaCen_plot.py


echo "Análisis finalizado"
