clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 100;
stepSize = 100;
orderFilter = 4;
numSegments = ceil((length(signal)-segmentSize)/stepSize);

power(orderFilter + 1, numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    sys = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    power(:, t) = sys.A;
end

hold off;
plot(linspace(0, length(signal)/250, numSegments), power);
    names = num2str([1:(orderFilter + 1)]');
    
legend(names)