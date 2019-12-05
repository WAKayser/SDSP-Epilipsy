%%%%%%%%%% 
% Code use for plotting the model error
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear;

load('data_assignment.mat');
signal = EEG(12,:);

% Getting the data for different model orders
for t = 1:10
    sys1 = ar(signal(4000:4500), t, 'gl', 'Ts', 1/250);
    error(t, 1) = sys1.Report.Fit.FitPercent;
    sys2 = ar(signal(15000:15500), t, 'gl', 'Ts', 1/250);
    error(t, 2) = sys2.Report.Fit.FitPercent;
end


% Plotting the errors. 
hold off;
plot(1:10, (100 - error), 'LineWidth', 2);
title('Error for different order AR models')
legend('Before seizure', 'During Seizure');
ylabel('Error (procent)')
xlabel('Filter Order')
set(gca,'FontSize',24)