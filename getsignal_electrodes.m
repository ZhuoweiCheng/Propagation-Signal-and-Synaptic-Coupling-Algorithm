function signals=getsignal_electrodes(A,electrodes)
signalspre=A(~cellfun('isempty',A));
[m,numbers]=size(signalspre);
for i=1:numbers
    temps=signalspre{1,i};
    [m1,n1]=size(temps);
    for j=1:n1
        count=0;
        if temps(3,j)>50
            count=1;
        end
    end
    if temps(2,:)>=0&n1>1&count==1
        [temp, order] = sort(temps(2,:));
        temps = temps(:,order);
        ID=temps(1,:)';
        number_of_spikes=temps(3,:)';
        delay=temps(2,:)';
        name=electrodes(temps(1,:));
        signals{1,i}=table(ID, name,delay,number_of_spikes);
    end
end
signals=signals(~cellfun('isempty',signals));
end


