function [wrong, out] = feedforwards(weight, bias, input, label, show)

wrong = 0;  %boolean value for wrong
neto = weight*input+bias;
out = exp(neto)./sum(exp(neto));

[maximumValuePerson, index_out_person] = max(out(1:10));   %we won't really use maximumValue
[maximumValueEmotion, index_out_emotion] = max(out(11:13));

index_targ = label;

if(show==1)
    affectVector = {'afraid', 'angry', 'disgusted', 'happy', 'neutral', 'sad', 'suprised'};
    fprintf('the correct label is: (%i, %i) \n', label(1), label(2));
    fprintf('your chosen label is:(%i, %i) \n', index_out_person, index_out_emotion);
    out
end

if index_targ(1) ~= index_out_person || index_targ(2) ~= index_out_emotion
    wrong = 1;
end

