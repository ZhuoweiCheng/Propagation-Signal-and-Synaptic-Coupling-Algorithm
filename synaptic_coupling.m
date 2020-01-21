function [s_c, Bin_Histogram, delay_time]=synaptic_coupling(signals, C, D, R_time)
%spiketimeinterval is the fit window we use (here is 3 ms)
spiketimeinterval=3;
t=int64(spiketimeinterval/0.05);
length_thres=C{1,1}(end)/1000;
acc=0.05;
[m,n]=size(signals);
%%pick all the electrodes that belong to some propagation signals
%%temp=union(signals{1,1}.ID,signals{1,2}.ID);
%%for forpickelectrode = 3:n
    %%temp=union(signals{1,forpickelectrode}.ID,temp);
%%end
%%listofelectrode=temp;
%%[m1,n1]=size(listofelectrode);
%%construct cross correlogram
Bin_Histogram=cell(1,n);
delay_time=cell(1,n);
for i=1:n
    temp1=R_time{1,i};
    [m2,n2]=size(temp1);
    endresult=zeros(6,1);
    %only use the PS that has higher than 2hz frequency
    if n2>2*length_thres       
        q=1;
        Bin_Histogram{1,i}=cell(1,120);
        delay_time{1,i}=cell(1,120);
        for electrode2=1:120
        %%electrode2=listofelectrode(e_temp);
            temp2=C{1,electrode2};
            [~,sizeoftemp2]=size(temp2);
            Binbox=zeros(1,191); 
            delay_time_temp=zeros(1,sizeoftemp2);
            for p=1:n2
                for binvalue = 0.5:0.05:10
                    if isempty(find(temp2==temp1(1,p)+binvalue))==0
                        Binbox(1,int64(binvalue/0.05-9))=Binbox(1,int64(binvalue/0.05-9))+1;
                        index=find(temp2==temp1(1,p)+binvalue,1);
                        delay_time_temp(index)=binvalue;
                    end
                end
            end
            Bin_Histogram{1,i}{1,electrode2}=Binbox;
            %delay time and amplitude
            delay_time{1,i}{1,electrode2}=delay_time_temp;
            D2=D{1,electrode2};
            delay_time2=delay_time_temp;
            index=find(delay_time2==0);
            D2(1,index)=0;
            delay_time2=nonzeros(delay_time2);
            D2=nonzeros(D2);
            Amplitude=[];
            T_std=[];
            if isempty(D2)==0
                Amplitude=std(D2)/(max(D2)-min(D2));
                T_std=std(delay_time2);
                Meanvalue=mean(delay_time2);
            end           
            sumnumber=sum(Binbox);
            a=sum(Binbox(1,1:1+t));
            location=1;
            for j=1:191-t
                if sum(Binbox(1,j:j+t))>a
                    a=sum(Binbox(1,j:j+t));
                    location=j;
                end
            end
            delay=find(Binbox(1,location:location+t)==max(Binbox(1,location:location+t)),1);
            %sumnumber/n2 is the proportion of the spikes in the target electrode 
            %that has a 0.5-10ms latency over the number of the spikes in
            %the PS. a is the number of the spikes in the 3ms window fit.
            %delay from 1 to 191 representing 0.5 to 10ms with 0.05ms
            %intervals. delay>10&&delay<92 means only pick the latency higher than
            %1ms and lower than 5ms. T_std is the standard deviation of the
            %delay time
            if sumnumber/n2>0.1&&a/sumnumber>0.57&&delay>10&&delay<92&&T_std<2.7
                delay=double(location+delay-1);
                delay=(delay+9)*0.05;
                endresult(1,q)=electrode2;
                endresult(2,q)=a/sumnumber;
                endresult(3,q)=a/n2;
                endresult(4,q)=delay;
                endresult(5,q)=n2;
                %Amplitude is the standard deviation of the amplitude
                if Amplitude>0.25
                    endresult(6,q)=1;
                else
                    endresult(6,q)=0;
                end
                q=q+1;
            end
            end
    end
    s_c{1,i}=endresult;   
end
end