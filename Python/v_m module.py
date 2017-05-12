
''' Colección de funciones para extracción de datos y ajuste de funciones para realizar un Variance-Mean Analysis '''

# librerías y módulos requeridos
import neo as neo  # paquete diseñado para abrir archivos de propietario
import quantities as qn
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb
%matplotlib inline
import os


''' Funciones que nos ayudan a obtener datos de un
archivo experimental'''


def get_data(cell, recording):
    '''[dir, index -> neo.block]
    Abre el archivo especificado en 'cell' mediante la funcion correspondiente a archivos .abf'''
    recordings = [cell+'/'+rec for rec in os.listdir(cell)]
    traces = neo.io.AxonIO(filename=recordings[int(recording)])
    data = traces.read_block()
    return data

def show_data(data):
    '''Grafica todos los trazos'''
    for i in data.segments:
        plt.plot(i.analogsignals[0])


def find_stim(data, threshold=100, PP=0):
    '''Funcion que da el índice estimulo indicado que
    pasa de un umbral de un analogsignal. Regresa el primer punto que supere el umbral por defecto'''
    stim = np.where(data.segments[].analogsignals[0] > threshold)[0][PP]
    stim = int(stim)
    return stim

stim = np.where(data.segments[0].analogsignals[0] > 100)
stim
type(data)
def extract_event(data, index, start=50, stop=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    extracted = data[index - start:index + stop]
    return extracted


# def block_events(data, threshold=100, start=50, stop=500, PP=0):
#     '''funcion que a partir de un Bloque de neo
#  crea otro recortado y alineado'''
# # Al parecer este bloque no contiene todos los atributos necesarios
#     clean_data = neo.core.Block()  # events of interest
#     for trace in data.segments:
#         # Toma el primer canal (activo), de cada analogsignal y la recorta
#         stim_index = find_stim(trace.analogsignals[0], threshold, PP)
#         event = extract_event(trace.analogsignals[0], stim_index, start, stop)
#         clean_data.segments.append(event)  # events of interest
#     return clean_data

def clean_data(data, threshold=100, start=50, stop=500, PP=0):
    '''[neo,block, int, int, int, int -> list]
    Crea una lista de n.arrays con los eventos extraidos de cada señal determinados desde el indice-50 hasta indice+500, el indice determina el estimulo
    '''
    clean_data = []
    for trace in data.segments:
        stim_index = find_stim(trace.analogsignals[0], threshold, PP)
        event = extract_event(trace.analogsignals[0], stim_index, start, stop)
        clean_data.append(event)
    return clean_data

def show_clean_data():
    '''In case you wanna check them'''
    for i in clean_data.segments:
        plt.plot(i.analogsignals[0])


'''
Funciones que nos ayudan a obtener los mínimos
de un arreglo de señales digitales y luego saca el promedio y la variancia
'''


def peaks(clean_data):
    peaks = np.zeros(traces)
    for trace in range(clean_data.size["segments"]):
        peaks[trace] = np.min(clean_data.segments[trace])
    return peaks


# def M_V(clean_data):
#     peak_values = peaks(clean_data)
#     M_V = (np.mean(minimos), np.var(minimos))
#     return result


cell = input()
def tidy_dic(cell):
    '''[dir -> dictionary]
    '''
    tidy_cell = {}
    for i in os.listdir(cell):
        key = i.split('.')[0]
        tidy_cell[key] =
    return tidy_cell
tidy_dic(cell)

clean_data(data)
data.segments
