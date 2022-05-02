[current_propagation, Time_all] = automated_detection_propagation(spike_times, 1, 180, 0.5, 50, 50);

%%
signal_index = 4;
current_propagation = ListofPropagation{1, signal_index};
reference_cell = current_propagation.ID(1);
index = find(current_propagation.latency > 0.001);
index = [1; index];
current_propagation = current_propagation(index,:);
current_propagation.smallwindow_cooccurrences(1) = -888;
[sizeoftemp,~]=size(current_propagation);
if sizeoftemp>2
    [max2, ind2] = max(current_propagation.number_of_spikes);
    current_propagation.number_of_spikes(ind2) = -888;
    [max3, ind3] = max(current_propagation.number_of_spikes);
    first_cell = current_propagation.ID(ind2);
    second_cell = current_propagation.ID(ind3);
    K5=spike_times{1,reference_cell};
    G6=spike_times{1,first_cell};
    temp=Amplitude{1,reference_cell};
    temp2=Amplitude{1,reference_cell};
    [~,n2]=size(G6);
    [m3,n3]=size(K5);
    delay_time_G6_K5=zeros(1, n3);
    for p=1:n2
        count = 0;
        index = find(K5<G6(1,p)&K5>G6(1,p)-1.5);
        if isempty(index)~=1
            count = 1;
        end
        if count == 1
            delay_time_G6_K5(index(1)) = 10;
        end
    end
    ans=find(delay_time_G6_K5==0);
    temp(ans)=0;
    temp=nonzeros(temp);
    delay1 = delay_time_G6_K5;
    K6=spike_times{1,second_cell};
    [~,n4]=size(K6);
    for p=1:n4
        count = 0;
        index = find(K5<K6(1,p)&K5>K6(1,p)-1.5);
        if isempty(index)~=1
            count = 1;
        end
        if count == 1
            delay_time_G6_K5(index(1)) = 10;
        end
    end
       
    ans=find(delay_time_G6_K5==0);
    delay2 = delay_time_G6_K5;
    temp2(ans)=0;
    temp2=nonzeros(temp2);
    figure
    edges=linspace(-200,0,50);
    histogram(Amplitude{1,reference_cell},edges,'FaceColor', [0.5 0.5 0.5], 'EdgeColor','none')
    hold on
    histogram(temp2,edges,'FaceColor', 'r' ,'EdgeColor','none')
    histogram(temp,edges,'FaceColor', 'b' ,'EdgeColor','none')
    p2_data1 = Amplitude{1,reference_cell};
    p2_data2 = temp;
    p2_data3 = temp2;
    hold off
end