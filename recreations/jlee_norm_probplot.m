function [MSE, R_sq] = jlee_norm_probplot(data, plot_display)

percentiles = 100*((1:length(data)) - 0.5)/length(data);
z_percentiles = zscore(percentiles);

mdl = fitlm(z_percentiles, data);

if plot_display == 1
    figure();
    plot(z_percentiles, data, 'o');
    hold on;
    plot(z_percentiles, mdl.Fitted,'r--');
    hold off;
    ylim([0 1]);
    xlabel('z score');
    ylabel('data values');
else
end
    
MSE = mdl.MSE;
R_sq = mdl.Rsquared.Ordinary;
disp(R_sq);

end