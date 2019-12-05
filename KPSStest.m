%%%%%%%%%% 
% KPSS test of all EEG Signals
% Wouter Kayser and Karen van der Werff 2019
%%%%%%%%%%

clear; load('data_assignment.mat');

% Try multiple window sizes
for i = 1:48
    segmentSize = i*50 + 100;
    numSegments = ceil((length(EEG)-segmentSize)/segmentSize);
   
    for d = 1:21
        for t = 1:numSegments
            start = 1 + (t-1) * segmentSize;
            final = segmentSize + (t-1) * segmentSize;
            % KPSS test implemented by matlab
            x(t, d) = kpsstest(signal(d, start:final), 'alpha', 0.01);
        end
    end
    % Final result per window size
    kpss(i) = mean(x, [1, 2]);
end

plot(150:50:2500, kpss * 100, 'LineWidth', 2)
ylabel("Stationarity assumed (Percent)")
xlabel("Window Size (samples)")
title("KPSS Test for stationarity")
set(gca,'FontSize',24)