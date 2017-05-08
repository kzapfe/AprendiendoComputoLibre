
''' Funciones auxiliares para hacer mean-var analysis a lo
Clemens '''


from neo import io
import quantities as qn
import numpy as np
import scipy

''' Funciones que nos ayudan a obtener datos de un
archivo experimental'''

def detectaestimulo(datos, umbral=100, cual=0):
    '''Funcion que da el  estimulo indicado que 
    pasa de un umbral de un analogsignal'''
    primer=np.where(datos>umbral)[0][cual]
    primer=int(primer)
    return primer

def recortasegnal(datos, indice, desde=50, hasta=500):
    '''Funcion que nos recorta una señal a partir de un indice'''
    result=datos[indice-desde:indice+hasta]
    return result

def nuevobloque(bloqueviejo,umbral=100, desde=50,hasta=500, cual=0):
    '''funcion que a partir de un Bloque de neo
 crea otro recortado y alineado'''
    result=Block()
    for j in bloqueviejo.segments:
        #Toma el primer canal (activo), de cada analogsignal y la recorta
        estimindex=detectaestimulo(j.analogsignals[0], umbral, cual)
        cacho=recortasegnal(j.analogsignals[0],estimindex, desde, hasta)
        result.segments.append(cacho)
    return result

''' 
Funciones que nos ayudan a obtener los mínimos 
de un arreglo de señales digitales y luego saca el promedio y la variancia
'''

def listaminimos(datos):
    cuantos=datos.size["segments"]
    result=np.zeros(cuantos)
    for j in range(cuantos):
        result[j]=np.min(datos.segments[j])
    return result


def minpromvar(datos):
    minimos=listaminimos(datos)
    result=(np.mean(minimos),np.var(minimos))
    return result
