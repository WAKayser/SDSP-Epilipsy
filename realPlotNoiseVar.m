%%%%%%%%%% 
% KPSS test of all EEG Signals
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear; close all;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 500;
stepSize = 100;
orderFilter = 4;
numSegments = ceil((length(signal)-segmentSize)/stepSize);

power(numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    sys = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    power(t) = sys.NoiseVariance;
end

plot(linspace(0, length(signal)/250, numSegments), power, 'LineWidth', 2);    
title('Noise variance given by AR model')
ylabel('Noise variance')
xlabel('Time (s)')
set(gca,'FontSize',24)