import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb
from scipy.optimize import curve_fit
import numpy as np

c1_df = pd.read_csv('/Users/felipeantoniomendezsalcido/Desktop/V_M_Project/C1_21_2_17/C1_21_2_17_data.csv')

pos_c1 = c1_df[(c1_df['Latency']>0.5) & (c1_df['RiseTime']>0) & (c1_df['Latency']<3.5) & (c1_df['RiseTime']<5) & (c1_df['Peaks'] <0)]
pos_c1['Peaks'] = pos_c1['Peaks'].abs()

pos_c1.describe()
pos_c1['Latency'].shape
pos_c1.shape
pos_c1.tail()

grouped_df = pos_c1.copy()
grouped_df['ID'] = grouped_df['ID'].apply(lambda x: x.rsplit('_', 4)[0])

grouped_df.describe()

def get_fq(ID):
    if '06hz' in ID:
        return '0.06Hz'
    elif '1hz' in ID:
        return '1Hz'
    elif '4hz' in ID:
        return '4Hz'
grouped_df['Fq']= grouped_df['ID'].apply(get_fq)

def get_cond(ID):
        if 'L' in ID:
            return 'Low'
        elif 'N' in ID:
            return 'Normal'
        elif 'H' in ID:
            return 'High'

def get_pair(ID):
    if 'PP1' in ID:
        return 'P1'
    elif 'PP2' in ID:
        return 'P2'

grouped_df['Cond'] = grouped_df['ID'].apply(get_cond)
grouped_df['Pair'] = grouped_df['ID'].apply(get_pair)
grouped_df.head()
od = ['PP1_L06hz', 'PP2_L06hz', 'PP1_L1hz', 'PP2_L1hz', 'PP1_L4hz',
       'PP2_L4hz', 'PP1_Nl06hz', 'PP2_Nl06hz', 'PP1_Nl1hz', 'PP2_Nl1hz',
       'PP1_Nl4hz', 'PP2_Nl4hz', 'PP1_H06hz', 'PP2_H06hz', 'PP1_H1hz','PP2_H1hz', 'PP1_H4hz', 'PP2_H4hz', 'DCG']

another = grouped_df.copy()

#plotting all points
fig, all_plot = plt.subplots()
sb.set_context('poster')
sb.set_style('ticks')
sb.stripplot(x='ID', y='Peaks', data= grouped_df, jitter=True,  palette=(sb.dark_palette('blue', reverse= True)), order = od)
sb.despine()
plt.xticks(rotation=45)
all_plot.set(xlabel='Conditions', ylabel= 'Peaks (pA)')
plt.tight_layout()
plt.show()
fig.savefig('All_plot(2).svg')
#ends plotting

another.head()

ab = another.groupby(['Cond', 'Fq', 'Pair'])

ab

another_vm = another['Peaks'].groupby('ID').agg({'Mean': lambda x: x.mean(), 'Var': lambda x: x.var()})

vm_pos_c1 = pos_c1['Peaks'].groupby(pos_c1['ID']).agg({'Mean': lambda x: x.mean(), 'Var': lambda x: x.var()})




def curv(x, a, b):
    return a*x**2+b*x
