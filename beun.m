clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 750;
orderFilter = 1;

numSegments = ceil(length(signal)/segmentSize);
signal(segmentSize*numSegments) = 0;

segments = reshape(signal, segmentSize, numSegments);

sys = ar(signal(10000:17500), orderFilter, 'yw', 'Ts', 1/250);

power(numSegments) = 0;

for t = 1:numSegments
    power(t) = norm(filter(sys.A, 1, segments(:, t)));
end

hold off;
plot(linspace(0, length(signal)/250, numSegments), power, 'LineWidth', 2);
hold on;
plot(linspace(0, length(signal)/250, length(signal)), signal)

[x, I] = max(diff(power));
xline((I-1) * segmentSize / 250, 'LineWidth', 3, 'Color', 'green');


title('Captured seizure characteristic');
legend('Output power of AR model', 'Original signal', 'Estimated start');
