clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 1000;
stepSize = 500;
orderFilter = 1;

numSegments = ceil((length(signal)-segmentSize)/stepSize);

% segments = reshape(signal, segmentSize, numSegments);

sys = ar(signal(13500:14000), orderFilter, 'yw', 'Ts', 1/250);

power(numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    power(t) = norm(filter(sys.A, 1, signal(start:final)));
end

hold off;
plot(linspace(0, length(signal)/250, numSegments), power, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, length(signal)), signal)


% wip
data = reshape(diff(power), 2, length(diff(power))/2);
[x, I] = max(data(1, :) + data(2, :));
xline(2 *(segmentSize/2 + I * stepSize)/250, 'LineWidth', 3, 'Color', 'green');


title('Captured seizure characteristic');
legend('Output power of AR model', 'Original signal');
