function [x,e] = PageRankDistributed(M,x_star)
%La funzione ConsensusDistributed prende in input l'array di matrici.
[r,c] = size(M(:,:,1)); %serve a conoscere la dimensione della network
%nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
%la matrice distribuita ed usarla nel mio schema di update. 

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
threshold=0.0035; % usare 0.0035

for k=1:1:c
x(k) = 1/c;
end
y = zeros(c,1);
h3=figure('Name','Distributed: Convergence to Consensus of the first 4 elements')
h4=figure('Name','Distributed: Estimation Error')

for k=1:1:MAXITERATIONS %calcolo update come def in paragrafo 3.2
z=x';
%generazione indice random per la scelta di A_i o M_i
i = randi([1 r],1,1);
x = (M(:,:,i)*x')';
y = x' + y;
diff=norm(x'-z);
y_temp = y/double(k);
e = sum((y_temp -x_star).^2)/c;
norm1=norm(y_temp -x_star,1);
norm_inf=norm(y_temp -x_star,inf);

disp(diff)
%mostriamo l'evoluzione del vettore fino al raggiungimento del consensus
if(mod(k,30)==0)
figure(h3)
scatter(k,y(1)/double(k),'b'),hold on; %calcola la media parziale di y(k)
scatter(k,y(2)/double(k),'g');
scatter(k,y(3)/double(k),'r');
scatter(k,y(4)/double(k),'k');    
legend('node1','node2','node3','node4')

end

figure(h4)
scatter(k,e,'b'); hold on 
scatter(k,norm1,'g'); 
scatter(k,norm_inf,'r'); 
legend('mean square error','norm1','norm inf')


  if(diff<=threshold)
        break;
  end
end
disp(k)
disp(y)
y = y/double(k);
e = sum((y -x_star).^2)/c;


disp(y');

err=sprintf('error %.8f', e);
disp(err);
end
