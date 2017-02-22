function [groupings, centers] = jlee_k_means(XData, K, nIterations)

[nData, ~] = size(XData);
indices_Shuffle = randperm(nData);
indices_Shuffle = indices_Shuffle(1:K);

centers = XData(indices_Shuffle, :);

distFromCenters = zeros(nData, K);

for n = 1:nIterations
    for k = 1:K
        current_centroid_matrix = ones(nData, 1)*centers(k, :);
        distFromCenters(:, k) = sqrt(sum((current_centroid_matrix - XData).^2, 2));
    end

    [~, groupings] = min(distFromCenters, [], 2);

    for k = 1:K
        centers(k, :) = mean(XData((groupings == k), :));
    end
end

end