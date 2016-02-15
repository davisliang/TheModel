function [testSet_half, testHalfLabels] = ...
    createHalfFaceSetComposite(testSet, testLabels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Desc:  Creates half-faces for each set (train,test)
%       First half top biased, second is bottom biased
%in:    trDat               (3x9 cell of 256,256 matrices)
%       teDat               (1x9 cell of 256,256 matrices)
%out:   trainDataHalf       (1x54 cell of 256,256 matrices)
%       testDataHalf        (1x18 cell of 256,256 matrices)
%       trainLabelsHalf     (1x54 cell of integers)
%       testLabelsHalf      (1x18 cell of integers)

    testSet = reshape(testSet, [1,size(testSet,1)*size(testSet,2)]);
    testLabels = reshape(testLabels, [1,size(testLabels,1)*size(testLabels,2)]);
    
    numTestImages = size(testSet, 2);   
    
    imgHeight = size(testSet{1},1);    
    imgWidth = size(testSet{1},2); 
    
    topHalf = ones(imgHeight, imgWidth);
    bottomHalf = ones(imgHeight, imgWidth);
    
    cropPixel = round(0.40 * imgHeight);
    
    for i = cropPixel:imgHeight         % This is the matrix we multiply to attentuate the bottom half (top biased)
        topHalf(i,:) = 0.125;
    end
    
    for i = 1:(cropPixel-1)             % This matrix attenuates the top half (bottom biased)
        bottomHalf(i,:) = 0.125;
    end   

    testSet_half = {};
    testHalfLabels = {};
    

    
    %% test images half
    for i = 1:numTestImages
        testSet_half{i} = uint8(double(testSet{i}).*topHalf);
        testHalfLabels{i} = testLabels{i}(1);
    end
    
    for i = 1:numTestImages
    	testSet_half{numTestImages+i} = uint8(double(testSet{i}).*bottomHalf);
        testHalfLabels{numTestImages + i} = testLabels{i}(2);
    end
    
end

