%%
%spike_times is the spike times from 120 electrodes. Each cell contains the
%spike time from one electrode. The time unit is ms. This recording is 180s
%in total and we used 1hz as the thresholding for the spiking frequency of
%the reference electrode. Put [] for thres_number_spikes.
[ListofPropagation, Time_all] = automated_detection_propagation(spike_times, 1, 180, [], 0.5, 50, 50);

%%
%Instead of thresholding for spiking frequency of the reference electrode,
%you can also use an absolute number to threshold the total number of
%spikes needed on each electrode. Put [] for thres_freq and 
%seconds_recording and the number you want to use for thres_number_spikes.
%Here we put 180.
[ListofPropagation, Time_all] = automated_detection_propagation(spike_times, [], [], 180, 0.5, 50, 50);