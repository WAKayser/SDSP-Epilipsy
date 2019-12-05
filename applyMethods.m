%%%%%%%%%% 
% Applying the different suggest strategies 
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

% Load the required data
clear; close all;
load('data_assignment.mat'); signal = EEG(12,:);

% Parameters used for the experiments
segmentSize = 500;
stepSize = 50;
orderFilter = 4;
method = 'ls';
numSegments = ceil((length(signal)-segmentSize)/stepSize);

% Generation of all filter for the first two methods. 
sys1 = ar(signal(15000:15250), orderFilter, method, 'Ts', 1/250);
sys2 = ar(signal(1:250), orderFilter, method, 'Ts', 1/250);
filtered = filter(sys2.A, 1, signal);
sys3 = ar(filtered(15000:15250), orderFilter, method, 'Ts', 1/250);


for t = 1:numSegments
    % Defining the begin and end of the segment
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    
    % Finding the power in the segment after applying the first filter
    power1(t) = norm(filter(1, sys1.A, signal(start:final)))/ 250;
    % Findign the power in the segment after applying the filter on the
    % whitened signal
    power2(t) = norm(filter(sys2.A, sys3.A, filtered(start:final)));
    % Finding the AR model that describes that segment
    systemp = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    % Multiplying the ability to fit the signal with the required noise to
    % feed the model to get the signal. 
    power3(t) = systemp.Report.Fit.FitPercent*systemp.NoiseVariance;
end

% Plot approach one
subplot(311)
plot(linspace(0, length(signal)/250, numSegments), power1, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Single AR Filter results')
set(gca,'FontSize',16)
ylim([-100 200])
yline(85)
legend('Original Signal', 'Result of approach', 'Detector')

%Plot Approach 2
subplot(312)
plot(linspace(0, length(signal)/250, numSegments), power2, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Whitened AR Filter results')
set(gca,'FontSize',16)
ylim([-75 150])
yline(82)

% Plot Approach 3
subplot(313)
plot(linspace(0, length(signal)/250, numSegments), power3 / 10, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, length(signal)), signal)
ylabel('Amplitude (μV)')
xlabel('Time (s)')
title('Model Fitting approach')
set(gca,'FontSize',16)
ylim([-100 150])
yline(50)
