# Propagation-Signal-and-Synaptic-Coupling-Algorithm
This is a package for detecting eAP propagation and identifying synaptic coupling.

## Installation
download the full folder and put it in the path of your matlab. This works on Matlab 2018 and later versions.

## Usage
The input of our algorithm is a cell array (1 x N cell) of spike times where each cell represent one electrode. 
Each cell contains a 1 x m vector representing the spike times for each electrode. The spike times should be in units of ms. 
This code deals with data sampled at 20000Hz. Upsample or downsample your data into 20000Hz sample rate before feeding into the algorithm.

Next, use automated_p_s_c.m to extract the propagation signals and synaptic coupling information in the array
```matlab
[signals, s_c_1, R_time, s_c_table, Bin_Histogram, delay_time]=automated_p_s_c(C, D, electrodes)
```
signals is a table of propagation signals.

R_time is the spike times of each signal.

s_c_table returns a table of the coupling between each signal and downstream electrodes.

Bin_Histogram and delay_time provide the Cross correlagrams and the latency information for each signal-electrode pair.

### Post analysis
Matching_PS.m and Search_PS are used to find similar propagation signals in different arrays. They can be used to compare between the same culture at different div or before-/after-drug.

Updatesctable_kstest.m can update the s_c_table with ks test stats comparing the amplitude distribution between the synaptic couple spikes and all spikes on a certain electrode.
