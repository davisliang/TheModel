function [testData_SID_DE, testLabels_SID_DE,testNames_SID_DE] =...
    SID_DE_Set_Creation(testTopData,testBotData,testLabels,testNames)
%same identity, different expressions
numPeople = size(testTopData,1);
numExpressions = size(testTopData,2);

testData_SID_DE = {};
testLabels_SID_DE = {};
testNames_SID_DE = {};
counter = 1;
for(p=1:numPeople)
    for(e=1:numExpressions)
        if(e == 1)     
            testData_SID_DE{counter} = [testTopData{p,2};testBotData{p,1}];
            testData_SID_DE{counter+1} = [testTopData{p,3};testBotData{p,1}];
            testLabels_SID_DE{counter} = [p;e];
            testLabels_SID_DE{counter+1} = [p;e];
            
            testNames_SID_DE{counter,1} = testNames{p,2};
            testNames_SID_DE{counter,2} = testNames{p,1};
            
            testNames_SID_DE{counter+1,1} = testNames{p,3};
            testNames_SID_DE{counter+1,2} = testNames{p,1};
            counter=counter+2;
        end
        if(e == 2)     
            testData_SID_DE{counter} = [testTopData{p,1};testBotData{p,2}];
            testData_SID_DE{counter+1} = [testTopData{p,3};testBotData{p,2}];
            testLabels_SID_DE{counter} = [p;e];
            testLabels_SID_DE{counter+1} = [p;e];
            
            testNames_SID_DE{counter,1} = testNames{p,1};
            testNames_SID_DE{counter,2} = testNames{p,2};
            
            testNames_SID_DE{counter+1,1} = testNames{p,3};
            testNames_SID_DE{counter+1,2} = testNames{p,2};
            counter=counter+2;
        end
        if(e == 3)     
            testData_SID_DE{counter} = [testTopData{p,1};testBotData{p,3}];
            testData_SID_DE{counter+1} = [testTopData{p,2};testBotData{p,3}];
            
            testLabels_SID_DE{counter} = [p;e];
            testLabels_SID_DE{counter+1} = [p;e];
            
            testNames_SID_DE{counter,1} = testNames{p,1};
            testNames_SID_DE{counter,2} = testNames{p,3};
            
            testNames_SID_DE{counter+1,1} = testNames{p,2};
            testNames_SID_DE{counter+1,2} = testNames{p,3};
            counter=counter+2;
        end
    end
end
