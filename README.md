# Arqueología Galáctica y el Misterio de Omega Centauri

## Cúmulo globular
Omega Centauri es un cúmulo globular que se considera podría ser el remanente del núcleo de una galaxia satelite que fue absorbida por la vía
láctea. Tiene coordenadas (ICRS) $\text{RA: } 13° 26' 47.28''; \text{ DE: } -47° 28' 46.1''$, que en grados son $\text{RA: } 201.697° \text{ DE: } -47.479°$.
Haciendo una selección de las estrellas dentro de un diámetro angular de $0.5°$ se pretende encontrar la membresía del cúmulo.\
\
Al analizar los movimientos propios de las estrellas de la región a partir de los datos de Gaia DR3, se encuentra una dispersión de estrellas donde hay una clara y densa
concentración de cuerpos en torno al punto $(\text{pmRA}, \text{pmDE}) = (-3.24, -6.73) \text{ mas/yr}$, el movimiento propio reportado del cúmulo por [Baumgardt et al. (2019)](https://doi.org/10.1093/mnras/sty2997). Esto confirma que esta distribución corresponde a Omega Centauri y es donde debemos centrar nuestros esfuerzos. Posteriormente, [Vasiliev & Baumgart (2021)](https://doi.org/10.1093/mnras/stab1475) reportaron un movimiento propio muy similar utilizando datos del EGDR3, $\text{pmRA} = -3.250 \text{ mas/yr}$ y $\text{pmDE} = -6.746 \text{ mas/yr}$.
<center><b><font size=4> Figura 1 </font></b></center>

![raw_data_pm](GaiaDR3_pm1.png)

## Procedimiento
Una vez identificado el racimo en el diagrama de movimientos propios y el movimiento propio global, se procedió a realizar una nueva busqueda filtrada unicamente con las estrellas en esta región
que cumplieran la condición de no estar a una distancia mayor de $2.5 \text{ mas/yr}$ del movimiento propio global, este valor se selecciona de manera completamente arbitraria según la visualización de la **Figura 1**, resultando en la selección de estrellas de la **Figura 2**. Es claro que esta región no selecciona todas las estrellas pertenecientes al cúmulo, sin embargo, representa una primera aproximación. 
<center><b><font size=4> Figura 2 </font></b></center>

![pm_selection](OmegaCen_members.png)

Los cúmulos son poblaciones estelares que tienen la misma edad en promedio, si escogimos bien las estrellas del cúmulo, estas deben seguir una distribución clásica en el diagrama. En los diagramas color magnitud (CMD) de los cúmulos globulares es común encontrar una dispersión muy grande en la parte inferior de la gráfica representando a las estrella menos masivas, una rama de las gigantes rojas muy estrecha y la característica región de la rama horizontal (ver [Stellar Populations - Lecture I](https://pages.astro.umd.edu/~rmushotz/ASTRO620/stellarpops11_lec1.pdf), pag. 15, para un ejemplo). A continuación, el CMD de Omega Centauri, donde vemos la morfología anterior.
<center><b><font size=4> Figura 3 </font></b></center>

![data_cmd](OmegaCen_CMD.png)

Finalmente, es apropiado comparar nuestros resultados con aquellos en la literatura. Para esto, vamos a utilizar el catálogo de [Vasiliev & Baumgart (2021)](https://doi.org/10.1093/mnras/stab1475)
seleccionando las estrellas que tengan una probabilidad de membresía mayor al 95%. Graficando los movimientos propios obtenemos la **Figura 4**, donde la zona roja representa la distribución de nuestras estrellas y las azules la distribución de las estrellas de [Vasiliev & Baumgart (2021)](https://doi.org/10.1093/mnras/stab1475). Esto nos muestra que nuestra selección de estrellas no contiene estrellas de relativo alto movimiento propio que sí pertenecen al cúmulo.
<center><b><font size = 4> Figura 4 </font></b></center>

![pm_comparation](Omega_Centauri_membership.png)

Sin embargo, como ve en la siguiente figura, si hacemos una comparación entre todas los CMDs de cada una de nuestras etapas, siendo la figura de la izquierda el CMD de los datos crudos, la figura
central nuestros datos filtrados y la figura de la derecha los datos de [Vasiliev & Baumgart (2021)](https://doi.org/10.1093/mnras/stab1475), vemos que nuestra selección de movimientos propios ayudó a limpiar muy bien el diagrama y que a pesar de tener una cantidad menor de estrellas, los rasgos principales de nuestro resultado y el de la literatura son iguales.
<center><b><font size = 4> Figura 5 </font></b></center>

![cmd](Omega_Centauri_CDM.png)

Por último, a pesar de la increíble cantidad de estrellas que presenta nuestro diagrama, el GDR3 no es capaz de resolver las estrellas en el núcleo de Omega Centauri, a nuestros diagramas les hace falta una gran cantidad de estrellas en la parte más profunda del cúmulo. Le recomendamos leer el artículo de [Vernekar et al. 2025](https://doi.org/10.1051/0004-6361/202453187) para saber más del tema y ver con que métodos se examinaron estas estrellas "ocultas".

## Archivos en el repositorio
En este repositorio encontrará 3 archivos principales:
* 1_descarga_omega.sh: Encargado de descargar las bases de datos y correr el código general
* 2_crear_db.py: Encargado de convertir el archivo .csv de la primera descarga en un catálogo
* 3_analisis.py: Encargado de realizar la **Figura 1** y **Figura 2**
* racdec.py: Un archivo que convierte de horas/minutos/segundos a grados (Nota: este archivo es una adición propia).
* Omega_Centauri_CDM.png: Imagen generada por fuera del código principal y agregada posteriormente
* Omega_Centauri_membership.png: Imagen generada por fuera del código principal y agregada posteriormente.

Los otros archivos son generados a partir de 1_descarga_omega.sh. Para correr este repositorio solo necesita los tres primeros archivos de la lista.

**Atentamente,**
Camilo Ospinal
