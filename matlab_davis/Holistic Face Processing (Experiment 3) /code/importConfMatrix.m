function [humanConfusionMatrix] = importConfMatrix(trainNameMatrix)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    hR=readtable('/Users/Davis/Desktop/garyComposite/params/human-responses.txt','Delimiter',' ', 'ReadVariableNames',false);
    hR = hR(2:size(hR,1),:);
    
    hCM = {};   %hCM{name,[happy,sad,afraid,angry,surprised,disgusted]}
    for i = 1:size(hR,1)
        hCM{i,1} = hR.Var1{i};
        hCM{i,2} = [str2num(hR.Var4{i}) str2num(hR.Var5{i})...
            str2num(hR.Var7{i}) str2num(hR.Var2{i})...
            str2num(hR.Var3{i}) str2num(hR.Var6{i})];
    end
        
    humanConfusionMatrix = {};
    
    for i = 1:(size(trainNameMatrix,2)/3)   %trainNames will always be 3x size of actual set.
        counter = 0;
        for j = 1:size(hCM,1)
            
            if trainNameMatrix{i}(1) == '1'
                trainNameMatrix{i}(1) = '7';
            end
            
            if trainNameMatrix{i}(1) == '2'
                trainNameMatrix{i}(1) = '4';
            end
            
            if(strcmp(trainNameMatrix{i}(1:size(trainNameMatrix{i},2)-4),hCM{j,1}(2:size(hCM{j,1},2))))
                humanConfusionMatrix{i,1} = hCM{j,1}(2:size(hCM{j,1},2));
                humanConfusionMatrix{i,2} = hCM{j,2};
                counter = 1;
                continue;
            end
            
        end
        if(counter == 0 )
            display('ERROR.'); 
        end
    end
    
    nameVec = ['cc';'em';'jj';'mf';'mo';'nr';'pe';'pf';'sw';'wf'];
    
    for i = 1 : size(humanConfusionMatrix,1)
        count = 0;
        for j = 1 : size(nameVec,1)
            count = count + 1;
            if(humanConfusionMatrix{i,1}(2:3) == nameVec(j,:))
                break;
            end
        end
        humanConfusionMatrix{i,2} = [0,0,0,0,0,0,0,0,0,0,humanConfusionMatrix{i,2}(6), humanConfusionMatrix{i,2}(4), humanConfusionMatrix{i,2}(3)];
        humanConfusionMatrix{i,2}(count) = 1;
    end
end

