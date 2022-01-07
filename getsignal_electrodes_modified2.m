function signals=getsignal_electrodes_modified2(A,electrodes)
%A = A(~cellfun('isempty',A));
[m,numbers]=size(A);
signals=[];
for i=1:numbers
    if isempty(A{1,i})~=1
        temps=A{1,i};
        [m1,n1]=size(temps);
        for j = n1:-1:1
            if temps(3,j)<50
                temps(:,j)=[];
            end
        end
        [m1,n1]=size(temps);
        if isempty(temps)~=1&sum(temps(2,:)<0)==0&n1>1
            index = find(temps(1,:)==i);
            if isempty(index)~=1
                [temp, order] = sort(temps(2,:));
                order(find(order == index))=[];
                order = [index order];
                temps = temps(:,order);
                ID=temps(1,:)';
                number_of_spikes=temps(3,:)';
                delay=temps(2,:)';
                name=electrodes(temps(1,:));
                signals{1,i}=table(ID, name,delay,number_of_spikes);
            end
        end
    end
end
if isempty(signals)~=1
    signals=signals(~cellfun('isempty',signals));
end
end