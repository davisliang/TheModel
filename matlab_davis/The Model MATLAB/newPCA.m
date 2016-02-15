function [trainScore, testScore, validScore] = newPCA(trainFeatures, testFeatures, validFeatures)


    [coeff, score, latent,temp1,explained,mu] = pca(trainFeatures'); 
    
    %testing
    
    total = 0;
    numPCA = 0;
    for i = 1:size(explained,1)
        total = total + explained(i);
        if(total>=99)
            numPCA = i;
            break;
        end
    end

    trainScore = (trainFeatures - repmat(mu,[size(trainFeatures,1),1]))*pinv(coeff(:,1:numPCA)');
    testScore = (testFeatures - repmat(mu,[size(testFeatures,1),1]))*pinv(coeff(:,1:numPCA)');
    validScore = (validFeatures - repmat(mu,[size(validFeatures,1),1]))*pinv(coeff(:,1:numPCA)');

laend