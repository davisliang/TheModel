function [teDat,teLab,teNa] = parseSet(data,labels,names,holdOut)
    
%Desc:  Parses dataset into training set and test set
%in:    compositeData       (4x9 cell of 256x256 matrices)
%       compositeLabels     (4x9 cell of 2x1 matrices)
%       compositeNames      (4x9 cell of String)
%       holdOut             (String)
%out:   teDat               (1x9 cell of 256x256 matrices)
%       teLab               (1x9 cell of 2x1 matrices)

%% Procedure for parsing the 4x9 matrix into a 3x9 training matrix and a 1x9 test matrix
%  PROCEDURE:   First you need to find the ROW of names that are the hold out
%               Next, you need to take that ROW and make it the test set


    testRow = 0;
    for testRow = 1:size(names,1)
        if names{testRow,1}(2:3) == holdOut
            break;
        end
    end
    
    teDat = data([testRow],:);                                              %here lives the entire train set of 27 faces
    teLab = labels([testRow],:);
    teNa = names([testRow],:);
    
end