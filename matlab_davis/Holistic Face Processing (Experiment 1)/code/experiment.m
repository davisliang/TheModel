function [] = experiment()

%% set up paths and network constants
dataPath = '/Users/Davis/Desktop/garyComposite/dataset';
dataType = '*.jpg';
numIterations = 5000;

%% run experiment: preprocess data and train data.
preprocessor(dataPath, dataType, 'wf');     % preprocess
CompositeClassifierTrain(numIterations);    % iterations, no hidden units

%% experiment complete. data for further testing in mat files
display('experiment complete'); 
