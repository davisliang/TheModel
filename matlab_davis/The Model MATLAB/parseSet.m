function [trDat,teDat,trLab,teLab,trNa,teNa] = parseSet(data,labels,names,holdOut)

    countTest = 0;
    countTrain = 0;
    for i = 1:size(names,2)
        if(names{i}(2:3) == holdOut)
            countTest = countTest + 1;
            teLab{countTest} = labels{i};
            teNa{countTest} = names{i};
            teDat{countTest} = data{i};
        else
            countTrain = countTrain + 1;
            trLab{countTrain} = labels{i};
            trNa{countTrain} = names{i};
            trDat{countTrain} = data{i};
    end


end