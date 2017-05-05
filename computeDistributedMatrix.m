function y = computeDistributedMatrix( x )

n = size(x,1)

for i = 1:n
    %inizializzazione di A
    A(:,:,i) = zeros(n);
    
    for j = 1:n
        for l = 1:n
            if j == i || l == i
                A(j,l,i) = x(j,l);
            elseif j == l
                A(j,l,i) = 1 - x(i,l);
            end
        end
    end
end

y = A;

end

