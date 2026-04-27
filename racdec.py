import numpy as np

RA = "13 26 47.28" 
DE = "-47 28 46.1"

RA = (float(RA.split()[0]) + float(RA.split()[1])/60 + float(RA.split()[2])/3600)*15
DE = float(DE.split()[0]) - float(DE.split()[1])/60 - float(DE.split()[2])/3600

print(RA, DE)
