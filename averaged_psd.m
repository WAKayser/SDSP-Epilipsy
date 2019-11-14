clear;
load('data_assignment.mat');
signal = EEG(12,:);

hold off;

before(1, 499) = 0;
during(1, 499) = 0;

for i = 1:20
   before = before + abs(fft(xcorr(signal(1+(i-1)*250:i*250))));   
end

for i = 1:20
   during = during + abs(fft(xcorr(signal(12501+(i-1)*250:12500+i*250))));   
end

plot(linspace(-125, 125, 499), 10 * log10(fftshift((before/50))));
hold on;
plot(linspace(-125, 125, 499), 10  *log10(fftshift((during/50))));

plot(linspace(-125, 125, 499), 10  *log10(fftshift((during/50))) -  10 * log10(fftshift((before/50))));
legend('Before seizure','During seizure')
title('Averaged PSD at different times');
set(gca,'FontSize',12)