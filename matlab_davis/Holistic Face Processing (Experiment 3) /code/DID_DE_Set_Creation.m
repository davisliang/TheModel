function [testData_DID_DE, testLabels_DID_DE, testNames_DID_DE] =...
    DID_DE_Set_Creation(testTopData,testBotData,testLabels,testNames)

numPeople = size(testTopData,1);
numEmotions = size(testTopData,2);

testData_DID_DE = {};
testLabels_DID_DE = {};
testNames_DID_DE = {};

%3 emotions, 4 people

counter = 1;
for p_top=1:numPeople
    for p_bot=1:numPeople
        if p_bot ~= p_top
            for e_top = 1:numEmotions
                for e_bot = 1:numEmotions
                    if(e_bot ~= e_top)
                        testData_DID_DE{counter} = [testTopData{p_top,e_top};testBotData{p_bot,e_bot}];
                        
                        testLabels_DID_DE{counter} = [p_bot;e_bot];
                        
                        testNames_DID_DE{counter,1} = [testNames{p_top,e_top}];
                        testNames_DID_DE{counter,2} = [testNames{p_bot,e_bot}];
                        
                        counter=counter+1;
                    end
                end
            end
        end
    end
end
