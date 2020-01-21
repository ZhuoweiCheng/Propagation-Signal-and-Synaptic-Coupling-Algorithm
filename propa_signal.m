function A=propa_signal(C)
spiketimeinterval=0.5;
t=int64(spiketimeinterval/0.05);
A=cell(1,120);
for electrode=1:120
    temp=C{1,electrode};
    [m,n]=size(temp);
    %assume in ms scale
    if ~isempty(temp)&&n>=0.002*temp(1,n)  
        timedelay=zeros(1,120);
        for loopnumber = 1:120
        timedelay(1,loopnumber)=-999;
        end
        numberofspikes=zeros(1,120);
        for electrode2=1:120
            Binbox=zeros(1,81);      
                temp2=C{1,electrode2};
                for k=1:n
                    for binvalue = -2:0.05:2
                        if isempty(find(temp2==temp(1,k)+binvalue))==0
                            Binbox(1,int64(binvalue/0.05+41))=Binbox(1,int64(binvalue/0.05+41))+1;
                        end
                    end
                end
                a=sum(Binbox(1,1:1+t));
                location=1;
                for i=1:81-t
                    if sum(Binbox(1,i:i+t))>a
                        a=sum(Binbox(1,i:i+t));
                        location=i;
                    end
                end
                if a>=0.3*n
                    delay=find(Binbox(1,location:location+t)==max(Binbox(1,location:location+t)),1);
                    delay=double(location+delay-1);
                    timedelay(1,electrode2)=(delay-41)*0.05;
                    numberofspikes(1,electrode2)=a;
                end
          
        
        end
        index=find(timedelay>=-2);
        A{1,electrode}(1,:)=index;
        A{1,electrode}(2,:)=timedelay(index);
        A{1,electrode}(3,:)=numberofspikes(index);
    end
end
end
