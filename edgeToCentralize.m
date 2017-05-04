function y = edgeToCentralize( x )

n = max(max(x))

A = zeros(n);

%scorre l'array

for i = 1:n
    numberOfOutlinks = size(find(x(:,1) == i), 1);
    outlinksIndexes = find(x(:,1) == i);
    for j = 1:numberOfOutlinks
        A(x(outlinksIndexes(j),2), i) = 1 / numberOfOutlinks;
    end
end
y = A;


end

