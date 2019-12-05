%%%%%%%%%% 
% Plotting the signal under investigation
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear; close all;
load('data_assignment.mat');
% Signal that willmainly be investigated. 
signal = EEG(12,:);

plot(linspace(0, length(signal)/250, length(signal)), signal);
title('Example of EEG Signal with Seizure')
ylim([-150 150])
xline(39, 'r', 'Start of Seizure', 'FontSize', 24, 'LineWidth', 3)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
set(gca,'FontSize',24)