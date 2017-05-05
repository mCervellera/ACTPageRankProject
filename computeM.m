function y = computeM( x )

n = size(x,1)

if size(size(x), 2) == 2

%implementazione di M
        m = 0.15;
        S = ones(n);
        M = (1 - m)*x + m/n*S;

elseif size(size(x),2) == 3
    for i = 1:n

    %implementazione di M per array di matrici
        m = 0.15;
        S = ones(n);
        M(:,:,i) = (1 - m)*x(:,:,i) + m/n*S;
    end
end

y = M;
end

