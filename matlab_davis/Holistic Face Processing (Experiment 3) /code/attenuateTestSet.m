function [output] = attenuateTestSet(testSet)

    numTestImages = size(testSet,2);
    
    imgHeight = size(testSet{1},1);
    imgWidth = size(testSet{1},2);
    
    topHalf = ones(imgHeight, imgWidth);
    bottomHalf = ones(imgHeight, imgWidth);
    
    cropPixel = round(0.40 * imgHeight);

    for i = 1:(cropPixel-1)
        bottomHalf(i,:) = 0.5;    %keeping the bottom half
    end
    
    output = {};

    % training images half
    for i = 1:numTestImages
        output{i} = uint8(double(testSet{i}).*bottomHalf);
    end
end