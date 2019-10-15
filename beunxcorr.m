clear;
load('data_assignment.mat');
signal = EEG(12,:);

hold off;

before(1, 199) = 0;
during(1, 199) = 0;

for i = 1:50
   before = before + abs(xcorr(signal(1+(i-1)*100:i*100)));   
end

for i = 1:50
   during = during + abs(xcorr(signal(12501+(i-1)*100:12500+i*100)));   
end

plot(before/50);
hold on;
plot(during/50);
set(gca, 'YScale', 'log');
ylim([1 10^8]);
legend('Before seizure','During seizure')
title('Averaged autocorrelation at different times');