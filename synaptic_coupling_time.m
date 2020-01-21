function R_time=synaptic_coupling_time(signals,C)
spiketimeinterval=0.7;
t=int64(spiketimeinterval/0.05);
acc=0.05;
[m,n]=size(signals);
R_time=cell(1,n);
for i=1:n
    temp=signals{1,i};
    ind1=1;
    temp.number_of_spikes(ind1) = -888;
    [max2, ind2] = max(temp.number_of_spikes);
    r1=temp.ID(ind1);
    r2=temp.ID(ind2);
    delay=temp.delay(ind2);
    rc1=C{1,r1};
    rc2=C{1,r2};
    [m1,n1]=size(rc1);
    k=1;
    time=zeros(1,1);
    for j=1:n1
        count=0;
        for binvalue = delay-0.35:0.05:delay+0.35
            if isempty(find(rc2==rc1(1,j)+binvalue))==0
                count=1;
                delaytime=binvalue;
                break;
            end
        end
        if count==1
            time(1,k)=rc1(1,j)+delaytime/2;
            k=k+1;
        end            
    end
    R_time{1,i}=round(time/acc)*acc;
end
end