function [normalized_data] = jlee_standard_normalize(data, mu, sigma)

nData = size(data, 1);

mean_matrix = ones(nData, 1)*mu;
std_matrix = ones(nData, 1)*sigma;

normalized_data = (data - mean_matrix)./std_matrix;

end