function [] = experiment()

%% set up paths and network constants
dataPath = '/Users/Davis/Desktop/garyComposite_Experiment_2/dataset';
dataType = '*.jpg';
numIterations = 10000;

%% run experiment: preprocess data and train data.
preprocessor(dataPath, dataType, 'cc');     % preprocess
CompositeClassifierTrain(numIterations);    % iterations, no hidden units

%% experiment complete. data for further testing in mat files
display('experiment complete'); 
 