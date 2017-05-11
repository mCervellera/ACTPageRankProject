function [x,e] = PageRankDistributed(M,x_star)
%La funzione ConsensusDistributed prende in input l'array di matrici.
[r,c] = size(M(:,:,1)); %serve a conoscere la dimensione della network
%nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
%la matrice distribuita ed usarla nel mio schema di update. 

MAXITERATIONS = 1000;

for k=1:1:c
x(k) = 1/c;
end
y = zeros(c,1);
for k=1:1:MAXITERATIONS %calcolo update come def in paragrafo 3.2
z=x';
%generazione indice random per la scelta di A_i o M_i
i = randi([1 r],1,1);
x = (M(:,:,i)*z)';
y = x' + y;
stem(k,y(1)/k),hold on; %calcola la media parziale di y(k)
 %mostriamo l'evoluzione del vettore fino al raggiungimento del consensus
end
y = y/k;
e = sum((y -x_star).^2)/c;
disp(y');
%disp(e);
err=sprintf('error %.8f', e);
disp(err);
end
