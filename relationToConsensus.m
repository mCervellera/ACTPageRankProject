function y = edgeToDistributed(x)
%script che calcola la matrice di adiacenza per il consenso distribuito
n = max(max(x));

for i = 1:n
    %inizializzazione di A
    A(:,:,i) = zeros(n);
    
    %calcolo del subset di E interessato
    %Estrazione indici dove è presente i nella prima colonna
    E1 = find(x(:,1) == i);
    %nella seconda colonna
    E2 = find(x(:,2) == i);
    %dove sono uguali
    E3 = find(x(:,1) == x(:,2));
    E = union(E1,E2);
    E = union(E, E3);
    
    sizeOfE = size(E);
    
    Ei = x(E, :);
    
    %numero di agenti entranti in j da Ei
    
    for j = 1:sizeOfE
        nij = size(find(Ei(:,2) == Ei(j,2)));
        A(Ei(j,2),Ei(j,1),i) = 1/nij(1);
    end

end
    
y = A;

end
