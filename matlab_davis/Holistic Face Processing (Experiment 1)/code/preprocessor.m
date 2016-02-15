function [] = preprocessor(dataPath, dataType, holdOut)
% this function preprocesses for an entire experiment.
% @author Davis Liang
% @version 1.0
% date: 7/13/15
%% initial setup
numScales = 5;
numOrientations = 8;

dataPath=fullfile(dataPath, 'Faces'); 
savePath='/Users/Davis/Desktop/garyComposite/params/preprocessparams.mat';
savePath2='/Users/Davis/Desktop/garyComposite/params/preprocessparams_checkpoint.mat';



%% UPLOAD DATASET, EXTRACT LABEL, EXTRACT NAME (normalized about zero)
display('loading dataset... ');
[data, labels, names] = importNormImages(dataPath, dataType);               %Desc:  Greyscales and normalizes images.
                                                                            %in:    String, String             
                                                                            %out:   data{i}     (256x256)
                                                                            %       labels{i}   (int)
                                                                            %       names{i}    (String)
                                                                                
%% CONSTRUCT GABOR WAVELETS
gabor = createGabors(numScales, numOrientations);                           %Desc:  specifically for images 256x256
                                                                            %in:    numScales       (int)
                                                                            %       numOrientations (int)
                                                                            %out:   gabor{s,o}:     gabor{size, orientation}

%% PARSE DATA SET
[trDat,teDat,trLab,teLab,trNa,teNa] = parseSet(data,labels,names,holdOut);  %Desc:  Breaks up dataset into train and test sets.
                                                                            %in:    data{i}     (256,256)
                                                                            %       labels{i}   (int)
                                                                            %       names{i}    (String)
                                                                            %out:   train/testData{i}     (256,256)
                                                                            %       train/TestLabels{i}   (int)
                                                                            %       train/testNames{i}    (String)

%% CONSTRUCT HALF FACES
[trainDataHalf,testDataHalf] = createHalfFaceSet(trDat,teDat);              %Desc:  Creates half-faces for each set (train,test)
                                                                            %       First half top biased, second is bottom biased
                                                                            %in:    trainData{i}        (256,256)
                                                                            %       testData{i}         (256,256)
                                                                            %out:   trainDataHalf{i}    (256,256)
                                                                            %       testDataHalf{i}     (256,256)

%% FILTER IMAGES, DOWNSAMPLE, TAKE COMPLEX MAGNITUDE
trainDataAll = [trainDataHalf, trDat];                                      % train on halves + wholes
testDataAll = testDataHalf;                                                 % only test on halves.

trainFeatures = filterSet(trainDataAll, gabor, 'filtering training set');  %Desc:  filters both sets with all gabors
                                                                            %in:    data, gabor         (cell arrays)
                                                                            %out:   featureMaps{i,s,o}  (100x100) each featuremap                                                                            
testFeatures = filterSet(testDataAll, gabor, 'filtering training set');

validFeatures = trainFeatures;                                               %just for this experiment
vaLab = trLab;                                                               %just for preliminary experiments
vaNa=trNa;

save(savePath2, 'testFeatures', 'validFeatures', 'trainFeatures');
display('checkpoint. data saved.');


%% additional processing  (z-score across all maps, half features, PCA for n components)

trainLabels = [trLab, trLab, trLab];                                   %check that your labels are correct
testLabels = [teLab, teLab];
validLabels = [vaLab, vaLab, vaLab];

trainNames = [trNa,trNa,trNa];
testNames = [teNa,teNa,teNa];
validNames = [vaNa,vaNa,vaNa];

%ZSCORE ACROSS ALL MAPS
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

save(savePath, 'trainPCA', 'testPCA', 'validPCA', 'trainLabels', 'testLabels', 'validLabels','trainNames','testNames','validNames');
display('preprocessing complete. preprocessed data saved.');








