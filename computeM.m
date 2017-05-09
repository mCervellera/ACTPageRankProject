function y = computeM( x )

n = size(x,1) %restituisce 1° dimensione di A => righe
m = 0.15;
if size(size(x), 2) == 2 %restituisce 2° dim di A => colonne
%implementazione di M
        S = ones(n);
        M = (1 - m)*x + m/n*S;

elseif size(size(x),2) == 3
    m = (2*m)/(n-(m*(n-2)));
    for i = 1:n
    
    %implementazione di M per array di matrici
        
        S = ones(n);
        M(:,:,i) = (1 - m)*x(:,:,i) + m/n*S;
    end
end

y = M;
end

