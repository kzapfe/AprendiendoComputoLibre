import pandas
import sys
#import numpy as np
import matplotlib.pyplot as plt

#tuabuela='../DatosIntraCelularesFelipe/C5_10_I_17_data.csv'

tuabuela=sys.argv[1]

datos=pandas.read_csv(tuabuela)

promis=datos.groupby('ID').mean()
varis=datos.groupby('ID').var()

xxs=promis['Peaks']
yys=varis['Peaks']

plt.subplots_adjust(bottom = 0.1)
plt.scatter(xxs, yys, marker='o', c='purple')

labels=list(varis.index)

for label, x, y in zip(labels, xxs,yys):
    plt.annotate(
        label,
        xy=(x, y), xytext=(-20, 20),
        textcoords='offset points', ha='right', va='bottom',
        bbox=dict(boxstyle='round,pad=0.5', fc='darkmagenta', alpha=0.5),
        arrowprops=dict(arrowstyle = '->', connectionstyle='arc3,rad=0'))

plt.show()
