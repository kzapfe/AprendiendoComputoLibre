''' Colección de funciones para extracción de datos y ajuste de funciones para realizar un Variance-Mean Analysis '''

# librerías y módulos requeridos
from neo import io  # paquete diseñado para abrir archivos de propietario
import quantities as qn
import numpy as np
import os
import pandas as pd
#import seaborn as sb
# %matplotlib inline
''' Funciones que nos ayudan a obtener datos de un
archivo experimental'''



def get_data(recording):
    '''Abre el archivo especificado en 'cell' mediante la funcion correspondiente a archivos .abf'''
    traces = io.AxonIO(filename=recording)
    data = traces.read_block()
    return data

def set_baseline(trace, many=20):
    result=trace-np.mean(trace[0:many-1])
    return result


    
def find_stim(trace, threshold=60, PP=0):
    '''[trace=data.segments[x], num, num -> num]
    Regresa el índice del determinado(PP) punto que supere el umbral por defecto.'''
    stim = np.where(trace.analogsignals[0] > threshold)[0][PP]
    return stim


def extract_event(trace, stim_index, start=50, stop=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    extracted = trace.analogsignals[0][stim_index - start:stim_index + stop]
    return extracted


def block_events(data, threshold=60, start=50, stop=500, PP=0, many=100):
    '''funcion que a partir de un Bloque de neo crea una lista de arrays de eventos recortados y alineados.
    No necesitamos crear un nuevo neo.Block, estos arrays conservan toda la información de todas formas.
  '''
    clean_data = []  # events of interest
    k=0        
    for trace in data.segments:
        values=trace.analogsignals[0][0:many]
        
        if np.std(values)>20.0 *qn.pA :
            print(' Analogsignal '+str(k)+' has something fishy')
        else:
            prom=np.mean(values)
            # Toma el primer canal (activo), de cada analogsignal y la recorta
            trace.analogsignals[0]=trace.analogsignals[0]-prom
            stim_index = find_stim(trace, threshold, PP)
            event = extract_event(trace, stim_index, start, stop)
            #print(str(stim_index)+' '+str(start)+' '+str(stop))
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


''' Hasta aquí todas funcionan individualmente. tidy_dic debería correr archivo por archivo extraer el nombre como llave y asignarle el array de picos. La extracción de nombres y asignación al diccionario funcionan pero por alguna razón las funciones de extracción de datos no funcionan en loop.
    La idea final sería pasarle un directorio de un folder que sea en sí mismo un experimento completo y regrese un diccionario con los nombres de los factores como llaves y su respectivo array con los valores de minimos (picos). Este diccionario podría pasarse a un pandas.DataFrame fácilmente si esta bien ordenado.
'''


def tidy_dic(cell):
    '''[dir -> dictionary]
    '''
    cell_name = cell.split('/')[-2]
    recordings = [cell + rec for rec in os.listdir(cell)]
    tidy_cell = {}
    k=0
    for recording in recordings:
        key = (recording.split('/')[-1]).strip('_{}.abf'.format(cell_name))
        print('voy en la llave '+key+' llevo '+str(k)) 
        data = get_data(recording)
        
        clean_data = block_events(data)
        peaks = get_peaks(clean_data)
        tidy_cell[key] = peaks
    return tidy_cell
   


def datatodf(tidydic):
    ''' Convert dictionary of minimums to dataframe R style '''
     result=pndf.DataFrame(dict([(k,pn.Series(v)) for k,v in tidydic.items() ]))
    return result
    



#tidy_dic(cell)
#cel
#cell = '/Users/felipeantoniomendezsalcido/Desktop/V_M analysis/C1_21_2_17/'
#recordings = [cell + rec for rec in os.listdir(cell)]
#recording = recordings[1]
#all_peaks = []
#for rec in recordings:
#    data = get_data(rec)
#    for trace in data.segments:
#        stim_index = find_stim(trace)
#        extracted = extract_event(trace, stim_index)
#        peaks = np.min(extracted)
#        all_peaks.append(peaks)
   # return all_peaks
#data
#all_peaks
#for rec in recordings:
#    print(rec)

