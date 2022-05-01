function ListofPropagation=get_propagation(ElectrodeCohorts)
%This generates a collection of cohort electrodes, each representing an eAP
% propagation in each recording.
% 
%   Inputs:
%       ElectrodeCohorts:
%           output of rescan_candidate_cohorts.m

%   Output:
%       ListofPropagation:
%           cell array contains tables of electrode cohorts for each
%           propagation in a recording. Each table provides a list of
%           candidate electrodes along with the latency between each
%           electrode with the reference electrode, the number of
%           co-occurrences and the n2/n1 ratio.
%
[m,numbers]=size(ElectrodeCohorts);
ListofPropagation=[];
for i=1:numbers
    if isempty(ElectrodeCohorts{1,i})~=1
        temps=ElectrodeCohorts{1,i};
        [m1,n1]=size(temps);
        if isempty(temps)~=1&sum(temps(2,:)<0)==0&n1>1
            index = find(temps(1,:)==i);
            if isempty(index)~=1
                [temp, order] = sort(temps(2,:));
                order(find(order == index))=[];
                order = [index order];
                temps = temps(:,order);
                ID=temps(1,:)';
                smallwindow_cooccurrences=temps(3,:)';
                latency=temps(2,:)';
                n1_n2_ratio = temps(4,:)';
                ListofPropagation{1,i}=table(ID,latency,smallwindow_cooccurrences,n1_n2_ratio);
            end
        end
    end
end
if isempty(ListofPropagation)~=1
    ListofPropagation=ListofPropagation(~cellfun('isempty',ListofPropagation));
end
end
