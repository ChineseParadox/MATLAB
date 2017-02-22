function [outputs, weights_rbf, weights_pcn, hidden, sigma] = jlee_rbftrain(inputs, targets, nRBF, sigma_input, eta, iterations, gating_type)

[nData, nIn] = size(inputs);
if sigma_input == 0
    sigma = max((max(inputs, [], 1) - min(inputs, [], 1)))/sqrt(2*nRBF);
else
    sigma = sigma_input;
end

weights_rbf = zeros(nIn, nRBF);
hidden = zeros(nData, nRBF + 1);

new_order = randperm(nData);
for k = 1:nRBF
    weights_rbf(:, k) = squeeze(inputs(new_order(k), :));
    euclid_distances = inputs - ones(nData, 1)*weights_rbf(:, k).';
    two_norm = sum(euclid_distances.^2, 2);
    hidden(:, k) = exp(-two_norm/(2*sigma.^2));
end

%hidden(:, 1:nRBF) = softmax(:, 1:nRBF);
[outputs, weights_pcn] = jlee_perceptron_train(hidden(:, 1:nRBF), targets, eta, iterations, gating_type);

end