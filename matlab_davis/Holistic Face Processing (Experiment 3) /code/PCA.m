function [PCATrainData, PCATestData, PCAValidData] = PCA(dataAllTrain, dataAllTest, dataAllValid, message)
%our images already have zero mean from the z-scoring.

%% Implement PCA and rotate data.
fprintf('%s \n', message);
dataAllTrain = dataAllTrain';
dataAllTest = dataAllTest';
dataAllValid = dataAllValid';

numFeaturesTrain = size(dataAllTrain,2);

%subtract out the mean for every image.
%avg = mean(dataAllTrain); %average of each dimension
%dataAllTrain = bsxfun(@minus,dataAllTrain,avg);
%dataAllTest = bsxfun(@minus,dataAllTest,avg);
%dataAllValid = bsxfun(@minus,dataAllValid,avg);

%n images m dimensions, nxm data matrix.

%% calculate the covariance matrix and find it's eigenvalues/vectors

%Kohonen and Lowe Trick for small covariance matrix.
display('    constructing covariance matrix...');
sigma = dataAllTrain*dataAllTrain'/(numFeaturesTrain-1); 
display('    extracting eigendata...');
[eigenspace_T, eigenval_T] = svd(sigma); %we find the eigenspace and the eigenvalues

%transform eigenvalues and eigenspace back into non-transposed forms

%normalize eigenspace
eigenspace = dataAllTrain'*eigenspace_T;

%find 99% of variance
eigenvalTotal = sum(diag(eigenval_T));
eigenvalSum = 0;
numPC = 0;

for i = 1:size(eigenval_T,1)
    eigenvalSum = eigenvalSum + eigenval_T(i,i);
    numPC = numPC + 1;
    if(eigenvalSum > .99*eigenvalTotal)
        break;
    end
end

% construct then normalize the eigenvectors.

data_rot_train = dataAllTrain*eigenspace;
data_rot_valid = dataAllValid*eigenspace;
data_rot_test = dataAllTest*eigenspace;

snorm = diag(sqrt(data_rot_train'*data_rot_train));
data_rot_train = data_rot_train/diag(snorm);
data_rot_test = data_rot_test/diag(snorm);
data_rot_valid = data_rot_valid/diag(snorm);

fprintf('     extracting principal components...')
PCATrainData = data_rot_train(:,1:numPC);
PCAValidData = data_rot_valid(:,1:numPC);
PCATestData = data_rot_test(:,1:numPC);

PCATrainData = PCATrainData';
PCATestData = PCATestData';
PCAValidData = PCAValidData';

fprintf('    PCA extraction complete. \n');



