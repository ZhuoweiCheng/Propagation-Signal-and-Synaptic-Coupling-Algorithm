function A2=rescan_each_reference(A)
[m,numbers]=size(A);
A2 = cell(1,numbers);
for i=1:numbers
    if isempty(A{1,i})~=1
        current_cell=A{1,i};
        [m1,n1]=size(current_cell);
        for j = n1:-1:1
            if current_cell(3,j)<50
                current_cell(:,j)=[];
            end
        end
        reference = find(current_cell(1,:)==i);
        non_zero_electrodes = find(current_cell(2,:)~=0);
        target_electrodes = setdiff(non_zero_electrodes,reference);
        if isempty(target_electrodes)~=1
            cooccurrences = 0.5 * max(current_cell(3,target_electrodes));
            index = find(current_cell(3,:)>=cooccurrences);
            index = union(index, reference);
            current_cell_new = current_cell(:,index);
            A2{1,i} = current_cell_new;
        end
    end
end
end
