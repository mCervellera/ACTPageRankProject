function y = computeM( x )

%get the dimension of the matrix
n = size(x,1);
%use m as paper
m = 0.15;
if size(size(x), 2) == 2
%Implementation of M for a single link matrix
        S = ones(n);
        M = (1 - m)*x + m/n*S;

elseif size(size(x),2) == 3
    m = (2*m)/(n-(m*(n-2)));
    for i = 1:n
    
    %Implementation of M for an array of matrixes
        
        S = ones(n);
        M(:,:,i) = (1 - m)*x(:,:,i) + m/n*S;
    end
end

y = M;
end

