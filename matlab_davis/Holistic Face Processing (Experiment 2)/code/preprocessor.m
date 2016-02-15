function [] = preprocessor(dataPath, dataType, holdOut)
% this function preprocesses for an entire experiment.
% @author Davis Liang
% @version 1.0
% date: 7/13/15
%% initial setup
numScales = 5;
numOrientations = 8;

dataPath = fullfile(dataPath, 'Faces'); 
savePath='/Users/Davis/Desktop/garyComposite_Experiment_2/params/preprocessparams_final.mat';
savePath2='/Users/Davis/Desktop/garyComposite_Experiment_2/params/preprocessparams_checkpoint_final.mat';



%% UPLOAD DATASET, EXTRACT LABEL, EXTRACT NAME (normalized about zero)
display('loading dataset... ');
[data, labels, names] = importNormImages(dataPath, dataType);               %Desc:  Greyscales and normalizes images.
                                                                            %in:    String, String             
                                                                            %out:   data{i}     (axb, original size of image)
                                                                            %       labels{i}   (int)
                                                                            %       names{i}    (String)
                                                                            %       
%before we create the composite faces we want to extract the training data and labels
%of the whole faces here and then use them to create our full set later
%on...


%% PARSE FULL FACE SETS (regular full faces)
display('constructing non-composite face set...');
[TrainNonCompositeData, TrainNonCompositeLabels] = ...
    parseFullSet(data,labels,names,holdOut);
                                                                            %Desc: Extracts training data because we do not test on non-composites
                                                                            %in:    data{i}     (a numImagesx1 cell array of 256x256 matrices)
                                                                            %       labels{i}   (a numImagesx1 cell of integers)
                                                                            %       names{i}    (a numImagesx1 cell of Strings)
                                                                            %       holdOut     (a string)
                                                                            %out:   TrainNonCompositeData{i}    
                                                                            %       TrainNonCompositeLabels{i}
                                                                            
  %% CONSTRUCT NONCOMPOSITE HALF FACES (regular full faces)
 [trainDataHalf] = createHalfFaceSetNonComposite(TrainNonCompositeData);                                              
                                                                            %Desc:  Creates half-faces for each set (train,test)
                                                                            %       First half top biased, second is bottom biased
                                                                            %in:    trDat               (3x9 cell of 256,256 matrices)
                                                                            %       teDat               (1x9 cell of 256,256 matrices)
                                                                            %out:   trainDataHalf       (1x54 cell of 256,256 matrices)
                                                                            %       testDataHalf        (1x18 cell of 256,256 matrices)
                                                                            
                                                                            
                                                                            
%% CREATE COMPOSITE FACES                                                 
display('constructing composite face set... ');
[compositeData, compositeLabels,compositeNames] = ...
    createCompositeFaceSet(data,names);                                     %Desc:  Takes original images and composes entire composite set
                                                                            %in:    data{i}     (256x256)
                                                                            %out:   compositeData{}     (4x9 cell of 256x256 matrices)
                                                                            %       compositeLabels{}   (4x9 cell of 2x1 matrices: top, bot)                                              

                                                                           
%% PARSE COMPOSITE FACES TO EXTRACT TEST DATA
[teDat,teLab] = parseSet(...
    compositeData,compositeLabels,compositeNames,holdOut);                  %Desc: Takes the composite images and parses out the test set
                                                                            %in:    compositeData{}     (4x9 cell of 256x256 matrices)
                                                                            %       compositeLabels{}   (4x9 cell of 2x1 matrices: top, bot)  
                                                                            %       compositeNames{}    (4x9 cell of String)
                                                                            %       holdOut             String
                                                                            %out:   teDat{}             1x9 cell of composite test faces
                                                                            %       teLab{}             1x9 cell of 2x1 matrices: top,bot
                                                         
%% CONSTRUCT COMPOSITE FACES TO TEST ON
[testDataHalf, teLabHalf] =...
    createHalfFaceSetComposite(teDat,teLab);                                %Desc:  Creates half-faces for each set (train,test)
                                                                            %       First half top biased, second is bottom biased
                                                                            %       teDat               (1x9 cell of 256,256 matrices)
                                                                            %       testDataHalf        (1x18 cell of 256,256 matrices)

%% PUT TOGETHER FULL DATA SET (We're only testing on composite halves)
trainDataFull = [trainDataHalf,TrainNonCompositeData];                      % trainDataFull  (1x(54+18) cell of 256,256 matrices)
trainLabels = [TrainNonCompositeLabels,...
    TrainNonCompositeLabels, TrainNonCompositeLabels];                      % trainLabels
testLabels = teLabHalf;
validLabels = trainLabels;

%% CONSTRUCT GABOR WAVELETS
gabor = createGabors(numScales, numOrientations);                           %Desc:  specifically for images 256x256
                                                                            %in:    numScales       (int)
                                                                            %       numOrientations (int)
                                                                            %out:   gabor{s,o}:     gabor{size, orientation}
%% FILTER IMAGES, DOWNSAMPLE, TAKE COMPLEX MAGNITUDE
trainFeatures = filterSet(trainDataFull, gabor, 'filtering training set');  %Desc:  filters both sets with all gabors
                                                                            %in:    data, gabor         (cell arrays)
                                                                            %out:   featureMaps{i,s,o}  (100x100) each featuremap                                                                            
testFeatures = filterSet(testDataHalf, gabor, 'filtering training set');    
validFeatures = trainFeatures;                                              %just for this experiment
                                                                            %just for preliminary experiments

save(savePath2, 'testFeatures', 'validFeatures', 'trainFeatures');          
display('checkpoint. data saved.');

%% additional processing  (z-score across all maps, half features, PCA for n components)
[trainData, testData, validData] = zscore(trainFeatures, testFeatures, validFeatures);
%Z-score by finding the mean and std of the training set, and operating on
%the data sets with these numbers. Z-score across all images.


[trainPCA, testPCA, validPCA] = PCA(trainData, testData, validData, 'extracting PCA for all sets');

save(savePath, 'trainPCA', 'testPCA', 'validPCA', 'trainLabels', 'testLabels', 'validLabels');
display('preprocessing complete. preprocessed data saved.');








