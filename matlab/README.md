A standard implementation for "The Model" (TM; Dailey and Cottrell (1999)), containing a sample dataset for preprocessing (Gabor Filtering and PCA), and a two-layer neural network for training on face recognition.


To run:

RunExperiment.m                 - train a network with the SamplePreprocessedData.mat file.
PreprocessDataSet.m 		- (re)create SamplePreprocessedData.mat file.
HiddenUnitsVisualization.m 	- Visualizing the (net input of) hidden unit activation of two different networks, for comparison reason.


Output files:
SamplePreprocessedData.mat 			- preprocessed dataset of 12 faces, for toy training.
result_face_mono.mat 				- Final model performance statistics after training.
theta_result_after_face_expert_training.mat 	- Unit activations, after finishing training.
