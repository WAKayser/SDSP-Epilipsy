clear;
load('data_assignment.mat');
signal = EEG(12,:);

hold off;

before(1, 499) = 0;
during(1, 499) = 0;

for i = 1:20
   before = before + xcorr(signal(1+(i-1)*250:i*250));
   during = during + xcorr(signal(12501+(i-1)*250:12500+i*250)); 
end

bias = xcorr(ones(250, 1));

plot(linspace(-125, 125, 499), 10 * log10((before)./bias'));
hold on;
plot(linspace(-125, 125, 499), 10 * log10((during)./bias'));
legend('Before seizure','During seizure')
title('Autocorrelation at different times');
ylabel('correlation (dB)');
xlabel('lags');
set(gca,'FontSize',12)