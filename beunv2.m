clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 250;
stepSize = 100;
orderFilter = 4;

numSegments = ceil((length(signal)-segmentSize)/stepSize);

% segments = reshape(signal, segmentSize, numSegments);

sys1 = ar(signal(12500:15000), 4, 'yw', 'Ts', 1/250);
sys2 = ar(signal(1:5000), 3, 'yw', 'Ts', 1/250);

power(numSegments) = 0;

filtered = filter(sys2.A, 1, signal);
sys3 = ar(filtered(12500:17500), 4, 'yw', 'Ts', 1/250);

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    power1(t) = norm(filter(1, sys1.A, signal(start:final)))/ 250;
        power2(t) = norm(filter(sys2.A, sys3.A, filtered(start:final)));
%         power3(t) = norm(filter(1, sys1.A, filtered(start:final)))/ 250;
end
% 
hold off;
plot(linspace(0, length(signal)/250, numSegments), power1, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, numSegments), power2, 'LineWidth', 2);
% plot(linspace(0, length(signal)/250, numSegments), power3 ./ power1, 'LineWidth', 2);
plot(linspace(0, length(signal)/250, length(signal)), signal)

title('Captured seizure characteristic');
legend('Output power of AR model', 'Output Power of whitened AR model', 'Original signal');
ylabel('Amplitude (μV)')
xlabel('Time (s)')
set(gca,'FontSize',12)
