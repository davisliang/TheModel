function [testTopData, testBotData, testLabels, testNames] =...
    createHalfTestSet(testData, testLabels, testNames)


imageHeight = size(testData{1},1);
cutoff = round(imageHeight*0.4);

%test inputs are all cell arrays, 1x12 cell arrays
numPeople = 4;
numExpressions = 3;
testData = reshape(testData,[4,3]);
testLabels = reshape(testLabels,[4,3]);
testNames = reshape(testNames,[4,3]);

testTopData = {};
testBotData = {};

for p = 1:numPeople
    for e = 1:numExpressions
        testTopData{p,e}=testData{p,e}(1:cutoff,:);
    end
end

for p = 1:numPeople
    for e = 1:numExpressions
        testBotData{p,e}=testData{p,e}(cutoff+1:imageHeight,:);
    end
end

end