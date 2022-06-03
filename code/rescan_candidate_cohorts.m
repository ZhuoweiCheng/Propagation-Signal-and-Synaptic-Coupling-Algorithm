function ElectrodeCohorts = rescan_candidate_cohorts(CandidateCohorts, thres_cooccurrences, p)
% This function rescans each set of candidate electrodes found for each 
% reference electrode. First, find the electrode with the maximum number of
% co-occurrences with the reference electrode. Second, scan through all 
% other electrodes in the set of candidate electrodes, to identify only 
% the electrodes with more than p * the maximum number of co-occurrences
% and more than thres_number_spikes co-occurrences in the 0.5ms window with
% maximum number of co-occurrences in the CCG. The electrodes that satisfy 
% this criterion are kept in ElectrodeCohorts.
%  
% 
%   Inputs:
%       CandidateCohorts:
%           Output of scan_reference_electrode.m. cell array contains a 
%           list of candidate constituent electrodes for each reference 
%           electrode. Each cell provides a list of candidate electrodes 
%           along with the latency between each electrode with the 
%           reference electrode, the number of co-occurrences and the n2/n1
%           ratio.
%       thres_number_spikes:
%           lower bound of the number of short latency co-occurrences each
%           electrode needs to have.
%       p:
%           percentage of the maximum number of co-occurrences required for
%           all constituent electrodes. p should be between 0 to 100.

%   Output:
%       ElectrodeCohorts:
%           cell array contains a list of constituent electrodes
%           for each reference electrode. Each cell provides a list of
%           candidate electrodes along with the latency between each
%           electrode with the reference electrode, the number of
%           co-occurrences and the n2/n1 ratio.
[m,numbers] = size(CandidateCohorts);
ElectrodeCohorts = cell(1,numbers);
for i = 1:numbers
    if isempty(CandidateCohorts{1,i}) ~= 1
        current_cell = CandidateCohorts{1,i};
        [m1,n1] = size(current_cell);
        for j = n1:-1:1
            if current_cell(3,j) < thres_cooccurrences
                current_cell(:,j) = [];
            end
        end
        reference = find(current_cell(1,:) == i);
        non_zero_electrodes = find(current_cell(2,:) ~= 0);
        target_electrodes = setdiff(non_zero_electrodes, reference);
        if isempty(target_electrodes) ~= 1
            cooccurrences = p/100 * max(current_cell(3,target_electrodes));
            index = find(current_cell(3,:)>=cooccurrences);
            index = union(index, reference);
            current_cell_new = current_cell(:,index);
            ElectrodeCohorts{1,i} = current_cell_new;
        end
    end
end
end
