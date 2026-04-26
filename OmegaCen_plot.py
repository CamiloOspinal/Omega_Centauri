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
