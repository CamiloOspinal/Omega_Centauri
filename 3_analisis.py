import sqlite3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import inset_axes

# Conexión con la base de datos local
conn = sqlite3.connect('arqueologia.db')

# Definiendo la consulta en la tabla
request = "SELECT Gmag, BPmag, RPmag, pmRA, pmDE FROM estrellas;"

# Dataframe
OmegaCen_df = pd.read_sql_query(request, conn)

conn.close()

# pm reportado
pmRA = -3.24
pmDE = -6.73

# Scatter principal
plt.scatter(OmegaCen_df['pmRA'], OmegaCen_df['pmDE'], color='k', s=2, label = 'GDR3 stars')
plt.plot(pmRA, pmDE, '+', color='red', label = 'Omega Cen pm (Baumgardt et al. 2019)')

plt.xlim(-40, 25)
plt.ylim(-30, 25)
plt.xlabel('pmRA [mas/yr]', fontsize = 16)
plt.ylabel('pmDE [mas/yr]', fontsize = 16)
plt.title('Proper Motion', fontsize=18)
plt.legend(loc='lower left')

# Crear inset
ax = plt.gca()
axins = inset_axes(ax, width="30%", height="30%", loc='upper right')
axins.scatter(OmegaCen_df['pmRA'], OmegaCen_df['pmDE'], color='k', s=2)
axins.plot(pmRA, pmDE, '+', color='red')

# Zoom
zoom = 1.5
axins.set_xlim(pmRA - zoom, pmRA + zoom)
axins.set_ylim(pmDE - zoom, pmDE + zoom)

# quiar ticks 
#axins.set_xticks([])
#axins.set_yticks([])

plt.savefig('GaiaDR3_pm1.png', dpi=300, bbox_inches='tight')

plt.close()

print('----------------\nEn base al gráfico y los resultados de Baumgardt et al. (2019) y Vasiliev & Baumgardt (2021) se procede a \nseleccionar las estrellas que estén dentro del circulo centrado en  pmRA = -3.250 y pmDE = -6.746, de radio 0.6')

#plt.show()
