clear;
load('data_assignment.mat');
signal = EEG(12,:);

hold off;

before(1, 129) = 0;
during(1, 129) = 0;

for i = 1:20
   before = before + pwelch(signal(1+(i-1)*250:i*250))';   
end

for i = 1:20
   during = during + pwelch(signal(12501+(i-1)*250:12500+i*250))';   
end

plot(linspace(0, 125, 129), 10 * log10((before/50)));
hold on;
plot(linspace(0, 125, 129), 10  *log10((during/50)));
plot(linspace(0, 125, 129), 10  *log10((during/50)) - 10 * log10((before/50)));
legend('Before seizure','During seizure')
title('Averaged PSD at different times');