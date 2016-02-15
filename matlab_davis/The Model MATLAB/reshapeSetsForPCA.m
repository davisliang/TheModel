function [dataAllTrain, dataAllTest, dataAllValid] = ...
    reshapeSetsForPCA(trainSet, testSet, validSet)
    

numImagesTrain= size(trainSet,1);
numImagesTest= size(testSet,1);
numImagesValid = size(validSet,1);

numScales = size(trainSet,2);  %scales and orientations are same across all sets.
numOrientations = size(trainSet,3);

dataAllTrain = zeros(size(trainSet{1,1,1},1)*size(trainSet{1,1,1},2)*numScales*numOrientations,numImagesTrain);
dataAllTest = zeros(size(testSet{1,1,1},1)*size(testSet{1,1,1},2)*numScales*numOrientations,numImagesTest);
dataAllValid = zeros(size(validSet{1,1,1},1)*size(validSet{1,1,1},2)*numScales*numOrientations,numImagesValid);


display('    reshaping training set...');

for i = 1:numImagesTrain
    dataImTrain = [];
    for s = 1:numScales
        for o = 1:numOrientations
            dataGabTrain = reshape(trainSet{i,s,o},[size(trainSet{i,s,o},1)*size(trainSet{i,s,o},2),1]);   %feature maps reshaped into columns
            dataImTrain = [dataImTrain; dataGabTrain]; %appending all gabor columns together
        end
    end
    dataAllTrain(:,i) = dataImTrain; %each image corresponds to one column
end

display('    reshaping testing set...');

for i = 1:numImagesTest
    dataImTest = [];
    for s = 1:numScales
        for o = 1:numOrientations
            dataGabTest = reshape(testSet{i,s,o},[size(testSet{i,s,o},1)*size(testSet{i,s,o},2),1]);   %feature maps reshaped into columns
            dataImTest = [dataImTest; dataGabTest]; %appending all gabor columns together
        end
    end
    dataAllTest(:,i) = dataImTest; %each image corresponds to one column
end

display('    reshaping validation set...');

for i = 1:numImagesValid
    dataImValid = [];
    for s = 1:numScales
        for o = 1:numOrientations
            dataGabValid = reshape(validSet{i,s,o},[size(validSet{i,s,o},1)*size(validSet{i,s,o},2),1]);   %feature maps reshaped into columns
            dataImValid = [dataImValid; dataGabValid]; %appending all gabor columns together
        end
    end
    dataAllValid(:,i) = dataImValid; %each image corresponds to one column
end



end