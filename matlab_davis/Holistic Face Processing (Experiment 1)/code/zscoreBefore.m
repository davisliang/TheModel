function [normTrain, normTest, normValid] = zscoreBefore(trainData, testData, validData)

    numScales = size(trainData,2);
    numOrientations = size(trainData,3);
    
    numTrainImages = size(trainData,1);
    numTestImages = size(testData,1);
    numValidImages = size(validData,1);
    
    reshapedTrain = {};
    holder = 0;
    
    for s = 1:numScales
        for o = 1:numOrientations
            holder = [];
            for i = 1:numTrainImages
                temp = trainData{i,s,o};
                temp = reshape(temp,[size(temp,1)*size(temp,2),1]);
                holder = [holder,temp];
            end
            reshapedTrain{s,o} = holder;
        end
    end
    
    meanTrain = {};
    stdev = {};
    for s = 1:numScales
        for o = 1:numOrientations
            meanTrain{s,o} = mean(reshapedTrain{s,o},2);
            stdev{s,o} = std(reshapedTrain{s,o},0,2);
        end
    end
    
    %take care of zero values in standard deviation
    for s = 1 : numScales
        for o = 1 :numOrientations
            temp = stdev{s,o};
            index = find(temp==0);
            temp(index) = 1;
            stdev{s,o} = temp;
        end
    end
    
    for i = 1:numTrainImages
        for s = 1:numScales
            for o = 1:numOrientations
                normTrain{i,s,o} = (reshape(trainData{i,s,o},...
                    [size(trainData{1,1,1},1)*size(trainData{1,1,1},2),1])...
                    - meanTrain{s,o})./stdev{s,o};
            end
        end
    end
    
    for i = 1:numTestImages
        for s = 1:numScales
            for o = 1:numOrientations
                normTest{i,s,o} = (reshape(testData{i,s,o},...
                    [size(testData{1,1,1},1)*size(testData{1,1,1},2),1])...
                    - meanTrain{s,o})./stdev{s,o};
            end
        end
    end
    
    for i = 1:numValidImages
        for s = 1:numScales
            for o = 1:numOrientations
                normValid{i,s,o} = (reshape(validData{i,s,o},...
                    [size(validData{1,1,1},1)*size(validData{1,1,1},2),1])...
                    - meanTrain{s,o})./stdev{s,o};
            end
        end
    end
    

    

end
