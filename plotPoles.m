clear;

load('data_assignment.mat');
signal = EEG(12,:);

segmentSize = 1000;
stepSize = 500;
orderFilter = 4;
numSegments = ceil((length(signal)-segmentSize)/stepSize);

power(orderFilter, numSegments) = 0;
g(orderFilter, numSegments) = 0;

for t = 1:numSegments
    start = 1 + (t-1) * stepSize;
    final = segmentSize + (t-1) * stepSize;
    sys = ar(signal(start:final), orderFilter, 'yw', 'Ts', 1/250);
    [f, power(:, t), g(:, t)] = tf2zp(sys.NoiseVariance, sys.A);
end

hold off;
plot(linspace(0, length(signal)/250, numSegments), abs(power));
    names = num2str([1:(orderFilter)]');
    
legend(names)