function [trainNorm, testNorm, validNorm] = removeMean(trainFeature, testFeature, validFeature)
%this code is to zscore across all feature maps
%@version 1.0
%@author Davis Liang
%date: 7/14/15

display('subtracting mean from all sets... ');

%% initialize constants
numImages = size(trainFeature,1);
numScales = size(trainFeature,2);
numOrientations = size(trainFeature,3);
%E[X] = sum(X)/n

%% calculate mean and standard deviation
mapSum = 0;
mapSumSq = 0;
for i = 1:numImages
    for s = 1:numScales
        for o = 1:numOrientations
                mapSum = mapSum + trainFeature{i,s,o};
        end
    end
end

mapMean = mapSum/(numImages*numScales*numOrientations);

%% subtract mean divide standard deviation
for i = 1:numImages
    for s = 1:numScales 
        for o = 1:numOrientations
            trainNorm{i,s,o} = (trainFeature{i,s,o}-mapMean);
        end
    end
end

for i = 1:size(validFeature,1)
    for s = 1:numScales
        for o = 1:numOrientations
            validNorm{i,s,o} = (validFeature{i,s,o}-mapMean);
        end
    end
end

for i = 1:size(testFeature,1)
    for s = 1:numScales
        for o = 1:numOrientations
            testNorm{i,s,o} = (testFeature{i,s,o}-mapMean);
        end
    end
end


fprintf('    mean removal complete. \n');