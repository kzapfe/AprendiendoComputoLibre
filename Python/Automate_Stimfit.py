import stf
import os
import csv

cell = '/Users/felipeantoniomendezsalcido/Desktop/V_M_Project/C1_21_2_17'

os.chdir(cell)

recordings = os.listdir(cell)

def set_stf(PATH):
    os.chdir(str(PATH))
    cell = str(PATH).split('/')[-1]
    data_filename = cell+'_data.csv'
    return cell, data_filename


def set_cursos(bs_start = 30, bs_end=55, p_st=58, p_end=115) :
    """ [int, int, int, int -> NonType]
    Set base_line and peak, as for now, cursos
    """
    stf.set_base_start(bs_start, True)
    stf.set_base_end(bs_end, True)
    stf.set_peak_start(p_st, True)
    stf.set_peak_end(p_end, True)
    return


def get_values():
    ID = recording
    peak = stf.get_peak()-stf.get_base()
    risetime = stf.get_risetime()
    latency = (stf.foot_index()-570) * stf.get_sampling_interval()
    values = (ID, peak, risetime, latency)
    return values


def get_values_from(recording):
    stf.select_all()
    indices = stf.get_selected_indices()
    recording_values = []
    for i in indices:
        set_trace(i)
        recording_values.append(get_values())
    return recording_values

with open(data_filename, 'wb') as csvfile:
    line_writer = csv.writer(csvfile, delimiter = ',', )
    line_writer.writerow(['ID', 'Peak', 'RiseTime', 'Latency'])
