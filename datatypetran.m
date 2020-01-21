function C=datatypetran(spike_info, electrodes)
C=cell(1,120);
[m,n]=size(spike_info);
for i=1:n
    Index=find(strcmp(electrodes, spike_info(i).chID));
    C{1,Index}=spike_info(i).time';
end