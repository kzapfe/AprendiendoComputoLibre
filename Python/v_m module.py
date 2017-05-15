
''' Colección de funciones para extracción de datos y ajuste de funciones para realizar un Variance-Mean Analysis '''

# librerías y módulos requeridos
from neo import io  # paquete diseñado para abrir archivos de propietario
import quantities as qn
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb
%matplotlib inline
import os


''' Funciones que nos ayudan a obtener datos de un
archivo experimental'''


def get_data(recording):
    '''Abre el archivo especificado en 'cell' mediante la funcion correspondiente a archivos .abf'''
    traces = io.AxonIO(filename=recording)
    data = traces.read_block()
    return data


def find_stim(trace, threshold=100, PP=0):
    '''[trace=data.segments[x], num, num -> num]
    Regresa el índice del determinado(PP) punto que supere el umbral por defecto.'''
    stim = np.where(trace.analogsignals[0] > threshold)[0][PP]
    return stim


def extract_event(trace, stim_index, start=50, stop=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    extracted = trace.analogsignals[0][stim_index - start:stim_index + stop]
    return extracted


def block_events(data, threshold=100, start=50, stop=500, PP=0):
    '''funcion que a partir de un Bloque de neo crea una lista de arrays de eventos recortados y alineados. No necesitamos crear un nuevo neo.Block, estos arrays conservan toda la información de todas formas.
 '''
    clean_data = []  # events of interest
    for trace in data.segments:
        # Toma el primer canal (activo), de cada analogsignal y la recorta
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


''' Hasta aquí todas funcionan individualmente. tidy_dic debería correr archivo por archivo extraer el nombre como llave y asignarle el array de picos. La extracción de nombres y asignación al diccionario funcionan pero por alguna razón las funciones de extracción de datos no funcionan en loop.
    La idea final sería pasarle un directorio de un folder que sea en sí mismo un experimento completo y regrese un diccionario con los nombres de los factores como llaves y su respectivo array con los valores de minimos (picos). Este diccionario podría pasarse a un pandas.DataFrame fácilmente si esta bien ordenado.
'''


def tidy_dic(cell):
    '''[dir -> dictionary]
    '''
    cell_name = cell.split('/')[-2]
    recordings = [cell + rec for rec in os.listdir(cell)]
    tidy_cell = {}
    for recording in recordings:
        key = (recording.split('/')[-1]).strip('_{}.abf'.format(cell_name))
        data = get_data(recording)
        clean_data = block_events(data, threshold=100, start=50, stop=500, PP=0)
        peaks = get_peaks(clean_data)
        tidy_cell[key] = peaks
    return tidy_cell


tidy_dic(cell)
cel
cell = '/Users/felipeantoniomendezsalcido/Desktop/V_M analysis/C1_21_2_17/'
recordings = [cell + rec for rec in os.listdir(cell)]
recording = recordings[1]
all_peaks = []
for rec in recordings:
    data = get_data(rec)
    for trace in data.segments:
        stim_index = find_stim(trace)
        extracted = extract_event(trace, stim_index)
        peaks = np.min(extracted)
        all_peaks.append(peaks)
return all_peaks
data
all_peaks
for rec in recordings:
    print(rec)
