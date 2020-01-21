function [C, D]=datatypetran2(myfile, electrodes)

data = readtable(myfile);
locations=data.electrode;
[uniquelocs,ua,uc]=unique(locations,'stable');
electrodes=lower(electrodes);
[sharedvals,idx] = intersect(electrodes,uniquelocs,'stable');


[m,n]=size(ua);
C=cell(1,120);
D=cell(1,120);
for i=1:m-1
    C{1,idx(i,1)}=data.time(ua(i):ua(i+1)-1);
    D{1,idx(i,1)}=data.amplitude(ua(i):ua(i+1)-1);
end
C{1,idx(m,1)}=data.time(ua(m):end);
D{1,idx(m,1)}=data.amplitude(ua(m):end);


for i=1:120
    C{1,i}=C{1,i}*1000;
end
acc = 0.05;
for i=1:120
C{1,i} = round(C{1,i}/acc)*acc;
C{1,i} = C{1,i}';
D{1,i} = D{1,i}';
end

end