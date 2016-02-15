function [TrainNonCompositeData, TrainNonCompositeLabels] = ...
    parseFullSet(data,labels,names,holdOut)

    counter = 0;
    TrainNonCompositeData = {}; 
    TrainNonCompositeLabels = {};

    
    
    
    for i = 1:size(data,2)
        if names{i}(2:3) ~= holdOut
            counter = counter + 1;
            TrainNonCompositeData{counter} = data{i};
            TrainNonCompositeLabels{counter} = labels{i};
        end
            
    end

end
