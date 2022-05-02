function s_c_table=updatesctable_kstest(s_c_table,R_time,C,D,electrodes)
for i=1:length(s_c_table)
    temp1=R_time{1,i};
    tb=s_c_table{1,i};
    for j = 1:size(tb,1)
        temp2=C{1,find(electrodes==tb.name(j))};
        [~,n2]=size(temp1);
        [m3,n3]=size(temp2);
        delay_time_temp1_temp2=zeros(1, n3);
        for p=1:n2
            for binvalue = 0.5:0.05:10
                if isempty(find(temp2==temp1(1,p)+binvalue))==0
                    index=find((temp2==temp1(1,p)+binvalue));
                    delay_time_temp1_temp2(index)=binvalue;            
                end
            end
        end
        tar=D{1,find(electrodes==tb.name(j))};
        tar2=tar;
        tar2(find(delay_time_temp1_temp2==0))=[];
        random1=tar(randperm(length(tar),length(tar2)));
        random2=tar(randperm(length(tar),length(tar2)));
        [h1,p1]=kstest2(tar2,random2);
        [h2,p2]=kstest2(random1,random2);
        s_c_table{1,i}.h1(j)=h1;
        s_c_table{1,i}.p1(j)=p1;
        s_c_table{1,i}.h2(j)=h2;
        s_c_table{1,i}.p2(j)=p2;
    end
end

