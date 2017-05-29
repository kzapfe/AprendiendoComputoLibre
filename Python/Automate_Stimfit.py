import stf
import os
import csv


def set_cursos(recording):
    """ [str -> NonType]
    Set base_line and peak, as for now, cursos either for first or second pulse.
    """
    if 'PP2' in recording:
        stf.set_base_start(114, True)
        stf.set_base_end(116.5, True)
        stf.set_peak_start(118, True)
        stf.set_peak_end(230, True)
    else:
        stf.set_base_start(30, True)
        stf.set_base_end(55, True)
        stf.set_peak_start(58, True)
        stf.set_peak_end(115, True)
    return


def get_values(recording):
    """ [str, int -> tupple]
    Set the identificator of each measurement, gets peak, risetime, latency and gives back a tupple.
    """
    ID = str(recording).strip('.abf')
    peak = stf.get_peak()-stf.get_base()
    risetime = stf.get_risetime()
    if 'PP2' in recording:
         latency = (stf.foot_index()-1170) * stf.get_sampling_interval()
    else:
        latency = (stf.foot_index()-570) * stf.get_sampling_interval()
    values = (ID, peak, risetime, latency)
    return values


def get_values_from(recording, data_list):
    stf.select_all()
    indices = stf.get_selected_indices()
    for i in indices:
        stf.set_trace(i)
        data_list.append(get_values(recording))
    return data_list


def write_data(data_filename, data_list):
    with open(data_filename, 'wb') as csvfile:
      line_writer = csv.writer(csvfile, delimiter = ',', quoting=csv.QUOTE_NONNUMERIC)
      line_writer.writerows(data_list)


def analyze_cell(PATH):
    os.chdir(str(PATH))
    cell = str(PATH).split('/')[-1]
    recordings = os.listdir(PATH)
    data_filename = cell+'_data.csv'
    data_list = [('ID', 'Peaks', 'RiseTime', 'Latency')]
    for recording in recordings:
        stf.file_open(recording)
        set_cursos(recording)
        get_values_from(recording, data_list)
        stf.close_this()
    write_data(data_filename, data_list)
    print('Done')
