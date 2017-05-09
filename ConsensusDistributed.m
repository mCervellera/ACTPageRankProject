<<<<<<< HEAD
function [ x,x1 ] = ConsensusDistributed(M)
    %La funzione ConsensusDistributed prende in input l'array di matrici.
    m=0.15;
    [r,c] = size(M); %serve a conoscere la dimensione della network
    %nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
    %la matrice distribuita ed usarla nel mio schema di update.
    i = randi([1 r],1,1); %generazione indice random per la scelta di A_i o M_i
    for k=1:1:c
        x(k) = 1/c;
    end
    for k=1:1:c
        x1(k) = 1/c;
    end
    for k=1:1:100 %calcolo update come def in paragrafo 3.2
        z=x;
        x = M(i)*z; 
        disp(x) %mostriamo l'evoluzione del vettore fino al raggiungimento del consensus
    end
    for k=1:1:100 %calcolo update come def in paragrafo 3
        z=x1;
        x1 = (1-m)* M(i)*z + (m/r)*ones(r);
        disp(x1) %mostriamo l'evoluzione del vettore fino al raggiungimento del consensus
    end
=======
function [x,e] = ConsensusDistributed(M,x_star)
%La funzione ConsensusDistributed prende in input l'array di matrici.
[r,c] = size(M(:,:,1)); %serve a conoscere la dimensione della network
%nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
%la matrice distribuita ed usarla nel mio schema di update. 
for k=1:1:c
x(k) = 1/c;
end
y = zeros(c,1);
for k=1:1:1000 %calcolo update come def in paragrafo 3.2
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
>>>>>>> origin/master
end
