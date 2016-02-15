function [data, labels, name] = importNormImages(dataPath, dataType)
% loads image data with it's specified data matrix, label, and name.
% @author Davis Liang
% @version 1.0
% date: 7/13/15

display('    importing images');
cd(dataPath); %datapath is the directory that holds all the image files.

files = dir(dataType);

data = {};
labels = {};
name = {};

for i = 1:length(files)
    name{i} = files(i).name;
    labels{i} = str2num(name{i}(1));
    filePath = fullfile(dataPath, name{i});
    predata_1 = imread(filePath);
    if size(predata_1,3) == 3
        predata_1 = rgb2gray(predata_1); %if we have RGB channels, greyscale it.
    end
    
    data{i} = predata_1;
end

% data{i} denotes normalized data matrix for image i
% labels{i} denotes label for image i
% name{i} denotes name for image i

fprintf('    import complete. \n');