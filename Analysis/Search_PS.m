%PS is in the form of a cell in signals
function [output, overlap_percentage]=Search_PS(PS, signals)
[~,z]=size(signals);
temp=PS;
[max1, ind1] = max(temp.number_of_spikes);
temp.number_of_spikes(ind1) = -888;
[max2, ind2] = max(temp.number_of_spikes);
r1=temp.ID(ind1);
r2=temp.ID(ind2);
output=[];
count=1;
for i = 1:z
    temp2=signals{1,i}
    if ismember(r1,temp2.ID)&ismember(r2,temp2.ID)==1
        output(1,count)=i;
        count=count+1;
    end
end

vector1=PS.ID;
overlap_percentage=zeros(1,z);
for i = 1:z
    vector2=signals{1,i}.ID;
    overlap_percentage(1,i)=length(intersect(vector1,vector2))/length(vector1);
end
end
