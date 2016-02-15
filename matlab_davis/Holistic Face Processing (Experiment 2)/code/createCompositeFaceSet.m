%% this function will first create the composite half faces 
function [compositeFaces, finalLabels, compositeNames] = createCompositeFaceSet(dataset,names)
% topbotLabel: which half of the face NOT to blur. 1 for top, 0 for bot
% compositeLabel: is the label for each compositeFace and noncompositeFace (same
% labels)
% compositeFaces, noncompositeFaces are the _x_ dataset of faces where 

%the cutoff row is at 40% of the size of the image.
numImages = size(dataset, 2);
imageHeight = size(dataset{1},1);
cutoff = round(imageHeight*0.4);

%% for the labels that correspond to sad afraid and angry, save top half
person = 1;
n=0;
for i = 1:numImages
    if (i==17)
        n=n+1;
    end
    
    topData{person,ceil(i/4)+n} = dataset{i}(1:cutoff,:);
    if(person==4)
        person=0;
    end
    
    person=person+1;
end

%get the entire 5th column to be empty. shift data right.


% bot: happy, surprised, disgusted.

%% 

%% for the labels that correspond to happy surprised and disgusted, save the bottom half
person = 1;
n=0;
for i = 1:numImages
    if (i==17)
        n=n+1;
    end
    
    botData{person,ceil(i/4)+n} = dataset{i}(cutoff+1:imageHeight,:);
    if(person==4)
        person=0;
    end
    
    person=person+1;
end




%% create labels for permutation processing
numEmotions = 7;
numPeople = 4;
finalLabels = {};
for pers = 1:numPeople
    i=1; 
    for top = 1:numEmotions
        for bot = 1:numEmotions     
            if((top==1||top==2||top==6)&&(bot==3||bot==4||bot==7))
                finalLabels{pers,i} = [top; bot];
                compositeFaces{pers,i} = [topData{pers,top};botData{pers,bot}];
                compositeNames{pers,i} = names{pers};
                i = i+1;
            end
        end
    end
end


   


%% do permutation processing and append halves together, do the same thing and make noncomposite faces with mismatched stitching.
%save labels for top and bot biases. Total number of images should be the
%same as original set... except now we have 2 sets of labels to describe
%the data.


%% fix the label assignments and output a label set for this new dataset. use this dataset and labelset to test on!
% make sure that your top biased images are labeled by their top and the
% bottom biased images are labeled by their bottom in a separate labelset
% so that we can know which half the multiply by 0.125


