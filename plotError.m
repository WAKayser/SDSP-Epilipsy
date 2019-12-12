%%%%%%%%%% 
% Code use for plotting the model error
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear;

load('data_assignment.mat');
ws = 500;
signal = EEG(12,:);

% Getting the data for different model orders
for d = 1:10
    for t = 1:10
        sys1 = ar(signal(0+ws*d:ws+ws*d), t, 'gl', 'Ts', 1/250);
        error(t, d, 1) = sys1.Report.Fit.FitPercent;
        sys2 = ar(signal(12000+ws*d:12500+ws*d), t, 'gl', 'Ts', 1/250);
        error(t, d, 2) = sys2.Report.Fit.FitPercent;
    end
end


% Plotting the errors. 
hold off;
h  = plot(1:10, (100 - error(:, :, 1)), ':', 'LineWidth', 2, 'Color', 'r');
hold on;
handle(3) = plot(1:10, mean(100- error(:, :, 1), 2), 'LineWidth', 3, 'Color', 'r');
handle(1) = h(1);

h  = plot(1:10, (100 - error(:, :, 2)), ':', 'LineWidth', 2, 'Color', 'b');
handle(4) = plot(1:10, mean(100- error(:, :, 2), 2), 'LineWidth', 3, 'Color', 'b');

handle(2) = h(1);
title('Error for different order AR models')
legend(handle, {'Before seizure' 'Mean Before Seizure' 'During Seizure' 'Mean During Seizure'});
ylabel('Error (procent)')
xlabel('Filter Order')
set(gca,'FontSize',24)
xlim([1 10])