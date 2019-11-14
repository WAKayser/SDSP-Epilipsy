clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 1000;
stepSize = 250;
orderFilter = 4;

numSegments = ceil((length(signal)-segmentSize)/stepSize);

% segments = reshape(signal, segmentSize, numSegments);

sys1 = ar(signal(12500:17500), orderFilter, 'yw', 'Ts', 1/250);
sys2 = ar(signal(1:5000), orderFilter, 'yw', 'Ts', 1/250);

power(numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    power1(t) = norm(filter(1, sys1.A, signal(start:final)))/ segmentSize;
    power2(t) = norm(filter(1, sys2.A, signal(start:final)))/ segmentSize;
end
% 
hold off;
plot(linspace(0, length(signal)/250, numSegments), power1, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, numSegments), power2, 'LineWidth', 2);
plot(linspace(0, length(signal)/250, numSegments), power1 ./ power2, 'LineWidth', 2);
% plot(linspace(0, length(signal)/250, length(signal)), signal)

title('Captured seizure characteristic');
legend('Output power of AR model', 'Original signal');
