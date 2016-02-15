function [] = preprocessor(dataPath, dataType)
% this function preprocesses for an entire experiment.
% @author Davis Liang
% @version 1.0
% date: 1/11/16
%% initial setup
numScales = 5;
numOrientations = 8;

dataPath = fullfile(dataPath, 'Faces'); 
savePath='/Users/Davis/Desktop/garyComposite_Experiment_3/params/preprocessparams_final.mat';
savePath2='/Users/Davis/Desktop/garyComposite_Experiment_3/params/preprocessparams_checkpoint.mat';



%% UPLOAD DATASET, EXTRACT LABEL, EXTRACT NAME (normalized about zero)
display('loading dataset... ');
[data, labels, names] = importNormImages(dataPath, dataType);               %Desc:  Greyscales and normalizes images.
                                                                            %in:    String, String             
                                                                            %out:   data{}      (1x3*10 cell of images: original size)
                                                                            %       labels{i}   (1x3*10 cell of labels: single integers)
                                                                            %       names{i}    (1x3*10 cell of names: string)
                                                                            %       
%before we create the composite faces we want to extract the training data and labels
%of the whole faces here and then use them to create our full set later
%on...

%% CONSTRUCT NONCOMPOSITE HALF FACES (regular full faces with attenuated half)
[trainDataHalf] = createHalfFaceSetNonComposite(data);                                              
                                                                            %Desc:  Creates half-faces for each set (train,test)
                                                                            %       First half top biased, second is bottom biased
                                                                            %in:    data                (1x30 cell of original image size matrices)
                                                                            %out:   trainDataHalf       (1x60 cell of original image size matrices)
                                                                            
                                                                            
                                                                          
%% COMPLETE PUTTING TOGETHER OF TRAINING SET (SID/SE)
[labels] = createTrainLabels(labels, names); %create labels including identity and emotion for training set                                                                                    
trainSetFull = [data,trainDataHalf];                                        
trainLabels = [labels,labels,labels];
trainNames = [names,names,names];



%% 2) create testing set with labels
% so thus the procedure is to create composites for happy, surprised, and
% disgusted, which are all bottom-biased expressions. So we would first 
% extract all the different bottoms and for each bottom have a top that is
% either SID/DE, SE/DID, DID/DE. 

% FOUR SPECIFIC ACTORS, ONLY 3 EXPRESSIONS, ALL BOTTOM BIASED

%C, NR, SW, PF

% extract the four testing actors and all their images + labels + names
[testData,testLabels,testNames] = extractTestSet(data,labels,names);


%% continuation of 2)

%% zscore each filter at each position (40000 normalizations)

%% attenuate other side if within 2 STD DEV. 

%% Z-Score the PCA as well (after too.) use matlab ZSCORE after PCA. do not PCA beforehand

%% zero multiplier for training

%% human confusion matrix...

%% 



[testTopData, testBotData, testLabels, testNames] = ...
    createHalfTestSet(testData,testLabels, testNames);
%first, create all the composites and we can shift all the TOPS later
%because these are all bottom biased. They only have one label because
%they are all bottom biased.

    %to begin, create all the SID/DE AND their labels
    [testData_SID_DE, testLabels_SID_DE, testNames_SID_DE] =...
        SID_DE_Set_Creation(testTopData,testBotData,testLabels,testNames);
   

    %then, create all the SE/DID AND their labels
    [testData_DID_SE, testLabels_DID_SE, testNames_SE_DID] =...
        SE_DID_Set_Creation(testTopData,testBotData,testLabels,testNames);
    
    
    %finally, create the DID/DE AND their labels
    [testData_DID_DE, testLabels_DID_DE, testNames_DID_DE] = DID_DE_Set_Creation(testTopData, testBotData, testLabels,testNames);

%% lastly, put together labels including the 'identity' for all sets
testSetFull = [testData_DID_SE];  %testData_SID_DE, testData_DID_SE, testData_DID_DE
    %attentuate the test set, since you forgot to do this earlier...
    [testSetFull] = attenuateTestSet(testSetFull);
testLabels = [testLabels_DID_SE]; %testLabels_SID_DE, testLabels_DID_SE, testLabels_DID_DE
validLabels = trainLabels;
validNames = trainNames;
%% CONSTRUCT GABOR WAVELETS
gabor = createGabors(numScales, numOrientations);                           %Desc:  specifically for images 256x256
                                                                            %in:    numScales       (int)
                                                                            %       numOrientations (int)
                                                                            %out:   gabor{s,o}:     gabor{size, orientation}
%% FILTER IMAGES, DOWNSAMPLE, TAKE COMPLEX MAGNITUDE
trainFeatures = filterSet(trainSetFull, gabor, 'filtering training set');  %Desc:  filters both sets with all gabors
                                                                            %in:    data, gabor         (cell arrays)
                                                                            %out:   featureMaps{i,s,o}  (100x100) each featuremap                                                                            
testFeatures = filterSet(testSetFull, gabor, 'filtering training set');    

validFeatures = trainFeatures;                                              %just for this experiment
                                                                            %just for preliminary experiments
save(savePath2, 'testFeatures', 'validFeatures', 'trainFeatures');          
display('checkpoint. data saved.');

%% ZSCORE ACROSS ALL MAPS
[trainFeatures, testFeatures, validFeatures] = ...
    zscoreBefore(trainFeatures, testFeatures, validFeatures);

[reshapedTrainFeatures, reshapedTestFeatures,reshapedValidFeatures] = ...
    reshapeSetsForPCA(trainFeatures, testFeatures, validFeatures);

%[trainPCA,testPCA,validPCA] = ...
%    newPCA(reshapedTrainFeatures, reshapedTestFeatures,reshapedValidFeatures);

[PCATrainData, PCATestData, PCAValidData] = PCA(...
    reshapedTrainFeatures, reshapedTestFeatures, reshapedValidFeatures,...
    'Extracting Principal Components...\n');

%ZSCORE AFTER PCA
[trainPCA,mu,sigma] = zscore(PCATrainData');
trainPCA = trainPCA';
testPCA= (PCATestData-repmat(mu,[size(PCATestData,2),1])')./repmat(...
    sigma,[size(PCATestData,2),1])';
validPCA= (PCAValidData-repmat(mu,[size(PCAValidData,2),1])')./repmat(...
    sigma,[size(PCAValidData,2),1])';

%% Import Human Confusion Matrix

save(savePath, 'trainPCA', 'testPCA', 'validPCA', 'trainLabels', 'testLabels', 'validLabels','trainNames');
display('preprocessing complete. preprocessed data saved.');


%% ultimately your training algorithm should also be slightly different
%due to the addition of the 3 localist outputs. use this chance to also
%get rid of unused expression outputs.

