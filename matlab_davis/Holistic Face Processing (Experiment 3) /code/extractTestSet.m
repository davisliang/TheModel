function [testSet,testLabels,testNames] = extractTestSet(data,labels,names)

%we want cc, nr, sw, pf
testVec = {'cc', 'nr', 'sw', 'pf'};
testSet = {};
testLabels = {};
counter = 1;
for i = 1:size(data,2)
    for j = 1:4
        if(names{i}(2:3) == testVec{j})
            testSet{counter} = data{i};
            testLabels{counter} = labels{i};
            testNames{counter} = names{i};
            counter = counter + 1;
        end
    end
end