clear;

load('data_assignment.mat');
signal = EEG(12,:);


plot(linspace(0, length(signal)/250, length(signal)), signal);
title('Example of EEG Signal with Seizure')
ylim([-150 150])
xline(39, 'r', 'Start of Seizure', 'FontSize', 14, 'LineWidth', 3)
ylabel('Amplitude (uV)')
xlabel('Time (s)')
set(gca,'FontSize',12)