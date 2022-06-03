# Propagation-Signal-and-Synaptic-Coupling-Algorithm
This is a package for detecting eAP propagation and identifying synaptic coupling.

## Installation
download the full folder and put it in the path of your matlab. This works on Matlab R2018a and later versions.

## Usage
The input of our algorithm is a cell array (1 x N cell) of spike times where each cell represent one electrode. 
Each cell contains a 1 x m vector representing the spike times for each electrode. The spike times should be in units of ms. 
This code deals with data sampled at 20000Hz. Upsample or downsample your data into 20000Hz sample rate before feeding into the algorithm.

Next, use automated_detection_propagation.m to extract the propagation signals in the array
```matlab
[ListofPropagation, Time_all] = automated_detection_propagation(spike_times, freq_thres, seconds_recording, thres_number_spikes, ratio, thres_number_spikes, p);
```
An example is provided in Analysis/Example.

### Inputs:

**spike_times:**

1 x N cell. N cells represent N electrodes. Each cell contains a 1 x m vector representing the spike times for each electrode. The spike times should be in units of ms. This code deals with data sampled at 20000Hz. Upsample or downsample your data into 20000Hz sample rate before feeding into the algorithm.
          
**freq_thres:** 

This value representing the frequency lower bound of the spiking
          frequency for all electrodes. Only electrodes that's above the
          threshold will considered as a reference electrode. For 
          example, enter 1 for 1Hz.
          
**seconds_recording:**

The length of recording in seconds. For example, enter 120 for 
          2 minutes recordings.
          
**thres_number_spikes:**
lower bound of the number of short latency co-occurrences each electrode needs to have.

**ratio:**

Let n1 denote the largest sum of counts in any 0.5 ms moving 
          window in the CCG and n2 denote the sum of counts of the 2 ms 
          window with the location of the largest sum in the center. 
          If the largest sum is found in the first 1 ms or the last 1 ms
          of the CCG, take the sum of the counts of the first 2 ms window
          or the counts of the last 2 ms window as n2. This ratio is the 
          lower bound threshold for n2/n1. 
          
**thres_cooccurrences:**
lower bound of the number of short latency co-occurrences (n1) each
          electrode needs to have.
          
**p:**

percentage of the maximum number of co-occurrences required for
          all constituent electrodes. p should be between 0 to 100.

### Outputs:

**ListofPropagation:**
      
cell array contains tables of electrode cohorts for each
          propagation in a recording. Each table provides a list of
          candidate electrodes along with the latency between each
          electrode with the reference electrode, the number of
          co-occurrences and the n2/n1 ratio.
          
**Time_all:**
      
A cell array where each cell contains a list of spike times in 
          the propagation with different number of anchor points chosen 
          for each propagation in ListofPropagation with the same order. 
          The first element in each cell is the number of propagating 
          spike times isolated with two anchor points, the second element
          is the propagating spike times isolated with three anchor 
          points, etc., until all constituent electrodes are used as 
          anchor points.


### Post analysis
Matching_PS.m and Search_PS are used to find similar propagation signals in different arrays. They can be used to compare between the same culture at different div or before-/after-drug.

Updatesctable_kstest.m can update the s_c_table with ks test stats comparing the amplitude distribution between the synaptic couple spikes and all spikes on a certain electrode.

Analysis examples are given in Analysis/Example/example.m
