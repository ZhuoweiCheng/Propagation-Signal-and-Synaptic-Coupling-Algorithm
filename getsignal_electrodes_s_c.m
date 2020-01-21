function signals=getsignal_electrodes_s_c(signalspre,electrodes)
[m,numbers]=size(signalspre);
for i=1:numbers
    temps=signalspre{1,i};
    if temps(1,:)==0;
        signals{1,i}=0;
    else
        ID=temps(1,:)';
        delay=temps(4,:)';
        Efficiency=temps(3,:)';
        cooccurence=temps(5,:)';
        narrowness_of_the_fit=temps(2,:)';
        flag=temps(6,:)';
        name=electrodes(temps(1,:));
        signals{1,i}=table(ID, name,delay,cooccurence,narrowness_of_the_fit, Efficiency, flag);
    end
end
end