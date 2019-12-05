%%%%%%%%%% 
% Plotting the PSD during different moments in time. 
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%


clear; close all;

load('data_assignment.mat');
signal = EEG(12,:);

before(10, 499) = 0;
during(10, 499) = 0;


% calculating the PSD of the signal
for i = 1:10
   before(i, :) = abs(fft(xcorr(signal(1+(i-1)*250:i*250))));   
   during(i, :) = abs(fft(xcorr(signal(12501+(i-1)*250:12500+i*250))));   
end

bias = xcorr(ones(250, 1));

% Zoomed in view of the PSD, the rest is negligible. 
subplot(211)
plot(linspace(-125, 125, 499),(fftshift((before/50))./bias'), 'color', 'blue');
xlim([-20 20])
set(gca,'FontSize',16)
title('PSD overlay before a seizure');
xlabel('Frequency (Hz)')
ylabel('Magnitude (μV^2)')

subplot(212)
plot(linspace(-125, 125, 499),(fftshift((during/50))./bias'), 'color', 'red');
xlim([-20 20])
title('PSD overlay during a seizure');
set(gca,'FontSize',16)
xlabel('Frequency (Hz)')
ylabel('Magnitude (μV^2)')