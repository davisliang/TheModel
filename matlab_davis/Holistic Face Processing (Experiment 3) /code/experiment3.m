function [] = experiment3()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% set up paths and network constants
dataPath = '/Users/Davis/Desktop/garyComposite_Experiment_3/dataset';
dataType = '*.jpg';
numIterations = 50000;


%% run experiment: preprocess data and train data.
preprocessor(dataPath, dataType);     % preprocess
CompositeClassifierTrain(numIterations);    % iterations, no hidden units

%% experiment complete. data for further testing in mat files
display('experiment complete'); 


end

