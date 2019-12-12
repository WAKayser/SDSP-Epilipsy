%%%%%%%%%% 
% Plotting the autocorrelation during different moments in time. 
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear; close all;

load('data_assignment.mat');
signal = EEG(12,:);

before(10, 999) = 0;
during(10, 999) = 0;

% Calculating the autocorrelation at different intervals
for i = 1:10
   before(i, :) = xcorr(signal(1+(i-1)*500:i*500));
   during(i, :) = xcorr(signal(12501+(i-1)*500:12500+i*500)); 
end

bias = xcorr(ones(500, 1));


% Plotting before seizure behaviour
subplot(211)
plot(linspace(-250, 250, 999), (before)./bias', 'color', 'blue');
title('Autocorrelation before a seizure')
ylabel('correlation (μV^2)');
xlim([-250 250])
xlabel('lags');
set(gca,'FontSize',16)
yline(0);
xlim([-250 250])

% Plotting behaviour during seizure. 
subplot(212)
plot(linspace(-250, 250, 999), (during)./bias', 'color', 'red');
title('Autocorrelation during a seizure');
ylabel('correlation (μV^2)');
xlabel('lags');
set(gca,'FontSize',16)
yline(0);
xlim([-250 250])
ylim([-3000 5000])
