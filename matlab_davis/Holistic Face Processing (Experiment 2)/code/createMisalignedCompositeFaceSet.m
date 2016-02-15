function [newLabels, newData] = createMisalignedCompositeFaceSet(testLabels, testData)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



numImages = size(testData,2); %number of composite test images = 3*(num_testIm/2)
imgHeight = size(testData{1},1);
imgWidth = size(testData{1},2);
cropPixel = ceil(imgHeight*.4);


%% shift all the bottoms, take top number
for i = 1:numImages
    testData_temp = zeros(size(testData{1}),'uint8');
    shiftPiece = testData{i}(cropPixel:imgHeight, 1:imgWidth*0.5); %only works if width is even
    testData_temp(1:cropPixel-1,:) = testData{i}(1:cropPixel-1,:);
    testData_temp(cropPixel:imgHeight, imgWidth*0.5+1:imgWidth) = shiftPiece;
    newData{i} = testData_temp;
    newLabels{i} = testLabels{i}(1);
end

%% shift all the tops, take bottom number
for i = 1:numImages
    testData_temp = zeros(size(testData{1}),'uint8');
    shiftPiece = testData{i}(1:cropPixel-1, 1:imgWidth*0.5); %only works if width is even
    testData_temp(cropPixel:imgHeight,:) = testData{i}(cropPixel:imgHeight,:);
    testData_temp(1:cropPixel-1, imgWidth*0.5+1:imgWidth) = shiftPiece;
    newData{i+numImages} = testData_temp;
    newLabels{i+numImages} = testLabels{i}(2);
end

%% append both label and data sets together

end

