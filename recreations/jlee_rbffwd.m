function [output] = jlee_rbffwd(inputs, nRBF, sigma, weights_rbf, weights_pcn, gating_type)

[num_examples, M] = size(inputs);
hidden = zeros(num_examples, nRBF);

for k = 1:nRBF
    euclid_distances = inputs - ones(num_examples, 1)*weights_rbf(:, k).';
    two_norm = sum(euclid_distances.^2, 2);
    hidden(:, k) = exp(-two_norm/(2*sigma.^2));
end

%hidden = softmax(hidden);
hidden = [hidden -ones(num_examples, 1)];

[output] = jlee_perceptron_forward(hidden, weights_pcn, gating_type);

end