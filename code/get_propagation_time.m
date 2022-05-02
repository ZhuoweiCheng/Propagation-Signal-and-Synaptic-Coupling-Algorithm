function time_all=get_propagation_time(ListofPropagation,spike_times)
% This function generates a sequence of propagation eAPs for each 
% propagation using different number of anchor points.
%  
% 
%   Inputs:
%       ListofPropagation:
%           Output of get_propagation.m. cell array contains tables of 
%           electrode cohorts for each propagation in a recording. Each 
%           table provides a list of candidate electrodes along with the 
%           latency between each electrode with the reference electrode, 
%           the number of co-occurrences and the n2/n1 ratio.
%       spike_times:
%           1 x N cell. N cells represent N electrodes. Each cell contains 
%           a 1 x m vector representing the spike times for each electrode.
%           The spike times should be in units of ms. This code deals with 
%           data sampled at 20000Hz. Upsample or downsample your data into 
%           20000Hz sample rate before feeding into the algorithm.

%   Output:
%       time_all:
%           A cell array where each cell contains a list of spike times in 
%           the propagation with different number of anchor points chosen 
%           for each propagation in ListofPropagation with the same order. 
%           The first element in each cell is the number of propagating 
%           spike times isolated with two anchor points, the second element
%           is the propagating spike times isolated with three anchor 
%           points, etc., until all constituent electrodes are used as 
%           anchor points.
[m,n] = size(ListofPropagation);
time_all = [];
for i = 1:n
    time_signal = [];
    time = [];
    current_signal = ListofPropagation{1,i};
    index = find(current_signal.latency > 0.001);
    index = [1; index];
    current_signal = current_signal(index,:);
    [sizeofsignal,~] = size(current_signal);
    ind1 = 1;
    current_signal.smallwindow_cooccurrences(ind1) = -888;
    ID1 = current_signal.ID(ind1);
    reference_spike_times = spike_times{1,ID1};
    for n_ele = 2:sizeofsignal
        ind_all = [];
        [max2, ind2] = max(current_signal.smallwindow_cooccurrences);
        current_signal.smallwindow_cooccurrences(ind2) = -888;        
        ID2 = current_signal.ID(ind2);        
        target_spike_times = spike_times{1, ID2};
        [m1,n1] = size(reference_spike_times);  
        for j = 1:n1
            index = find(target_spike_times > reference_spike_times(1, j) & target_spike_times < reference_spike_times(1, j)+1.5);
            if isempty(index) ~= 1
                ind_all = [ind_all j];
            end          
        end
        time = [time reference_spike_times(ind_all)];
        time_signal{1,n_ele} = sort(unique(time));
    end
    time_all{1,i} = time_signal;
end
end