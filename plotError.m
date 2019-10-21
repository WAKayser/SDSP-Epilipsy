clear;

load('data_assignment.mat');
signal = EEG(12,:);

for t = 1:20
    sys = ar(signal, t, 'yw', 'Ts', 1/250);
    error(t) = sys.Report.Fit.FitPercent;
end

hold off;
plot(1:20, (100 - error)/100);
title('AR Filter order testing')