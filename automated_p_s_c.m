function [signals, s_c_1, R_time, s_c_table, Bin_Histogram, delay_time]=automated_p_s_c(C, D, electrodes)

A=propa_signal(C);
signals=getsignal_electrodes(A,electrodes);
R_time=synaptic_coupling_time(signals,C);
[s_c, Bin_Histogram, delay_time]=synaptic_coupling(signals, C, D, R_time);
s_c_1=s_c;
[m1,n1]=size(s_c);
for i=1:n1
    B=zeros(1);
    temp=s_c{1,i};
    [m,n]=size(temp);
    count=1;
    for j=1:n
        if temp(4,j)<1
            B(count)=j;
            count=count+1;
        end
    end
    if B~=zeros(1)
        s_c{1,i}(:,B)=[];
    end
end
s_c_table=getsignal_electrodes_s_c(s_c,electrodes);
end