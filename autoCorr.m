%%%%%%%%%% 
% Plotting the autocorrelation during different moments in time. 
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear; close all;

load('data_assignment.mat');
signal = EEG(12,:);

before(20, 499) = 0;
during(20, 499) = 0;

% Calculating the autocorrelation at different intervals
for i = 1:20
   before(i, :) = xcorr(signal(1+(i-1)*250:i*250));
   during(i, :) = xcorr(signal(12501+(i-1)*250:12500+i*250)); 
end

bias = xcorr(ones(250, 1));


% Plotting before seizure behaviour
subplot(211)
plot(linspace(-125, 125, 499), (before)./bias', 'color', 'blue');
title('Autocorrelation before a seizure')
ylabel('correlation (μV^2)');
xlim([-125 125])
xlabel('lags');
set(gca,'FontSize',16)
yline(0);
xlim([-125 125])

% Plotting behaviour during seizure. 
subplot(212)
plot(linspace(-125, 125, 499), (during)./bias', 'color', 'red');
title('Autocorrelation during a seizure');
ylabel('correlation (μV^2)');
xlabel('lags');
set(gca,'FontSize',16)
yline(0);
xlim([-125 125])
ylim([-3000 5000])
