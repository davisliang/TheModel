function [wrong, out] = feedforwards(weight, bias, input, label, show)

wrong = 0;  %boolean value for wrong
neto = weight*input+bias;
out = exp(neto)./sum(exp(neto));

[maximumValue, index_out] = max(out);   %we won't really use maximumValue
index_targ = label;

if(show==1)
    affectVector = {'afraid', 'angry', 'disgusted', 'happy', 'neutral', 'sad', 'suprised'};
    fprintf('the correct label is: %s (%i) \n', affectVector{label},label);
    fprintf('your chosen label is: %s (%i) \n', affectVector{index_out},index_out);
    out
end

if index_targ ~= index_out
    wrong = 1;
end

