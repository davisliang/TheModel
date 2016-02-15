function [testData_SE_DID, testLabels_SE_DID, testNames_SE_DID ] =...
    SE_DID_Set_Creation(testTopData,testBotData,testLabels,testNames)
%same identity, different expressions
numPeople = size(testTopData,1);
numExpressions = size(testTopData,2);

testData_SE_DID = {};
testLabels_SE_DID = {};
testNames_SE_DID = {};

counter = 1;
for(e=1:numExpressions)
    for(p=1:numPeople)
        if(p == 1)     
            testData_SE_DID{counter} = [testTopData{2,e};testBotData{1,e}];
            testData_SE_DID{counter+1} = [testTopData{3,e};testBotData{1,e}];
            testData_SE_DID{counter+2} = [testTopData{4,e};testBotData{1,e}];
            
            testLabels_SE_DID{counter} = [p;e];
            testLabels_SE_DID{counter+1} = [p;e];
            testLabels_SE_DID{counter+2} = [p;e];
            
            testNames_SE_DID{counter,1} = [testNames{2,e}];
            testNames_SE_DID{counter,2} = [testNames{1,e}];
            
            testNames_SE_DID{counter+1,1} = [testNames{3,e}];
            testNames_SE_DID{counter+1,2} = [testNames{1,e}];
            
            testNames_SE_DID{counter+2,1} = [testNames{4,e}];
            testNames_SE_DID{counter+2,2} = [testNames{1,e}];
            
            counter=counter+3;
        end
        if(p == 2)     
            testData_SE_DID{counter} = [testTopData{1,e};testBotData{2,e}];
            testData_SE_DID{counter+1} = [testTopData{3,e};testBotData{2,e}];
            testData_SE_DID{counter+2} = [testTopData{4,e};testBotData{2,e}];
            
            testLabels_SE_DID{counter} = [p;e];
            testLabels_SE_DID{counter+1} = [p;e];
            testLabels_SE_DID{counter+2} = [p;e];
            
            testNames_SE_DID{counter,1} = [testNames{1,e}];
            testNames_SE_DID{counter,2} = [testNames{2,e}];
            
            testNames_SE_DID{counter+1,1} = [testNames{3,e}];
            testNames_SE_DID{counter+1,2} = [testNames{2,e}];
            
            testNames_SE_DID{counter+2,1} = [testNames{4,e}];
            testNames_SE_DID{counter+2,2} = [testNames{2,e}];
            counter=counter+3;
        end
        if(p == 3)     
            testData_SE_DID{counter} = [testTopData{1,e};testBotData{3,e}];
            testData_SE_DID{counter+1} = [testTopData{2,e};testBotData{3,e}];
            testData_SE_DID{counter+2} = [testTopData{4,e};testBotData{3,e}];
            
            testLabels_SE_DID{counter} = [p;e];
            testLabels_SE_DID{counter+1} = [p;e];
            testLabels_SE_DID{counter+2} = [p;e];
            
            testNames_SE_DID{counter,1} = [testNames{1,e}];
            testNames_SE_DID{counter,2} = [testNames{3,e}];
            
            testNames_SE_DID{counter+1,1} = [testNames{2,e}];
            testNames_SE_DID{counter+1,2} = [testNames{3,e}];
            
            testNames_SE_DID{counter+2,1} = [testNames{4,e}];
            testNames_SE_DID{counter+2,2} = [testNames{3,e}];
            counter=counter+3;
        end
        if(p == 4)     
            testData_SE_DID{counter} = [testTopData{1,e};testBotData{4,e}];
            testData_SE_DID{counter+1} = [testTopData{2,e};testBotData{4,e}];
            testData_SE_DID{counter+2} = [testTopData{3,e};testBotData{4,e}];
            
            testLabels_SE_DID{counter} = [p;e];
            testLabels_SE_DID{counter+1} = [p;e];
            testLabels_SE_DID{counter+2} = [p;e];
            
            testNames_SE_DID{counter,1} = [testNames{1,e}];
            testNames_SE_DID{counter,2} = [testNames{4,e}];
            
            testNames_SE_DID{counter+1,1} = [testNames{2,e}];
            testNames_SE_DID{counter+1,2} = [testNames{4,e}];
            
            testNames_SE_DID{counter+2,1} = [testNames{3,e}];
            testNames_SE_DID{counter+2,2} = [testNames{4,e}];
            counter=counter+3;
        end
    end
    
end