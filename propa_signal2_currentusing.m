function A=propa_signal2_currentusing(C)
n_e=length(C);
spiketimeinterval=0.5;
t=int64(spiketimeinterval/0.05);
A=cell(1,n_e);
delta=0.05/10;
for electrode=1:n_e
    temp=C{1,electrode};
    [~,n]=size(temp);
    %assume in ms scale
    if ~isempty(temp)&&n>=0.002*temp(1,n)  
        timedelay=zeros(1,n_e);
        for loopnumber = 1:n_e
        timedelay(1,loopnumber)=-999; 
        end
        numberofspikes=zeros(1,n_e);
        a_binbox_ratio=-999*ones(1,n_e);
        for electrode2=1:n_e
            Binbox=zeros(1,61);  
                temp2=C{1,electrode2};
                for k=1:n
                    for binvalue = -1.5:0.05:1.5
                        if isempty(find(temp2<temp(1,k)+binvalue+delta&temp2>temp(1,k)+binvalue-delta))==0
                            Binbox(1,int64(binvalue/0.05+31))=Binbox(1,int64(binvalue/0.05+31))+1;
                        end
                    end
                end
                a=sum(Binbox(1,1:1+t));
                location=1;
                for i=1:61-t
                    if sum(Binbox(1,i:i+t))>a
                        a=sum(Binbox(1,i:i+t));
                        location=i;
                    end
                end
                delay=find(Binbox(1,location:location+t)==max(Binbox(1,location:location+t)),1);
                delay=double(location+delay-1);
                if delay > 20 && delay < 41
                    Binbox_n = sum(Binbox(delay-20:delay+20));
                end
                if delay <= 20
                    Binbox_n = sum(Binbox(1:41));
                end
                if delay >= 41
                    Binbox_n = sum(Binbox(21:61));
                end
                if a>=0.5*Binbox_n&&Binbox_n>=1
                    timedelay(1,electrode2)=(delay-31)*0.05;
                    numberofspikes(1,electrode2)=a;
                    a_binbox_ratio(1,electrode2)=a/Binbox_n;
                end        
        end
        index=find(timedelay>=-1.5);
        A{1,electrode}(1,:)=index;
        A{1,electrode}(2,:)=timedelay(index);
        A{1,electrode}(3,:)=numberofspikes(index);
        A{1,electrode}(4,:)=a_binbox_ratio(index);
    end
end
end
