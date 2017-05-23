function [x,e] = PageRankDistributed(M,x_star)
%La funzione ConsensusDistributed prende in input l'array di matrici.
[r,c] = size(M(:,:,1)); %serve a conoscere la dimensione della network
%nel ciclo for, ad ogni istante k, devo richiamare la funzione che genera
%la matrice distribuita ed usarla nel mio schema di update. 

MAXITERATIONS= intmax('int64')-2; % il piu grande numero rappresentabile in Matlab
threshold=0.04/c; % usare 0.0035*N.elementi
elem=0;
total_time=0;
sz=5;
sz2=10;

for k=1:1:c
x(k) = 1/c;
end

y = zeros(c,1);
lambda = 10;
%generation of times' vector
rng('shuffle') %serve per far generare nuemri casuali ogni volta che riavviamo il programma altrimenti genera semrpe gli stessi
Timer=exprnd(lambda,c,1);
%Timer=random('Exponential',lambda,c,1);
%disp(Timer)

%usiamo distribuzione exp(NN,1,T) [Nx1] N = numero agents
for k=1:1:MAXITERATIONS %calcolo update come def in paragrafo 3.2
    %qui dentro calcolo il minimo sul set generato da exp() => chi parte
    %nell'istante
    [time_min,i]= min(Timer); 
    Timer= Timer-time_min;
    %rng('shuffle')
    Timer(i) = exprnd(lambda,1,1); %random('Exponential',lambda,1,1);  
    total_time= total_time+time_min;
    %disp(total_time)
    
    elem = elem +1;
    z=x';
    %generazione indice random per la scelta di A_i o M_i
    %i = randi([1 r],1,1);
    x = (M(:,:,i)*x')';
    y = x' + y;
    data(:,k) =y/double(k);
    diff=norm(x'-z);
    %%disp(diff);
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
figure('Name','Distributed')
subplot(2,1,1)
for r=1:1:c
    scatter(w,data(r,w),sz),hold on; %calcola la media parziale di y(k)
% scatter(w,data(2,w),'g');
% scatter(w,data(3,w),'r');
% scatter(w,data(4,w),'y');    
% legend('node1','node2','node3','node4')
end
title('Convergence to PageRank') %of the first 4 elements')
% % unita=' s';
disp(total_time);

%t1 = total_time/(24*60*60);
timeString = datestr(total_time/(24*60*60), ' DDg HH:MM:SS');
% % if(total_time>=60)
% %     total_time= total_time/60;
% %     unita=' min';
% %     if(total_time>=60)
% %     total_time= total_time/60;
% %     unita=' h';
% %     end
% % end
% % total_time= uint64(total_time); 
str = strcat('Elapsed time ',timeString);
dim = [.06 .22 .3 .3];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

subplot(2,1,2)
scatter(w,error,sz2,'b'); hold on 
scatter(w,vect_norm1,sz2,'g'); 
scatter(w,vect_norm_inf,sz2,'r');
set(gca,'yscale','log')
legend('mean square error','norm1','norm inf')
title('    Estimation Error')
% 
% disp(e)
err=sprintf('error %.8f', e);
disp(err);
disp(k);
disp(data(:,elem));
end
