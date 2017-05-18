''' Colección de funciones para extracción de datos y ajuste de funciones para realizar un Variance-Mean Analysis '''

# librerías y módulos requeridos
from neo import io  # paquete diseñado para abrir archivos de propietario
import quantities as qn
import numpy as np
import os
import pandas as pd
import seaborn as sb
%matplotlib inline
import matplotlib.pyplot as plt
''' Funciones que nos ayudan a obtener datos de un
archivo experimental'''


def get_data(recording):
    '''Abre el archivo especificado en 'cell' mediante la funcion correspondiente a archivos .abf'''
    traces = io.AxonIO(filename=recording)
    data = traces.read_block()
    return data


def set_baseline(trace, many=20):
    result = trace - np.mean(trace[0:many - 1])
    return result


def find_stim(trace, threshold=70, PP=0):
    '''[trace=data.segments[x], num, num -> num]
    Regresa el índice del determinado(PP) punto que supere el umbral por defecto.'''
    stim = np.where(trace.analogsignals[0] > threshold)[0][PP]
    return stim


def extract_event(trace, stim_index, start=50, stop=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    extracted = trace.analogsignals[0][stim_index - start:stim_index + stop]
    return extracted


def block_events(data, threshold=70, start=50, stop=500, PP=0, many=100):
    '''funcion que a partir de un Bloque de neo crea una lista de arrays de eventos recortados y alineados.
    No necesitamos crear un nuevo neo.Block, estos arrays conservan toda la información de todas formas.
  '''
    clean_data = []  # events of interest
    for trace in data.segments:
        bs_window = trace.analogsignals[0][0:many]
        if np.std(bs_window) > 20.0:
            print(' Analogsignal ' + str(k) + ' has something fishy')
        else:
            offset = np.mean(bs_window)
            # Toma el primer canal (activo), de cada analogsignal y la recorta
            trace.analogsignals[0] -= offset
            stim_index = find_stim(trace, threshold, PP)
            event = extract_event(trace, stim_index, start, stop)
            clean_data.append(event)  # events of interest
    return clean_data


def get_peaks(clean_data):
    '''Funciones que nos ayudan a obtener los mínimos
    de un arreglo de señales digitales
    '''
    traces = len(clean_data)
    peaks = np.zeros(traces)
    for trace in range(traces):
        peaks[trace] = np.min(clean_data[trace])
    return peaks


''' tidy_dic() funciona, calado y garantizado. Solo falta agregar un if/else si en el nombre va PP2 que tome el segundo estimulo, si no que tome el primero.
'''


def tidy_dic(cell):
    '''[dir -> dictionary]
    '''
    cell_name = cell.split('/')[-2]
    recordings = [cell + rec for rec in os.listdir(cell)]
    tidy_cell = {}
    k = 0
    for recording in recordings:
        key = (recording.split('/')[-1]).strip('_{}.abf'.format(cell_name))
        print('voy en la llave ' + key + ' llevo ' + str(k))
        k += 1
        data = get_data(recording)
        if 'PP2' in key:
            clean_data = block_events(data, PP=1)
            peaks = get_peaks(clean_data)
            tidy_cell[key] = peaks
        else:
            clean_data = block_events(data, PP=0)
            peaks = get_peaks(clean_data)
            tidy_cell[key] = peaks
    return tidy_cell


def datatodf(tidydic):
    ''' Convert dictionary of minimums to dataframe R style '''
        result = pd.DataFrame(dict([(k, pd.Series(v)) for k, v in tidydic.items()]))
    return result


cell = '/Users/felipeantoniomendezsalcido/Desktop/V_M analysis/C1_21_2_17/'

cell_dict = tidy_dic(cell)
cell_dict
rec = '/Users/felipeantoniomendezsalcido/Desktop/V_M analysis/C1_21_2_17/PP2_H4hz_C1_21_2_17.abf'
data = get_data(rec)

for i in data.segments:
    plt.plot(i.analogsignals[0])
