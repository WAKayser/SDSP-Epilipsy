%%%%%%%%%% 
% Applying the different suggest strategies 
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

% Load the required data
clear; close all;
load('data_assignment.mat'); signal = EEG(15,:);

% Parameters used for the experiments
segmentSize = 500;
stepSize = 50;
orderFilter = 4;
method = 'ls';
numSegments = ceil((length(signal)-segmentSize)/stepSize);

% Generation of all filter for the first two methods. 
sys1 = ar(signal(15000:15500), orderFilter, method, 'Ts', 1/250);
sys2 = ar(signal(1:500), orderFilter, method, 'Ts', 1/250);
filtered = filter(sys2.A, 1, signal);
sys3 = ar(filtered(15000:15500), orderFilter, method, 'Ts', 1/250);


for t = 1:numSegments
    % Defining the begin and end of the segment
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    
    % Finding the power in the segment after applying the first filter
    power1(t) = norm(filter(1, sys1.A, signal(start:final)))^2;
    % Findign the power in the segment after applying the filter on the
    % whitened signal
    power2(t) = norm(filter(sys2.A, sys3.A, filtered(start:final)))^2;
    % Finding the AR model that describes that segment
    systemp = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    % Multiplying the ability to fit the signal with the required noise to
    % feed the model to get the signal. 
    power3(t) = systemp.Report.Fit.FitPercent*systemp.NoiseVariance;
end

% Plot approach one
subplot(311)
yyaxis left;
plot(linspace(0, length(signal)/250, numSegments), power1 / 10^6, 'LineWidth', 2);
% ylim([-5*10^3 5*10^3]) % Channel 12
ylim([-1000 1000]) % channel 15
hold on;
ylabel('Power (mV^2)')
yyaxis right;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Single AR Filter results')
set(gca,'FontSize',16)
ylim([-150 150])
yyaxis left;
% yline(1500, 'LineWidth', 2) %Channel 12: 1000
yline(250, 'LineWidth', 2) % channel 15
legend('Result of Approach', 'Detector', 'Original Signal')

%Plot Approach 2
subplot(312)
yyaxis left;
plot(linspace(0, length(signal)/250, numSegments), power2, 'LineWidth', 2);
hold on;
ylabel('Power (μV^2)')
% ylim([-15000 15000]) % channel 12
ylim([-250000 250000]) % channel 15
yyaxis right;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Whitened AR Filter results')
set(gca,'FontSize',16)
ylim([-150 150])
yyaxis left;
% yline(5500, 'LineWidth', 2) %Channel 12
yline(50000, 'LineWidth', 2) % channel 15

% Plot Approach 3
subplot(313)
yyaxis left;
plot(linspace(0, length(signal)/250, numSegments), power3, 'LineWidth', 2);
% ylim([-1800 1800]) % channel 12
ylim([-3000 3000]) % channel 15
hold on;
ylabel('Power (μV^2)')
yyaxis right;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Model Fitting approach')
set(gca,'FontSize',16)
ylim([-150 150])
yyaxis left;
yline(400, 'LineWidth', 2) %channel 12: 400
