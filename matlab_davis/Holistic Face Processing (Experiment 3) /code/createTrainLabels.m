function [newLabels_final] = createTrainLabels(labels,names)

newLabels = reshape(labels, [10,3]);
newNames = reshape(names, [10,3]);
%cc == 1
%nr == 2
%pf == 3
%sw == 4
for i = 1:size(newLabels,1)
    if(newNames{i}(2:3) == 'cc')
        a = 1;
    elseif(newNames{i}(2:3) == 'nr')
        a = 2;
    elseif(newNames{i}(2:3) == 'pf')
        a = 3;
    elseif(newNames{i}(2:3) == 'sw')
        a = 4;
    elseif(newNames{i}(2:3) == 'em')
        a = 5;
    elseif(newNames{i}(2:3) == 'jj')
        a = 6;
    elseif(newNames{i}(2:3) == 'mf')
        a = 7;
    elseif(newNames{i}(2:3) == 'mo')
        a = 8;
    elseif(newNames{i}(2:3) == 'pe')
        a = 9;
    elseif(newNames{i}(2:3) == 'wf')
        a = 10;
    end
    
    for j = 1:size(newLabels,2)
        newLabels_final{i,j} = [a,newLabels{i,j}];
    end
    
end

