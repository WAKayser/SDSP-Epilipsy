clear;

load('data_assignment.mat');
signal = EEG(12,:);

for t = 1:10
    sys1 = ar(signal(1:5000), t, 'yw', 'Ts', 1/250);
    error(t, 1) = sys1.Report.Fit.FitPercent;
    sys2 = ar(signal(12500:17500), t, 'yw', 'Ts', 1/250);
    error(t, 2) = sys2.Report.Fit.FitPercent;
end

hold off;
plot(1:10, (100 - error));
title('Error for different order AR models')
legend('Before seizure', 'During Seizure');
ylabel('Error (procent)')
xlabel('Filter Order')
set(gca,'FontSize',12)