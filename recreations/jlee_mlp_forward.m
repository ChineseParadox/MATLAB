function [output_final, output_hidden] = jlee_mlp_forward(input, weights_h, weights_o, gating_type)

if squeeze(input(:, end)) ~= -ones(size(input, 1), 1)
    input = [input -ones(size(input, 1), 1)];
else
end

output_hidden = jlee_perceptron_forward(input, weights_h, gating_type);
output_hidden = [output_hidden -ones(size(input, 1), size(weights_o, 2))];
output_final = jlee_perceptron_forward(output_hidden, weights_o, gating_type);

end