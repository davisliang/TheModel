function [filteredData] = filterSet(data, gabor, message)
% this function filters and entire dataset with the supplied gabor filter
% of proper format.
% @author Davis Liang
% @version 1.0
% date: 7/13/15

% data{i} denotes image i
% gabor{i} denotes gabor i
filteredData = {};

fprintf('%s \n', message);
numImages = size(data, 2);
numScales = size(gabor,1);
numOrientations = size(gabor,2);

imageDim = size(data{1});



for img = 1:numImages
    fprintf('    image %i out of %i \n', img, numImages);
    for s = 1:numScales
        for o = 1:numOrientations
            filterThis = imresize(data{img},[35,29]);
            filteredData{img,s,o} = abs(double(...
                imfilter(filterThis, gabor{s,o}, 'replicate', 'conv')));
        end
    end
end


fprintf('    filtering complete. \n');
%filteredData{i,s,o) refers to output feature map for image i from gabor of
%size s and orientation o.