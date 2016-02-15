function [trainSet_half] = createHalfFaceSetNonComposite(trainSet)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    numTrainImages = size(trainSet,2);
    
    imgHeight = size(trainSet{1},1);
    imgWidth = size(trainSet{1},2);
    
    topHalf = ones(imgHeight, imgWidth);
    bottomHalf = ones(imgHeight, imgWidth);
    
    cropPixel = round(0.40 * imgHeight);
    
    for i = cropPixel:imgHeight
        topHalf(i,:) = 0.125;
    end
    
    for i = 1:(cropPixel-1)
        bottomHalf(i,:) = 0.125;
    end
    
    trainSet_half = {};

    % training images half
    for i = 1:numTrainImages
        trainSet_half{i} = uint8(double(trainSet{i}).*topHalf);
    end
    
    for i = 1:numTrainImages
        trainSet_half{numTrainImages+i} = uint8(double(trainSet{i}).*bottomHalf);
    end

    trainSet_half = trainSet_half;

end

