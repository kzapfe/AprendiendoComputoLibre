import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb
from scipy.optimize import curve_fit

c1_df = pd.read_csv('/Users/felipeantoniomendezsalcido/Desktop/V_M_Project/C1_21_2_17/C1_21_2_17_data.csv')

c1_df.describe()


pos_c1 = c1_df.loc[(c1_df['Latency']>0.5) & (c1_df['RiseTime']>0) & (c1_df['Latency']<3.5) & (c1_df['RiseTime']<5) & (c1_df['Peaks'] <0)]
pos_c1['Peaks'] = pos_c1['Peaks'].abs()
pos_c1['Peaks']
grouped_df = pos_c1.copy()


idx = pd.MultiIndex.from_product([['Low', 'Normal','High'], ['0.06Hz', '1Hz', '4Hz']], names= ['Condition', 'Fq'])

col = ['Peaks']

df = pd.DataFrame('-', idx, col)

df

df = grouped_df(grouped_df['ID'].str.contains('L06'), ['Peaks'])
a
a.values()
grouped_df.loc(a)


plt.show(sb.stripplot(x='ID', y='Peaks', data=grouped_df, palette= 'Greys_d'))

vm_pos_c1 = pos_c1['Peaks'].groupby(pos_c1['ID']).agg({'Mean': lambda x: x.mean(), 'Var': lambda x: x.var()})

vm_pos_c1.index
vm_pos_c1.index = [i.rsplit('_', 4)[0] for i in vm_pos_c1.index]
ordered_index = ['PP1_L06hz', 'PP2_L06hz', 'PP1_L1hz', 'PP2_L1hz', 'PP1_L4hz', 'PP2_L4hz', 'PP1_Nl06hz', 'PP2_Nl06hz', 'PP1_Nl1hz', 'PP2_Nl1hz', 'PP1_Nl4hz', 'PP2_Nl4hz', 'PP1_H06hz', 'PP2_H06hz', 'PP1_H1hz', 'PP2_H1hz', 'PP1_H4hz', 'PP2_H4hz', 'DCG']

vm_pos_c1.reindex(ordered_index)


plt.show(sb.stripplot(x='Peaks', data=grouped_df))


plt.show(sb.stripplot(x='Mean', y='Var',  data = vm_pos_c1[['4hz' in x for x in vm_pos_c1.index]]))


def curv(x, a, b):
    return a*x**2+b*x
