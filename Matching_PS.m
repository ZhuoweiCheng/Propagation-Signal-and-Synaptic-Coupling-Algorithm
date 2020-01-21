function Matched_signals=Matching_PS(signals1, signals2)
[~,z]=size(signals1);
Matched_signals=cell(1,z);
for i=1:z
    PS=signals1{1,i};
    [n,~]=size(PS);
    [output, overlap_percentage]=Search_PS(PS, signals2);
    for j=1:n
        if overlap_percentage(j)>0.5&~ismember(j,output)
            output=[output j];
        end
    end
    Matched_signals{1,i}=output;
end