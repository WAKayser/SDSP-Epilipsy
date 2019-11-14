clear;
% close all;

load('data_assignment.mat');
signal = EEG(15,:);

segmentSize = 250;
stepSize = 100;
orderFilter = 4;
numSegments = ceil((length(signal)-segmentSize)/stepSize);

power(numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    sys = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    power(t) = sys.Report.Fit.FitPercent*sys.NoiseVariance;
end

hold on;
plot(linspace(0, length(signal)/250, numSegments), power/5);
plot(linspace(0, length(signal)/250, length(signal)), signal);
legend('NoiseVariance combined with inverse of model error', 'Original Signal')
    
title('Model Fitting Estimator for Seizures')
ylabel('Amplitude')
xlabel('Time (s)')
set(gca,'FontSize',12)