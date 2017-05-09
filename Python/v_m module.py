
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

cell = '/Users/felipeantoniomendezsalcido/Desktop/V_M analysis/C1_21_2_17/PP1_L06hz_C1_21_2_17.abf'


def get_data():
    '''Abre el archivo especificado en 'cell' mediante la funcion correspondiente a archivos .abf'''
    traces = io.AxonIO(filename=cell)
    data = traces.read_block()


data = get_data()


def show_data(data):
    '''Grafica todos los trazos'''
    for i in data.segments:
        plt.plot(i.analogsignals[0])


def find_stim(data, threshold=100, PP=0):
    '''Funcion que da el índice estimulo indicado que
    pasa de un umbral de un analogsignal. Regresa el primer punto que supere el umbral por defecto'''
    stim = np.where(data > threshold)[0][PP]
    stim = int(stim)
    return primer


def extract_event(data, index, start=50, stop=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    extracted = data[index - start:indice + stop]
    return extracted


def extracted_block(data, threshold=100, start=50, stop=500, PP=0):
    '''funcion que a partir de un Bloque de neo
 crea otro recortado y alineado'''
# Al parecer este bloque no contiene todos los atributos necesarios
    eoi = Block()  # events of interest
    for trace in data.segments:
        # Toma el primer canal (activo), de cada analogsignal y la recorta
        stim_index = find_stim(trace.analogsignals[0], threshold, PP)
        event = extract_event(trace.analogsignals[0], stim_index, start, stop)
        eoi.segments.append(event)
    return eoi


'''
Funciones que nos ayudan a obtener los mínimos
de un arreglo de señales digitales y luego saca el promedio y la variancia
'''


def peaks(clean_data):
    traces = clean_data.size["segments"]
    peaks = np.zeros(traces)
    for trace in range(traces):
        peaks[trace] = np.min(clean_data.segments[trace])
    return peaks


def M_V(clean_data):
    peak_values = peaks(clean_data)
    M_V = (np.mean(minimos), np.var(minimos))
    return result
