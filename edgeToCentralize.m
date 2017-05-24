function y = edgeToCentralize( x )

% get the dimension of the edge vector in order to know dimension of
% the link matrix and inizialize it
n = max(max(x));

A = zeros(n);

%build the matrix using the edge vector
for i = 1:n
    numberOfOutlinks = size(find(x(:,1) == i), 1);
    outlinksIndexes = find(x(:,1) == i);
    for j = 1:numberOfOutlinks
        A(x(outlinksIndexes(j),2), i) = 1 / numberOfOutlinks;
    end
end

%output
y = A;


end

