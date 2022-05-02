# Propagation-Signal-and-Synaptic-Coupling-Algorithm
This is a package for detecting propagation signal and identifying synaptic coupling.

## Installation
download the full folder and put it in the path of your matlab. 

## Usage
### Extracting 
To start with a h5 file output from MEA, first use datatypetran.m to convert into the format for this package.

If start with an csv output from MEAviewer, first use datatypetran2.m to convert the data into the format for this package.

These two files extracts the spike times and amplitude for each electrode.
```matlab
C=datatypetran(spike_info, electrodes)
[C,D]=datatypetran2('name.csv',electrodes)
```
electrodes is a list of the electrodes in this device. It is provided in this package in electrodes.mat.

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
