function y = edgeToDistributed(x)

n = max(max(x));

A = zeros(n);

%scorre l'array

for i = 1:n
    numberOfOutlinks = size(find(x(:,1) == i), 1);
    outlinksIndexes = find(x(:,1) == i);
    for j = 1:numberOfOutlinks
        A(x(outlinksIndexes(j),2), i) = 1 / numberOfOutlinks;
    end
end

%implementazione di M
m = 0.15;
S = ones(n);
M = (1 - m)*A + m/n*S;

%output
y = M;


end

