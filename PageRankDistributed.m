function [x,e] = PageRankDistributed(M,x_star)
%La funzione ConsensusDistributed prende in input l'array di matrici.
[r,c] = size(M(:,:,1)); %serve a conoscere la dimensione della network
%nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
%la matrice distribuita ed usarla nel mio schema di update. 

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
threshold=0.0035; % usare 0.0035
elem=0;

for k=1:1:c
x(k) = 1/c;
end
y = zeros(c,1);


for k=1:1:MAXITERATIONS %calcolo update come def in paragrafo 3.2
    elem = elem +1;
    z=x';
    %generazione indice random per la scelta di A_i o M_i
    i = randi([1 r],1,1);
    x = (M(:,:,i)*x')';
    y = x' + y;
    data(:,k) =y/double(k);
    diff=norm(x'-z);
    
    y_temp = y/double(k);
    e = sum((y_temp -x_star).^2)/c;
    error(k) = e; 
    norm1=norm(y_temp -x_star,1);
    vect_norm1(k)= norm1;
    norm_inf=norm(y_temp -x_star,inf);
    vect_norm_inf(k) = norm_inf;
   
    if(diff<=threshold)
        break;
  end
end
w= 1:1:elem;
%mostriamo l'evoluzione del vettore fino al raggiungimento del consensus
figure('Name','Distributed: Convergence to Consensus of the first 4 elements')
scatter(w,data(1,w),'b'),hold on; %calcola la media parziale di y(k)
scatter(w,data(2,w),'g');
scatter(w,data(3,w),'r');
scatter(w,data(4,w),'k');    
legend('node1','node2','node3','node4')

figure('Name','Distributed: Estimation Error')
scatter(w,error,'b'); hold on 
scatter(w,vect_norm1,'g'); 
scatter(w,vect_norm_inf,'r');
legend('mean square error','norm1','norm inf')
% 
% disp(e)


err=sprintf('error %.8f', e);
disp(err);
end
