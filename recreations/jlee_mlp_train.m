function [output_final, weights_hidden, weights_output] = jlee_mlp_train(input, target, nHidden, eta, iterations, gating_type)

[num_examples, M] = size(input);
input = [input -ones(num_examples, 1)];
[num_examples, N] = size(target);
if num_examples < N
    target = target.';
    [num_examples, N] = size(target);
else
end
weights_hidden = 2/sqrt(M)*rand(M + 1, nHidden) - 1/sqrt(M);
weights_output = 2/sqrt(M)*rand(nHidden + 1, N) - 1/sqrt(M);

for t = 1:iterations
    
    [output_final, output_hidden] = jlee_mlp_forward(input, weights_hidden, weights_output, gating_type);
    
    switch gating_type
        case 'linear'
            error_output = (target - output_final)/num_examples;
        case 'logistic'
            error_output = (target - output_final).*output_final.*(1 - output_final);
        case 'binary'
            error_output = (target - output_final);
            
    error_hidden = output_hidden.*(1 - output_hidden).*(error_output*weights_output.');
    weights_output = weights_output + eta*output_hidden.'*error_output;
    weights_hidden = weights_hidden + eta*input.'*error_hidden(:, 1:(size(error_hidden, 2) - 1));
    
end

end