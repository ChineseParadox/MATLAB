function [mean_dev_data, mu, sigma] = jlee_mean_dev_form(data)

[nData, nFeatures] = size(data);
if nData < nFeatures
    data = data.';
    [nData, nFeatures] = size(data);
else
end

mu = mean(data, 1);
sigma = std(data, 1, 1);

data_mean = ones(nData, 1)*mu;
data_std = ones(nData, 1)*sigma;
mean_dev_data = (data - data_mean)./data_std;

end